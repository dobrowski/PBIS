
# Analyze PBIS data, exploratory


### Libraries ----

library(tidyverse)
library(here)
library(readxl)



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




# pbis.rev <- pbis %>%
#     mutate(
#         !!sym(Actions[1]) := str_detect(ActionsTaken,Actions[1]),
#         !!sym(Actions[2]) := str_detect(ActionsTaken,Actions[2]),
#         !!sym(Actions[3]) := str_detect(ActionsTaken,Actions[3]),
#         !!sym(Actions[4]) := str_detect(ActionsTaken,Actions[4]),
#         !!sym(Actions[5]) := str_detect(ActionsTaken,Actions[5]),
#         !!sym(Actions[6]) := str_detect(ActionsTaken,Actions[6]),
#         !!sym(Actions[7]) := str_detect(ActionsTaken,Actions[7]),
#         !!sym(Actions[8]) := str_detect(ActionsTaken,Actions[8]),
#         !!sym(Actions[9]) := str_detect(ActionsTaken,Actions[9]),
#         !!sym(Actions[10]) := str_detect(ActionsTaken,Actions[10]),
#         !!sym(Actions[11]) := str_detect(ActionsTaken,Actions[11]),
#         !!sym(Actions[12]) := str_detect(ActionsTaken,Actions[12]),
#         
#          ) %>%
#     mutate(
#         !!sym(Problem[1]) := str_detect(ProblemBehaviors,Problem[1]),
#         !!sym(Problem[2]) := str_detect(ProblemBehaviors,Problem[2]),
#         !!sym(Problem[3]) := str_detect(ProblemBehaviors,Problem[3]),
#         !!sym(Problem[4]) := str_detect(ProblemBehaviors,Problem[4]),
#         !!sym(Problem[5]) := str_detect(ProblemBehaviors,Problem[5]),
#         !!sym(Problem[6]) := str_detect(ProblemBehaviors,Problem[6]),
#         !!sym(Problem[7]) := str_detect(ProblemBehaviors,Problem[7]),
#         !!sym(Problem[8]) := str_detect(ProblemBehaviors,Problem[8]),
#         !!sym(Problem[9]) := str_detect(ProblemBehaviors,Problem[9]),
#         !!sym(Problem[10]) := str_detect(ProblemBehaviors,Problem[10]),
#         !!sym(Problem[11]) := str_detect(ProblemBehaviors,Problem[11]),
#         !!sym(Problem[12]) := str_detect(ProblemBehaviors,Problem[12]),
#         !!sym(Problem[13]) := str_detect(ProblemBehaviors,Problem[13]),
#         !!sym(Problem[14]) := str_detect(ProblemBehaviors,Problem[14]),
#         !!sym(Problem[15]) := str_detect(ProblemBehaviors,Problem[15]),
#         !!sym(Problem[16]) := str_detect(ProblemBehaviors,Problem[16]),
#         !!sym(Problem[17]) := str_detect(ProblemBehaviors,Problem[17]),
#         !!sym(Problem[18]) := str_detect(ProblemBehaviors,Problem[18]),
#         !!sym(Problem[19]) := str_detect(ProblemBehaviors,Problem[19]),
#         !!sym(Problem[20]) := str_detect(ProblemBehaviors,Problem[20]),
#         !!sym(Problem[21]) := str_detect(ProblemBehaviors,Problem[21]),
#         !!sym(Problem[22]) := str_detect(ProblemBehaviors,Problem[22]),
#         !!sym(Problem[23]) := str_detect(ProblemBehaviors,Problem[23]),
#         !!sym(Problem[24]) := str_detect(ProblemBehaviors,Problem[24]),
#         !!sym(Problem[25]) := str_detect(ProblemBehaviors,Problem[25]),
#         !!sym(Problem[26]) := str_detect(ProblemBehaviors,Problem[26]),
#         !!sym(Problem[27]) := str_detect(ProblemBehaviors,Problem[27]),
#         !!sym(Problem[28]) := str_detect(ProblemBehaviors,Problem[28]),
#         
#     
#     )





        
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

