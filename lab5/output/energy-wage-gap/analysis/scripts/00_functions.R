# 00_functions.R — shared helpers for the OEWS renewable wage-gap analysis.
# Sourced by later scripts; performs no I/O beyond reading the CPI reference file.

suppressMessages({
  library(dplyr)
  library(tidyr)
  library(fixest)
})

SEED <- 20260930
YEARS <- 2021:2025
RENEWABLE_NAICS <- c("221111", "221114", "221115", "221116", "221117")
NONRENEWABLE_NAICS <- c("221112", "221113")
OTHER_NAICS <- "221118"
TOPCODE <- c(`2021` = 208000, `2022` = 239200, `2023` = 239200, `2024` = 239200, `2025` = 239200)
TOPCODE_HOURLY <- c(`2021` = 100, `2022` = 115, `2023` = 115, `2024` = 115, `2025` = 115)
EQUIV_MARGIN <- 0.05

tech_label <- function(naics) {
  dplyr::recode(naics,
    "221111" = "Hydroelectric", "221112" = "Fossil fuel", "221113" = "Nuclear",
    "221114" = "Solar", "221115" = "Wind", "221116" = "Biomass/geothermal",
    "221117" = "Biomass/geothermal", "221118" = "Other")
}

soc_major_label <- function(code2) {
  lab <- c(
    "11" = "Management", "13" = "Business and financial operations",
    "15" = "Computer and mathematical", "17" = "Architecture and engineering",
    "19" = "Life, physical, and social science", "21" = "Community and social service",
    "23" = "Legal", "25" = "Educational instruction", "27" = "Arts, design, media",
    "29" = "Healthcare practitioners", "31" = "Healthcare support",
    "33" = "Protective service", "35" = "Food preparation and serving",
    "37" = "Building and grounds cleaning and maintenance", "39" = "Personal care and service",
    "41" = "Sales and related", "43" = "Office and administrative support",
    "45" = "Farming, fishing, and forestry", "47" = "Construction and extraction",
    "49" = "Installation, maintenance, and repair", "51" = "Production",
    "53" = "Transportation and material moving")
  unname(lab[code2])
}

occ_class_of <- function(code2) {
  dplyr::case_when(
    code2 %in% c("11", "13", "15", "17", "19") ~ "Professional and managerial",
    code2 %in% c("47", "49", "51", "53") ~ "Blue-collar trades",
    code2 == "43" ~ "Office and administrative support",
    TRUE ~ "Other occupations")
}

occ_class5_of <- function(code2) {
  dplyr::case_when(
    code2 == "11" ~ "Managers",
    code2 %in% c("13", "15", "17", "19") ~ "Professional and technical",
    code2 %in% c("47", "49", "51", "53") ~ "Blue-collar trades",
    code2 == "43" ~ "Office and administrative support",
    TRUE ~ "Other occupations")
}

read_cpi <- function(path = "analysis/reference/cpi_u_may.csv") {
  cpi <- read.csv(path)
  stopifnot(all(YEARS %in% cpi$year))
  setNames(cpi$cpi_u_nsa, cpi$year)
}

# Numeric parse of OEWS fields: '#' -> top code (flagged separately), '*'/'**' -> NA.
parse_wage <- function(x, year, hourly = FALSE) {
  tc <- if (hourly) TOPCODE_HOURLY[as.character(year)] else TOPCODE[as.character(year)]
  out <- suppressWarnings(as.numeric(x))
  out[!is.na(x) & x == "#"] <- tc[!is.na(x) & x == "#"]
  out
}

# ---- Restricted wild cluster bootstrap (WCR) for one linear restriction R'b = r ----
# Works on a fixest WLS model by Frisch-Waugh-Lovell: y and X are demeaned on the
# model's fixed effects (weighted), the restriction is imposed, and wild weights
# (Webb six-point) are applied to cluster-level restricted residuals. Returns the
# original CR-type t statistic and the bootstrap two-sided p-value. The CR1 small-
# sample factor is identical across draws and cancels in the p-value.
webb_draws <- function(G, B) {
  vals <- c(-sqrt(3 / 2), -1, -sqrt(1 / 2), sqrt(1 / 2), 1, sqrt(3 / 2))
  matrix(sample(vals, G * B, replace = TRUE), nrow = G, ncol = B)
}

wcr_test <- function(model, data, R, r = 0, cluster, B = 9999, seed = SEED) {
  set.seed(seed)
  obs <- obs(model)                       # rows of `data` used by the model
  d <- data[obs, , drop = FALSE]
  w <- if (is.null(weights(model))) rep(1, nrow(d)) else d$emp
  X <- model.matrix(model, type = "rhs")
  y <- model.matrix(model, type = "lhs")
  stopifnot(nrow(X) == nrow(d), length(y) == nrow(d))
  fe_names <- model$fixef_vars
  if (length(fe_names)) {
    fe <- lapply(fe_names, function(f) {
      parts <- strsplit(f, "\\^")[[1]]
      interaction(d[, parts, drop = FALSE], drop = TRUE)
    })
    dm <- fixest::demean(cbind(y, X), f = fe, weights = w)
    y <- dm[, 1]; X <- dm[, -1, drop = FALSE]
  }
  X <- as.matrix(X); y <- as.numeric(y)
  keep <- colSums(abs(X)) > 1e-10
  R <- R[keep]; X <- X[, keep, drop = FALSE]
  cl <- factor(d[[cluster]])
  G <- nlevels(cl)
  XtWX <- crossprod(X * w, X)
  Ainv <- solve(XtWX)
  b <- as.numeric(Ainv %*% crossprod(X * w, y))
  cr_se <- function(bb, yy) {
    u <- yy - as.numeric(X %*% bb)
    S <- rowsum(X * (w * u), cl)
    V <- Ainv %*% crossprod(S) %*% Ainv
    sqrt(as.numeric(t(R) %*% V %*% R))
  }
  t0 <- (sum(R * b) - r) / cr_se(b, y)
  # restricted estimate under H0
  RAR <- as.numeric(t(R) %*% Ainv %*% R)
  b_r <- b - as.numeric(Ainv %*% R) * (sum(R * b) - r) / RAR
  u_r <- y - as.numeric(X %*% b_r)
  fit_r <- as.numeric(X %*% b_r)
  V <- webb_draws(G, B)
  cl_idx <- as.integer(cl)
  tstar <- numeric(B)
  AXw <- Ainv %*% t(X * w)
  for (bb in seq_len(B)) {
    ystar <- fit_r + u_r * V[cl_idx, bb]
    bstar <- as.numeric(AXw %*% ystar)
    tstar[bb] <- (sum(R * bstar) - r) / cr_se(bstar, ystar)
  }
  list(estimate = sum(R * b), t = t0, p_wcr = mean(abs(tstar) >= abs(t0)),
       clusters = G, B = B)
}

# Build a restriction vector for a linear combination of named coefficients.
restriction <- function(model, weights_named) {
  nm <- colnames(model.matrix(model, type = "rhs"))
  R <- setNames(rep(0, length(nm)), nm)
  stopifnot(all(names(weights_named) %in% nm))
  R[names(weights_named)] <- weights_named
  R
}

# Linear combination with CR1 SE from the model's clustered vcov.
lincom <- function(model, weights_named, level = 0.95) {
  b <- coef(model); V <- vcov(model)
  R <- setNames(rep(0, length(b)), names(b)); R[names(weights_named)] <- weights_named
  est <- sum(R * b); se <- sqrt(as.numeric(t(R) %*% V %*% R))
  df <- fixest::fitstat(model, "g", simplify = TRUE) - 1
  z <- qt(1 - (1 - level) / 2, df)
  z90 <- qt(0.95, df)
  data.frame(estimate = est, se = se, ci_low = est - z * se, ci_high = est + z * se,
             ci90_low = est - z90 * se, ci90_high = est + z90 * se,
             p_cr1 = 2 * pt(-abs(est / se), df))
}

tost_equivalent <- function(ci90_low, ci90_high, margin = EQUIV_MARGIN) {
  ci90_low > -margin & ci90_high < margin
}

# Number of occupations observed in both the focal group and the comparison
# group within the same estimate year (the identifying occupations).
identifying_occs <- function(d, focal, comparison) {
  d %>% group_by(year, occ) %>%
    summarise(f = any(focal[cur_group_rows()]), c = any(comparison[cur_group_rows()]), .groups = "drop") %>%
    filter(f & c) %>% distinct(occ) %>% nrow()
}

# ---- Kitagawa decomposition of the renewable minus nonrenewable gap, one year ----
# d: cells for one year with columns occ, renewable (0/1), emp, ln_y.
# Returns raw gap, composition and within components on common support,
# off-support residual, and off-support employment shares.
kitagawa_year <- function(d, support_occs = NULL) {
  agg <- d %>% group_by(occ, renewable) %>%
    summarise(ln_y = weighted.mean(ln_y, emp), emp = sum(emp), .groups = "drop")
  R <- agg %>% filter(renewable == 1); N <- agg %>% filter(renewable == 0)
  raw <- weighted.mean(R$ln_y, R$emp) - weighted.mean(N$ln_y, N$emp)
  common <- intersect(R$occ, N$occ)
  if (!is.null(support_occs)) common <- intersect(common, support_occs)
  Rc <- R %>% filter(occ %in% common) %>% mutate(s = emp / sum(emp))
  Nc <- N %>% filter(occ %in% common) %>% mutate(s = emp / sum(emp))
  j <- inner_join(Rc, Nc, by = "occ", suffix = c("_r", "_n"))
  within <- sum((j$s_r + j$s_n) / 2 * (j$ln_y_r - j$ln_y_n))
  composition <- sum((j$s_r - j$s_n) * (j$ln_y_r + j$ln_y_n) / 2)
  raw_common <- weighted.mean(Rc$ln_y, Rc$emp) - weighted.mean(Nc$ln_y, Nc$emp)
  stopifnot(abs(raw_common - (within + composition)) < 1e-8)
  data.frame(raw = raw, within = within, composition = composition,
             off_support = raw - raw_common, n_common = length(common),
             offsup_share_r = 1 - sum(Rc$emp) / sum(R$emp),
             offsup_share_n = 1 - sum(Nc$emp) / sum(N$emp))
}

# Occupation-cluster pairs bootstrap: resample occupations with replacement,
# giving duplicated occupations distinct ids, then apply fun(data).
occ_bootstrap <- function(d, fun, B = 999, seed = SEED) {
  set.seed(seed)
  occs <- unique(d$occ)
  split_d <- split(d, d$occ)
  lapply(seq_len(B), function(b) {
    draw <- sample(occs, length(occs), replace = TRUE)
    db <- bind_rows(lapply(seq_along(draw), function(k) {
      x <- split_d[[draw[k]]]; x$occ <- paste0(x$occ, "#", k); x }))
    fun(db)
  })
}
