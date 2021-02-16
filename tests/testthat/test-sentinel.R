ng1 <- 10
ng2 <- 8
ng3 <- 9
index_var <-  c(rep("Station1", ng1), rep("Station2", ng2), rep("Station3", ng3))
group_var <-  c(1:ng1, 1:ng2, 1:ng3)
response_var <- rnorm(ng1 + ng2 + ng3)

# station 1
data_g1g2 <- data.frame(group = 1:ng2,
                        s_id = "Station1",
                        s_value = response_var[index_var == "Station1"][1:ng2],
                        a_id = "Station2",
                        a_value = response_var[index_var == "Station2"][1:ng2], stringsAsFactors = FALSE)
# correlation test
cor_g1g2 <- cor.test(x = data_g1g2$s_value, y = data_g1g2$a_value, method = "spearman")

# station 1 sentinel with station 3
data_g1g3 <- data.frame(group = 1:ng3,
                        s_id = "Station1",
                        s_value = response_var[index_var == "Station1"][1:ng3],
                        a_id = "Station3",
                        a_value = response_var[index_var == "Station3"][1:ng3], stringsAsFactors = FALSE)

datag1 <- rbind(data_g1g2, data_g1g3)

# correlation test
cor_g1g3 <- cor.test(x = data_g1g3$s_value, y = data_g1g3$a_value, method = "spearman")

g1g2_estimate <- unname(cor_g1g2$estimate)
g1g3_estimate <- unname(cor_g1g3$estimate)
wg1 <- c(ng2, ng3)
estg1 <- c(g1g2_estimate, g1g3_estimate)

results_test_g1 <- data.frame(s_id =  "Station1", wt_mean = sum(wg1 * estg1) / sum(wg1),
                              mean = mean(estg1), min = min(estg1), q1 = unname(quantile(estg1, 0.25)),
                              med = median(estg1), q3 = unname(quantile(estg1, 0.75)),
                              max = max(estg1), stringsAsFactors = FALSE)




# station 2 sentinel
data_g2g1 <- data.frame(group = 1:ng2,
                        s_id = "Station2",
                        s_value = response_var[index_var == "Station2"][1:ng2],
                        a_id = "Station1",
                        a_value = response_var[index_var == "Station1"][1:ng2], stringsAsFactors = FALSE)
# correlation test
cor_g2g1 <- cor.test(x = data_g2g1$s_value, y = data_g2g1$a_value, method = "spearman")

# station 1 sentinel with station 3
data_g2g3 <- data.frame(group = 1:ng2,
                        s_id = "Station2",
                        s_value = response_var[index_var == "Station2"][1:ng2],
                        a_id = "Station3",
                        a_value = response_var[index_var == "Station3"][1:ng2], stringsAsFactors = FALSE)

datag2 <- rbind(data_g2g1, data_g2g3)

# correlation test
cor_g2g3 <- cor.test(x = data_g2g3$s_value, y = data_g2g3$a_value, method = "spearman")

g2g1_estimate <- unname(cor_g2g1$estimate)
g2g3_estimate <- unname(cor_g2g3$estimate)
wg2 <- c(ng2, ng2)
estg2 <- c(g2g1_estimate, g2g3_estimate)

results_test_g2 <- data.frame(s_id =  "Station2", wt_mean = sum(wg2 * estg2) / sum(wg2),
                              mean = mean(estg2), min = min(estg2), q1 = unname(quantile(estg2, 0.25)),
                              med = median(estg2), q3 = unname(quantile(estg2, 0.75)),
                              max = max(estg2), stringsAsFactors = FALSE)


# station 3 sentinel
data_g3g1 <- data.frame(group = 1:ng3,
                        s_id = "Station3",
                        s_value = response_var[index_var == "Station3"][1:ng3],
                        a_id = "Station1",
                        a_value = response_var[index_var == "Station1"][1:ng3], stringsAsFactors = FALSE)
# correlation test
cor_g3g1 <- cor.test(x = data_g3g1$s_value, y = data_g3g1$a_value, method = "spearman")

# station 1 sentinel with station 3
data_g3g2 <- data.frame(group = 1:ng2,
                        s_id = "Station3",
                        s_value = response_var[index_var == "Station3"][1:ng2],
                        a_id = "Station2",
                        a_value = response_var[index_var == "Station2"][1:ng2], stringsAsFactors = FALSE)

datag3 <- rbind(data_g3g1, data_g3g2)

# correlation test
cor_g3g2 <- cor.test(x = data_g3g2$s_value, y = data_g3g2$a_value, method = "spearman")

g3g1_estimate <- unname(cor_g3g1$estimate)
g3g2_estimate <- unname(cor_g3g2$estimate)
wg3 <- c(ng3, ng2)
estg3 <- c(g3g1_estimate, g3g2_estimate)

results_test_g3 <- data.frame(s_id =  "Station3", wt_mean = sum(wg3 * estg3) / sum(wg3),
                              mean = mean(estg3), min = min(estg3), q1 = unname(quantile(estg3, 0.25)),
                              med = median(estg3), q3 = unname(quantile(estg3, 0.75)),
                              max = max(estg3), stringsAsFactors = FALSE)

individual <- data.frame(s_id = rep(c("Station1", "Station2", "Station3"), each = 2),
                         a_id = c("Station2", "Station3", "Station1",
                                  "Station3", "Station1", "Station2"),
                         n = c(ng2, ng3, ng2, ng2, ng3, ng2),
                         estimate = c(estg1, estg2, estg3),
                         p =  unname(c(cor_g1g2$p.value, cor_g1g3$p.value,
                                       cor_g2g1$p.value, cor_g2g3$p.value,
                                       cor_g3g1$p.value, cor_g3g2$p.value)), stringsAsFactors = F)



data_bind <- rbind(datag1, datag2, datag3)

cor <- rbind(results_test_g1, results_test_g2, results_test_g3)


data <- data.frame(id = index_var, group = group_var, value = response_var, stringsAsFactors = F)

output <- sentinel(id = "id",
                   group = "group", value = "value", data = data, type = "correlation",
                   n_min = 0, output = c("overall", "individual", "dataset"), method = "spearman")
cor_test <- output$overall
individual_test <- output$individual
data_test <- data.frame(lapply(output$dataset, function(x) { attributes(x) <- NULL; x }), stringsAsFactors = FALSE)

test_that("correlation works", {
  expect_equal(cor, cor_test)
})

test_that("individual works", {
  expect_equal(individual, individual_test)
})

test_that("data works", {
  expect_equal(data_bind, data_test)
})
