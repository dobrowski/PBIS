
# Analyze PBIS data, exploratory


### Libraries ----

library(tidyverse)
library(here)
library(readxl)
library(janitor)
library(lubridate)



### Read files ------

file.name <- "SwisDrillDownData_0a6880444998e2cd1e2c2896e271b9e8.xlsx"

pbis <- read_excel(here("data", file.name),
                   range = "A4:AA734")



Problem <- pbis %>%
    select(ProblemBehaviors) %>% 
    unique() %>%
    separate(ProblemBehaviors, c("first","second", "third"),
             sep = ","
    ) %>%
    pivot_longer(c("first","second", "third")) %>%
    select(value) %>%
    mutate(value = str_trim(value)) %>%
    arrange(value) %>%
    distinct() %>%
    na.omit() %>%
    unlist()




Actions <- pbis %>%
    select(ActionsTaken) %>% 
     unique() %>%
    separate(ActionsTaken, c("first","second", "third"),
             sep = ","
             ) %>%
    pivot_longer(c("first","second", "third")) %>%
    select(value) %>%
    mutate(value = str_trim(value)) %>%
    arrange(value) %>%
    distinct() %>%
    na.omit() %>%
    unlist()

#  Split 

for (i in 1:length(Actions)) {
    pbis <- pbis %>%
        mutate(
            !!sym(Actions[i]) := str_detect(ActionsTaken,Actions[i])
        )
}    


for (i in 1:length(Problem)) {
    pbis <- pbis %>%
        mutate(
            !!sym(Problem[i]) := str_detect(ProblemBehaviors,Problem[i])
        )
}    



pbis %>% 
    tabyl(Location)

# Look at total numbers of Problem Behaviors and Actions Taken 

pbis.tots <- pbis %>%
    group_by(ReferralType) %>%
    summarise(across(`Act Pen`:Truan, sum))


# Look at referrals by time of day 

ggplot(pbis, aes(x= Time)) +
    geom_histogram() + 
    scale_x_datetime(date_breaks = "1 hour")


# Look at referrals by Day of Year 

ggplot(pbis, aes(x= Date)) +
    geom_histogram() + 
    scale_x_datetime(date_breaks = "1 month")
