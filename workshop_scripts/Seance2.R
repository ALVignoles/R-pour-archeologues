
### 1- Introduction

# Au cours de cette seance nous utiliserons l'extension (package) tidyverse.
# A Le terme tidyverse est une contraction de 'tidy' (qu’on pourrait traduire par “bien rangé”) et de 'universe'.
# Il s’agit en fait d’une collection d’extensions conçues pour travailler ensemble et basées sur une philosophie commune.
# Elles abordent un très grand nombre d’opérations courantes dans R (la liste n’est pas exhaustive):  
# - visualisation
# - manipulation des tableaux de données
# - import/export de données
# - manipulation de variables
# - extraction de données du Web
# - programmation

# L'un des objectifs de ces extensions est de fournir des fonctions avec une syntaxe cohérente, qui fonctionnent bien ensemble, 
# et qui retournent des résultats prévisibles. 
# Elles sont en grande partie issues du travail d’Hadley Wickham.  

# Télécharger et charger le package tidyverse
install.packages("tidyverse")
library(tidyverse)

# Creons un tableau (dataframe) hypothetique que l'on appelera df
df <- data.frame(                 # fonction data.frame()
  artefact_id =                   # colonne 1, nommée artefact_id
    c(                            # 
    seq(from=1,to=87, by=1)       # contenu de col 1: sequence continue 1-87
    ),                     
  longueur = c(
    rnorm(n=87, mean=50, sd=10)),
  largeur = c(
    rnorm(n=87, mean=30, sd=5)),
  epaisseur = c(
    rnorm(n=87, mean=5, sd=2)),
  categorie = 
    c(sample(c("éclat brut","éclat retouché"), 
                     nrow(df), replace = TRUE)),
  c(matiere_premiere = sample(c("A","B"), 
                            nrow(df), replace = TRUE))
  )
                                                    
# Creons un premier plot L/l
df %>% 
  ggplot(aes(x = longueur, y = largeur)) +
  geom_point() +
  my_theme


On peut aussi decliner ce plot par categorie :  
  - par eclats bruts et retouches  
- par matiere premiere A et B
```{r}
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
```

Changer l'esthetique du plot peut se faire de deux maniere:  
- en ajoutant une ligne de commande pour chaque plot
Enregistrons le theme que l'on veut utiliser dans ggplot
```{r}
my_theme <- theme_classic() + 
  theme(axis.line=element_blank()) +
  theme(panel.border = element_rect(colour="black", fill = NA, size = .75),
        legend.position="none", aspect.ratio=1)
```
