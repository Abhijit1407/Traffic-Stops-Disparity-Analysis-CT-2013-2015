Hrm(list = ls())  

try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) 

try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) 

options(scipen = 100) 

cat("\014")  

install.packages('pacman')
library(pacman)

install.packages('tidyverse')
library(tidyverse)
#p_load(tidyverse)

filename <- file.choose()
data <- readRDS(filename)

data <- data[, c("date", "location", "subject_age", 
                 "subject_race", "subject_sex", "type", 
                 "reason_for_stop", "search_conducted", 
                 "contraband_found", "outcome","citation_issued",
                 "warning_issued","arrest_made")]

data$reason_for_stop <- factor(data$reason_for_stop)

data <- data |> mutate(dayofweek = wday(date, label = TRUE))

table(data$subject_race)

race <- data |> group_by(subject_race) |> summarize(counts = n())

table(data$subject_race, data$search_conducted)

data <- data |> filter(subject_race != 'unknown', 
                       subject_race != 'other', subject_race != 'NA')

install.packages('gmodels')
library(gmodels)
CrossTable(data$subject_race, data$search_conducted, 
           prop.chisq = FALSE)

library(ggplot2) 
ggplot(data, aes(x = dayofweek)) +
  geom_bar(fill = "lightblue", color = "black") +
  labs(title = "Distribution of Traffic Stops", 
       x = "Day of Week", y = "Frequency")

ggplot(data, aes(x = subject_race, fill = subject_race)) +
  geom_bar(fill = "gray") +
  labs(title = "Traffic Stops by Race", x = "Race", y = "Count") +
  scale_y_continuous(labels = function(x) format(x, big.mark = "", scientific = FALSE)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

names(data)

library(dplyr)
library(ggplot2)
install.packages('psych')
library(psych)

age <- data |> group_by(subject_age) |> summarize(counts = n())

data <- data |> filter(subject_age != 'NA') 

data <- data |> filter(subject_age > 16) 

overall_stats <- t(psych::describe(data$subject_age))

group_stats <- data %>%
  group_by(subject_race) %>%
  summarise(
    mean_age = mean(subject_age, na.rm = TRUE),
    sd_age = sd(subject_age, na.rm = TRUE),
    min_age = min(subject_age, na.rm = TRUE),
    max_age = max(subject_age, na.rm = TRUE),
    N = n()
  )

print(knitr::kable(group_stats, format = "pipe"))

data <- data |> filter(outcome != 'NA')

png("scatter_plot.png", width = 800, height = 600)
ggplot(data, aes(x = subject_age, y = outcome)) +
  geom_jitter(width = 0.3, alpha = 0.5) +
  labs(title = "Age vs. Outcome",
       x = "Age", y = "Outcome")
dev.off()

outcome <- data |> group_by(outcome)|> summarize(counts = n())

data_outcome <- data[, c("outcome", "subject_age")] |> 
  filter(outcome != 'NA')

png("jitter_plot.png", width = 800, height = 600)
ggplot(data, aes(x = subject_race, y = search_conducted)) +
  geom_jitter(width = 0.3, alpha = 0.5) +
  labs(title = "Search Conducted by Race",
       x = "Race", y = "Search Conducted")
dev.off()

data_age <- data[, c("subject_age", "subject_race")]
data_age$subject_race <- as.character(data_age$subject_race)
data_age <- data_age |> filter(subject_race != 'other', subject_race != 'unknown')
table(data_age$subject_race)

png("boxplot.png", width = 800, height = 600)
boxplot(subject_age ~ subject_race, data = data_age,
        main = "Age Distribution by Race",
        xlab = "Race", ylab = "Age")
dev.off()

library(dplyr)

t_test_age <- t.test(data$subject_age, mu = 35, alternative = "two.sided")

print(t_test_age)

cat("The one-sample t-test compares the sample mean age to a hypothesized population mean of 35 years. 
The null hypothesis assumes that the true mean age is equal to 35 years. 
If the p-value is less than our significance level (usually 0.05), we reject the null hypothesis and 
conclude that the mean age is significantly different from 35 years.\n")

if(t_test_age$p.value < 0.05) {
  cat("Since the p-value is less than 0.05, we reject the null hypothesis. 
      There is evidence to suggest that the mean age of individuals stopped is significantly different from 35 years.\n")
} else {
  cat("Since the p-value is greater than or equal to 0.05, we fail to reject the null hypothesis. 
      There is no significant evidence to suggest that the mean age differs from 35 years.\n")
}

observed <- matrix(c(8323, 333282, 34008, 2376651), nrow = 2, byrow = TRUE,
                   dimnames = list(Race = c("Black", "White"),
                                   Search_Conducted = c("Yes", "No")))

print(observed)

chi_test <- chisq.test(observed)

print(chi_test)

if(chi_test$p.value < 0.05) {
  cat("Since the p-value is less than 0.05, we reject the null hypothesis.
      There is evidence to suggest that Black drivers are more likely to be searched than White drivers.\n")
} else {
  cat("Since the p-value is greater than or equal to 0.05, we fail to reject the null hypothesis.
      There is no significant evidence to suggest that Black drivers are more likely to be searched than White drivers.\n")
}


names(data)

restructured_data <- data |>
  group_by(date) |>
  summarize(
    stops = n(),
    citations = sum(citation_issued == TRUE, na.rm = TRUE),
    warnings = sum(warning_issued == TRUE, na.rm = TRUE),
    arrests = sum(arrest_made == TRUE, na.rm = TRUE),
  )

library(tidyverse)
data_numeric <- restructured_data |> 
  select(stops, citations,
         warnings, arrests) |> 
  na.omit()

cor_matrix <- cor(data_numeric)
print(cor_matrix)

library(corrplot)
png('correlation.png', width = 800, height = 800)
corrplot(cor_matrix, method = "color", type = "upper", 
         order = "hclust",
         tl.col = "black", tl.srt = 45)
dev.off()

names(restructured_data)
lm_model <- lm(arrests ~ stops + citations + warnings, data=restructured_data)
summary(lm_model)
