
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

# L'objet de base dans R est le vecteur, aussi appelé une vairable: une liste de valeurs
# Créons une variable nommée 'var1' correspondant a une liste de A a E
var1 <- c(1,2,3,4,5)
# Creons une variable nommée 'var2' correspondant a une liste continue de 1 a 5
var2 <- c("A","B","C","D","E")  # notons que le contenu des variables de caractères
                                # doivent être notés avec des ""
# Avec ces variables on peut faire un tableau (data frame) - ici nommé 'd'
# et ce en utilisant la fonction de base data.frame() 
d <- data.frame(var1, var2)
  
# Dans R il est toujours possible de combiner des fonctions. On peut donc créer 
# un dataframe en insérant la création de variables au sein de la fonction data.frame()
# Créons un dataframe hypothétique que l'on appelera df
df <- data.frame(                 # objet 'df' créé par la fonction data.frame()
  artefact_id =                   # colonne 1, nommée 'artefact_id'
    c(                            # fonction c() combine des arguments pour former un vecteur
    seq(from=1,to=87, by=1)       # contenu de col 1: sequence continue 1-87
    ),
  longueur =                      # colonne 2, nommée 'longueur'
    c(                            # fonction c()
    rnorm(n=87,                   # fonction rnorm() génère 87 réalisations de la loi N(0,1)
          mean=50,                # avec une valeur moyenne de 50
          sd=10)                  # et un écart-type de 10
    ),
  largeur = c(                    # colonne 3, nommée 'largeur'
    rnorm(n=87, mean=30, sd=5)),  # fonction rnorm()...
  epaisseur = c(                  # colonne 4, nommée epaisseur
    rnorm(n=87, mean=5, sd=2)     # fonction rnorm()...
    ),
  categorie = c(                  # colonne 5, nommée 'categorie'
    sample(                       # fonction sample() permet de réaliser le tirage d'une
      c(                          # suite non consécutive de valeurs, en l'occurence
        "éclat brut",             # 'éclat brut'
        "éclat retouché"),        # et 'éclat retouché'
      nrow(df),                   # pour un nombre d'entrée correspondant à la taille de 'df'
      replace = TRUE)             # détail mathématique: tirage "avec remise"
    ),
  matiere_premiere = c(           # colonne 6, nommée 'matiere_premiere'
    sample(                       # fonction sample()...
      c("A","B"),                 # tirage de valeurs 'A' et 'B'
      nrow(df), replace = TRUE))  # nombre d'entrée correspondant à 'df' et tirage "avec remise"
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
