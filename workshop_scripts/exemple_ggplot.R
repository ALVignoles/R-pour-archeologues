library(tidyverse)

# creer d'un dataframe hypothetique 
dataframe <- data.frame(
  artefact_id = seq(1,87),
  longueur = rnorm(n=87, mean=50, sd=10),
  largeur = rnorm(n=87, mean=30, sd=5),
  epaisseur = rnorm(n=87, mean=5, sd=2),
  categorie = sample(c("éclat brut","éclat retouché"), 
                     nrow(dataframe), replace = TRUE),
  matiere_premiere = sample(c("A","B"), 
                            nrow(dataframe), replace = TRUE)
  )

# enregistrer le theme que l'on veut utiliser dans ggplot
my_theme <- theme_classic() + 
  theme(axis.line=element_blank()) +
  theme(panel.border = element_rect(colour="black", fill = NA, size = .75),
        legend.position="none", aspect.ratio=1)

# un premier plot L/l
dataframe %>% 
  ggplot(aes(x = longueur, y = largeur)) +
  geom_point() +
  my_theme
  
# declinaison de ce plot L/l par categorie :
# par eclats bruts et retouches
# et par matiere premiere A et B
dataframe %>% 
  ggplot(aes(x = longueur, y = largeur)) +
  geom_point() +
  my_theme +
  facet_grid(cols = vars(categorie), 
             rows = vars(matiere_premiere))

dataframe %>% 
  ggplot(aes(x = longueur, y = largeur)) +
  geom_point() +
  my_theme +
  facet_grid(cols = vars(categorie), 
             rows = vars(matiere_premiere), 
             scales = "fixed", drop = T)
