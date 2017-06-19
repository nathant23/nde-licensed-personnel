source('R/process_nde_license.R')
library(readr)

lic_1415 <- process_nde_license('data/licensed_1415.pdf', 18, 488)
write_csv(lic_1415, 'data/prelim_lic_1415.csv')
lic_1516 <- process_nde_license('data/licensed_1516.pdf', 19, 492)
write_csv(lic_1516, 'data/prelim_lic_1516.csv')

clean_1415 <- read_csv('data/clean_lic_1415.csv')
clean_1516 <- read_csv('data/clean_lic_1516.csv')


yoy <- left_join(clean_1415, clean_1516, by = c('License.Number' = 'License.Number'))

yoy_retention <- yoy %>%
  group_by(School.Name.x) %>%
  summarise(lic_count_1415 = n(),
            ret_rate = mean(ifelse(!is.na(School.District.y) & School.Name.x == School.Name.y, 1, 0)))