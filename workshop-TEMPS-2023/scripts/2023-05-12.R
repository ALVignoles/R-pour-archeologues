install.packages("archdata")
library(archdata)
?data()
data(DartPoints)


#2.1.
#jdd %>% dplyr::filter(silex %in% c("type B", "type C"))
jdd_BC <- subset(jdd, silex != "type A")
jdd_BC <- subset(jdd, silex == "type B" | silex == "type C")
jdd_BC <- jdd[jdd$silex != "type A", ]

jdd[ , ]

plan.modif +
  
