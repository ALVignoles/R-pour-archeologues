# Séance 3 

iris
head(iris)
summary(iris)
View(iris)

# install.packages("ggplot2")
library(tidyverse)
# library(ggplot2)

plot <- ggplot() +
  geom_point(data = iris, 
             aes(x = Petal.Width, y = Petal.Length, 
                 color = Species, shape = Species)) +
  theme_linedraw()

plot

#
## Créer un plan et un carroyage 
jdd <- as_tibble(read.csv("data/Data_exemple.csv", header = TRUE, sep = ","))
head(jdd)

carres.x <- c("1", "2", "3", "4")
carres.y <- c("A", "B", "C", "D")

plan <- ggplot() +
  theme_linedraw() +
  theme(axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        panel.grid.major = element_line(),
        panel.grid.minor = element_blank()) +
  coord_fixed(ratio = 1, xlim = c(0, 400), ylim = c(0, 400)) +
  ylab(element_blank()) +
  xlab(element_blank()) +
  annotate(geom = "text", x = c(50, 150, 250, 350), y = -10, label = carres.x) +
  annotate(geom = "text", x = -10, y = c(seq(from = 50, to = 400, by = 100)), label = carres.y)
plan  

figure1 <- plan +
  geom_point(data = jdd, mapping = aes(x = x_cm, y = y_cm)) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")
figure1  

plan +
  geom_point(data = jdd, mapping = aes(x = x_cm, y = y_cm,
                                       color = silex, shape = type, size = 1))


jdd$type_factor <- factor(jdd$type, levels = c("nucleus a lames", "burin du Raysse", 
                                               "eclat", "lame", "chute de burin", "burin", 
                                               "burin diedre", "percoir", "picardie", "gravette"))


shape.palette <- c("nucleus a lames" = 7, "burin du Raysse" = 12, "eclat" = 22, "lame" = 23, 
                   "chute de burin" = 21, "burin" = 8, 
                   "burin diedre" = 24, "percoir" = 10,
                   "picardie" = 14, "gravette" = 3)
shape.color <- c("type A" = "blue", "type B" = "deeppink", "type C" = "green")

plan +
  geom_point(data = jdd, mapping = aes(x = x_cm, y = y_cm,
                                       color = silex, shape = type_factor, fill = silex, size = 1)) +
  scale_shape_manual(values = shape.palette) +
  scale_color_manual(values = shape.color) + 
  scale_fill_manual(values = shape.color)

head(jdd)

raccord <- jdd[!is.na(jdd$raccord),]

plan +
  geom_point(data = jdd, mapping = aes(x = x_cm, y = y_cm,
                                       color = silex, shape = type_factor, fill = silex, size = 1)) +
  scale_shape_manual(values = shape.palette) +
  scale_color_manual(values = shape.color) + 
  scale_fill_manual(values = shape.color) +
  geom_line(data = raccord, aes(x = x_cm, y = y_cm, group = raccord))

D3 <- subset(jdd, x_cm > 200 & x_cm < 300 & y_cm > 300 & y_cm < 400)
D3


plan +
  geom_point(data = D3, mapping = aes(x = x_cm, y = y_cm,
                                       color = silex, shape = type_factor, fill = silex, size = 1)) +
  scale_shape_manual(values = shape.palette) +
  scale_color_manual(values = shape.color) + 
  scale_fill_manual(values = shape.color) 

