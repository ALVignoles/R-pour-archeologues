#### Introduction ####
Au cours de cette seance nous utiliserons l'extension (*package*) **tidyverse**.
Le terme tidyverse est une contraction de '*tidy*' (qu’on pourrait traduire par “bien rangé”) et de '*universe*'.
Il s’agit en fait d’une collection d’extensions conçues pour travailler ensemble et basées sur une philosophie commune.
Elles abordent un très grand nombre d’opérations courantes dans R (la liste n’est pas exhaustive) :
- visualisation
- manipulation des tableaux de données
- import/export de données
- manipulation de variables
- extraction de données du Web
- programmation

Un des objectifs de ces extensions est de fournir des fonctions avec une syntaxe cohérente, qui fonctionnent bien ensemble, et qui retournent des résultats prévisibles. Elles sont en grande partie issues du travail d’Hadley Wickham, qui travaille désormais pour RStudio.

Télécharger et charger le *package* **tidyverse**:
```{r}
install.packages("tidyverse")
library(tidyverse)
```


# creation d'un dataframe hypothetique 
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
