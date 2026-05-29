###############################################################################
# SEANCE 3
###############################################################################

###################
# Introduction ####
###################

# Au cours de cette séance, nous allons continuer à nous familiariser avec les 
# packages du tidyverse et ggplot pour explorer des données spatiales à 
# l'échelle d'un site. Nous utiliserons le même jeu de données que dans la 
# séance 1.

## Préparons un peu notre script en ouvrant des librairies 
library(dplyr)
library(ggplot2)

## A présent, ouvrons le jeu de données 
jdd <- as_tibble(read.csv("data/Data_exemple.csv", header = TRUE, sep = ","))
head(jdd)

### Tout a l'air en ordre ! Nous pouvons donc commencer :)



####################################
# créer un plan et un carroyage ####
####################################

#####
# Dans un premier temps, nous allons essayer de reproduire un plan de 
# répartition spatiale X, Y, déjà réalisé avec QGIS et Powerpoint. Vous pouvez 
# consulter ce plan dans le dossier "figures" du projet, sous le nom de 
# "plan_exemple.pdf"

# L'objectif de cet exercice est de créer un code que vous pourrez ensuite 
# adapter à d'autres données. Cela vous permettra : 
# 1) de gagner un temps précieux, le code ne prenant que quelques secondes pour
# générer une figure ;
# 2) d'avoir une unité graphique dans votre document en utilisant toujours le 
# même layout ; 
# 3) d'organiser les différents éléments de vos figures toujours de la même 
# façon. 

## Nous allons commencer par créer le carroyage du plan. D'après 
## "plan_exemple.pdf", la zone d'étude s'étend sur 16 carrés de 1 m de côté, 
## organisés en 4 colonnes et 4 rangées. 
## Vérifions tout d'abord les unités pour les coordonnées des points. 
summary(jdd)

## Il semble que les coordonnées soient en cm. En x, elles se situent entre 10
## et 290 cm, et en y, entre 50 et 390 cm. Avec un carroyage basé sur des carrés
## de 1 m de côtés, les noeuds auront pour coordonnées (0;0), (0;100), (0;200),
## etc. Allons-y avec ggplot2 ! 

### Tout d'abord, définissons les labels des axes :
carres.x <- c("A", "B", "C", "D")
carres.y <- c("1", "2", "3", "4")

### Créons à présent un objet ggplot avec des lignes tous les 100 cm en x et en
### y. 
plan <- ggplot2::ggplot() +
    # ces deux premières lignes définissent le thème graphique de la figure
  theme_linedraw() +
  theme(axis.ticks = element_blank(), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank(), 
        panel.grid.major = element_line(),
        panel.grid.minor = element_blank()) + 
    # ici, on définit les dimensions des axes : de 0 à 4 cm, avec la même échelle
    # en x et en y (ratio = 1)
  coord_fixed(ratio = 1, xlim = c(0, 400), ylim = c(0, 400)) +
    # les deux lignes suivantes permettent de subdiviser les axes tous les 1 m 
  scale_x_continuous(breaks = seq(0, 400, by = 100)) +
  scale_y_continuous(breaks = seq(0, 400, by = 100)) +
    # enfin, ici on définit les labels des axes 
  ylab(element_blank()) +
  xlab(element_blank()) +
  annotate (geom = "text", x = c(seq(from = 50, to = 400, by = 100)), y = -10, label = carres.x) +
  annotate (geom = "text", x = -10, y = c(seq(from = 50, to = 400, by = 100)), label = carres.y)
plan  


##### 
# Nous pouvons à présent rajouter les points correspondant aux objets ainsi qu'un
# titre.
plan +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm.)) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

## La figure s'affiche dans l'onglet "plot", nous pouvons donc suivre son évolution
## au fur et à mesure des modifications que l'on souhaite y apporter par la suite !


#####
# Ce plan reste toutefois peu informatif sur l'organisation des objets dans le
# site. Il est possible d'am?liorer la figure en faisant varier la forme et la 
# couleur des points en fonction des données qualitatives associées ? chaque 
# pièce. 
plan +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., 
                                       color = silex, shape = type, 
                                       size = 1)) + # on augmente un peu la 
                                                    # taille des points pour plus 
                                                    # de lisibilité !
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

## Malheureusement... la palette automatique ne contient pas assez de formes !
## Nous allons donc devoir les définir manuellement dans les esthétiques de la
## figure. Pour cela nous allons attribuer à chaque valeur de "type" une forme.

### Affichons pour commencer les levels de "type" (après l'avoir converti en 
### factor).
jdd$type_fac <- factor(jdd$type, 
                        ### Généralement, les levels sont dans l'ordre 
                        ### alphabétique ; il est possible de changer leur ordre 
                        ### si vous le voulez !
                       levels = c("nucleus a eclats laminaires", "burin du Raysse", 
                                  "eclat", "lame", "chute de burin", "burin", 
                                  "burin diedre", "percoir", "picardie", "gravette"))
levels(jdd$type_fac)

### On créé ensuite manuellement la palette de formes avec "scale_shape_manual"
plan +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex,
                                       fill = silex, shape = type_fac, size = 1)) +
  scale_shape_manual(values = c("nucleus a eclats laminaires" = 7, 
                                "burin du Raysse" = 12, "eclat" = 22, "lame" = 23, 
                                "chute de burin" = 21, "burin" = 8, 
                                "burin diedre" = 24, "percoir" = 10,
                                "picardie" = 14, "gravette" = 3)) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

## On peut aussi faire la même chose pour la palette de couleurs. 
## Ici je vais utiliser les couleurs de la palette viridis.

#### Ne pas oublier de convertir en factor !
jdd$silex_fac <- as.factor(jdd$silex)
levels(jdd$silex_fac)

plan +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex,
                                       fill = silex, shape = type_fac, size = 1)) +
  scale_shape_manual(values = c("nucleus a eclats laminaires" = 7, 
                                "burin du Raysse" = 12, "eclat" = 22, "lame" = 23, 
                                "chute de burin" = 21, "burin" = 8, 
                                "burin diedre" = 24, "percoir" = 10,
                                "picardie" = 14, "gravette" = 3)) +
  scale_color_manual(values = c("type A" = "#7AD151FF", "type B" = "#2A788EFF", 
                                "type C" = "#440154FF")) +
  scale_fill_manual(values = c("type A" = "#7AD151FF", "type B" = "#2A788EFF", 
                               "type C" = "#440154FF")) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

### La figure est un peu plus facile à comprendre, mais le code pour la produire
### n'est pas très efficace... remarquez qu'il y a des répétitions(entre les 
### l.178 et 180) et le fait de définir les palettes dans les fonctions complique 
### la lecture.

## Pour clarifier tout cela, nous pouvons créer des objets qui contiennent nos 
## palettes. Nous n'aurons ensuite qu'à les appeler dans la fonction. 
shape.pal <- c("nucleus a eclats laminaires" = 7, "burin du Raysse" = 12, 
               "eclat" = 22, "lame" = 23, "chute de burin" = 21, "burin" = 8, 
               "burin diedre" = 24, "percoir" = 10, "picardie" = 14, 
               "gravette" = 3)
color.pal <- c("type A" = "#7AD151FF", "type B" = "#2A788EFF", "type C" = "#440154FF")

#### pour alléger encore, on place les palettes et le titre dans l'objet plan de 
#### base. 
plan.modif <- plan +
  scale_shape_manual(values = shape.pal) +
  scale_color_manual(values = color.pal) +
  scale_fill_manual(values = color.pal) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

plan.modif +
geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex,
                                     fill = silex, shape = type_fac, size = 1))

### même résultat !

#####
# Modifions à présent la légende pour la rendre plus lisible 
plan.modif +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex,
                                       fill = silex, shape = type_fac, size = 1)) +
    # ici on va changer le titre des légendes 
  labs(color = "Matière première", shape = "Catégorie d'objet") +
    # et là, nous pouvons supprimer les légendes que nous ne souhaitons pas voir
    # apparaître dans la figure finale. 
  guides(fill = "none", size = "none")



##########################################
# SELECTIONNER DES DONNEES A AFFICHER #### 
##########################################

# Dans cette nouvelle partie, nous allons apprendre comment sélectionner une partie
# des données, dans l'idée d'un requêtage permettant ensuite d'afficher une portion
# seulement des données initiales. Cette opération est très pratique par exemple 
# pour réaliser des projections localisées sans avoir à modifier le tableau
# excel de base, ce qui est plus transparent et permet de limiter les erreurs 
# possibles. 

#####
# Découvrons comment mettre en oeuvre cette opération. Dans les quelques lignes
# suivantes, nous allons sélectionner les pièces qui ont fait l'objet d'un raccord
# ou d'un remontage afin de représenter la relation entre les pièces sur le plan. 

## Pour cela, nous allons créer un nouveau dataframe dans lequel
## nous allons "ranger" uniquement les lignes qui contiennent des données pour la
## variable "raccord"
rac <- jdd[complete.cases(jdd$raccord), ]

## Les crochets permettent de dire ? R que l'on va sélectionner des lignes (premier
## argument) ou des colonnes (deuxi?me argument) dans le data frame "jdd". La
## fonction complete.cases() permet ensuite de rep?rer les cases qui ne sont pas
## vides. Cette ligne de code 244 nous permet donc de sélectionner dans "jdd" 
## les lignes pour lesquelles la valeur de raccord est renseignée. 

## Observons ce que cela donne :
head(jdd)
head(rac)

## Dans la data frame "jdd", notez bien la présence de cases vides ("NA") dans la
## colonne "raccord". En revanche dans "rac", seules les lignes pour lesquelles 
## la valeur de "raccord" est renseign?e (1 ou 2 en l'occurrence) sont présentes.
## Il n'y a donc que 4 pièces concernées.

# Nous pouvons maintenant rajouter un lien entre les pièces en utilisant cette
# nouvelle data frame.

plan.modif +
  geom_line(data = rac, mapping = aes(x = x..cm., y = y..cm., group = raccord), 
            linewidth = 0.5) + # l'argument 'group' permet de relier les pièces
                               # par groupe de mêmes valeurs
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                       fill = silex, shape = type_fac, size = 1)) +
    # légende
  labs(color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")

##### 
# Une autre façon de faire des sélections au sein d'une data frame est d'utiliser
# la fonction subset(). Cette fonction permet d'introduire des conditions plus
# complexes pour la sélection de lignes ou de colonnes, en utilisant des 
# connecteurs logiques.

## Par exemple, essayons de sélectionner les pièces situées entre 200 et 400 cm
## en x, et entre 300 et 500 cm en y.
jdd.zoom <- subset(jdd, x..cm. >= 200 & x..cm. <= 400 
                      & y..cm. >= 300 & y..cm. <= 500)

## Pour créer "jdd zoom", nous demandons R de renvoyer les lignes du data frame 
## dont le x est supérieur ou égal (>=) à 200 ET (&) inférieur ou égal (<=) à 
## 400 ET (&) dont le xy est supérieur ou égal (>=) à 300 ET (&) inférieur ou 
## égal (<=) à 500.

### Voyons le résultat sur le plan 
plan.modif +
  geom_point(data = jdd.zoom, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                            fill = silex, shape = type_fac, size = 1)) +
    # titre et légende
  labs(title = "Répartition spatiale des pièces de la zone nord", 
       color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")

## Les connecteurs logiques permettent de personnaliser vos sélections très 
## facilement. Voici les différentes possibilit?s : 

###  < : "strictement inférieur ?"       ### <= : "inférieur ou égal ?"
###  > : "strictement supérieur ?"       ### >= : "supérieur ou égal ?"     
###  & : "et"                            ###  | : "ou"
### == : "strictement égal ?"            ### != : "non égal ?"
### !x : "différent de x"                ### isTRUE(x) : teste si x est TRUE

## Essayons quelques exemples !

### On sélectionne les pièces qui ne sont pas en silex de type A
jdd.silexBC <- subset(jdd, silex != "type A",)

plan.modif +
  geom_point(data = jdd.silexBC, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                               fill = silex, shape = type_fac, size = 1)) +
  # titre et légende
  labs(titre = "Répartition spatiale des objets en silex autres que de type A", 
       color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")

## On sélectionne les lames et éclats non retouchés et nucléus à éclats laminaires
jdd.lamn <- subset(jdd, type == "eclat" | type == "lame" | type == "nucleus a eclats laminaires",)

plan.modif +
  geom_point(data = jdd.lamn, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                             fill = silex, shape = type_fac, size = 1)) +
  # titre et légende
  labs(title = "Répartition spatiale des pièces non retouchées pouvant s'int?grer dans un schéma laminaire",
       color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")



##########################
# AUTOMATISER UN CODE ####
##########################

# Nous entrons à présent dans la dernière partie de ce TP, et peut-être la plus
# utile... l'automatisation d'un code ! 
# Ce processus signifie que l'on va demander au code de réaliser plusieurs fois
# la même opération mais sur des données différentes. Pour cela, il existe 
# deux fonctions permettant de répéter un bout de code tant qu'une certaine 
# condition ne sera pas atteinte : for() et while(). Nous allons les découvrir
# ensemble sur des exemples très simples, puis nous verrons un exemple avec le
# jeux de données archéologique. 


#####
# Une boucle for() permet de répéter un bout de code tant qu'une certaine valeur
# (par convention, on l'appelle "i") se situe dans un certain intervalle. 

## A présent, créons un objet x contenant la valeur "0". 
x <- 0

## Nous allons y ajouter des valeurs à l'aide d'une boucle : 

i <- 1 # tout d'abord, on initialise la valeur i

for(i in 1:5) # conditions de la boucle : tant que i se trouve dans ("in") 
              # l'intervalle 1 à 5 (défini par ":"), répéter le code suivant.
  { # on ouvre la boucle 
  x <- c(x, i) # on place la valeur i dans l'objet x. 
  
  i <- i + 1 # on incrémente i de 1
}

## Affichons le résultat :
x

## Nous avons bien réussi à créer une suite de nombres ! Cet exemple est certes
## trivial, mais nous verrons un peu plus tard comment l'appliquer sur des 
## données et avec des opérations plus complexes. 

### Petite note à ce stade : la dernière ligne de notre boucle, "i <- i + 1", 
### est facultative dans R. La fonction for() permet en effet d'incrémenter 
### automatique la valeur "i" de 1 à chaque fin de boucle. 

### Voici la preuve : 
y <- 0

for(i in 1:5) { 
  y <- c(y, i) 
}

y #### même résultat !


#####
# L'autre type de boucle est moins fréquemment utilisée, mais peut toujours être
# utile. Il s'agit d'une boucle while() : c'est à dire que l'on va répéter le
# code tant qu'une certaine condition est remplie. Une fois qu'elle ne l'est plus,
# la boucle est terminée. 

## Essayons avec un autre exemple simple : nous allons créer un code qui va 
## afficher une valeur tant que celle-ci est inférieure ? 5.

i <- 1 # initialisation de la valeur

while(i <= 5) # cette ligne de code se lit : tant que i est inférieur ou égal à 
              # 5, répéter le code suivant
  { # d?but de la boucle 
  print(i) # afficher "i" dans la console
  
  i <- i + 1 # incrémenter i de 1
             # ATTENTION: l'incrémentation ne se fait pas automatiquement avec 
             # while() !!!
} # fin de la boucle

## Si vous consultez la console, vous remarquez que l'on a affiché la valeur i 
## tant que celle-ci est inférieure à 5 ! 

### Dans la mesure du possible, nous vous conseillons d'utiliser plutôt les boucles
### for(), car ce sont elles qui sont plus utilisée dans la communauté. while()
### est également très bien et vous pouvez arriver au même résultat qu'avec une
### boucle for(), mais l'utilisation de for() fait vraiment partie de la "culture
### R" en tant que culture de programmation ! 


#####
# Mettons en pratique ce concept sur le jeu de données du site de la Forêt.
# Nous allons créer plusieurs plans de Répartition en fonction de la dimensions 
# des pièces. Tout d'abord, rafraîchissons nous la m?moire sur les statistiques
# basiques du jeu de données.
summary(jdd)

## La longueur des pièces se situe entre 1.4 et 10.2 cm. Je vous propose donc 
## de créer un plan pour des intervalles de longueurs tous les 2 cm. 
## Nous allons donc devoir combiner les commandes de subsetting et le loop for(). 

i <- 1
pace <- 2 # ici il s'agit de la valeur d'intervalle ; dans ce cas concret, il est 
          # nécessaire de la spécifier étant donné qu'elle est différente de la 
          # valeur par d?faut (1)

### Je crée également un dossier afin de pouvoir sauvegarder les plots au fur et
### à mesure. 
dir.create("figures/plans_fct_longueur")

### Démarrons la boucle !
for(i in 1:11) { # Cette boucle va s'exécuter tant que i sera compris entre 1 et 11
  
  ## Je commence par créer les bornes de l'intervalle i 
  borne.min <- i # le minimum est i 
  borne.max <- i + pace # et le maximum est i + pace, soit i + 2
  
  ## Ensuite, je subset le jeux de données pour ne sélectionner que les pièces
  ## dont la longueur est comprise entre la borne min et la borne max de mon 
  ## intervalle. 
  repart <- subset(jdd, longueur..cm. >= borne.min & longueur..cm. <= borne.max)
  
  ## maintenant, on cr?e le plan de Répartition avec les données sélectionn?es
  plan.modif +
    geom_point(data = repart, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                              fill = silex, shape = type_fac, size = 1)) +
    # titre et légende
    labs(title = paste0("Répartition spatiale des pièces dont L est comprise entre ", borne.min,  " et ", borne.max, "cm"),
         ### NB : ici, on va utiliser la fonction paste0() pour adapter le titre de la figure à chaque intervalle. 
         ### Cette fonction est extr?mement utile, retenez la ! Elle permet de coller côte à côte des objets en les
         ### transformant en texte. 
         color = "Matière première", shape = "Catégorie d'objet") +
    guides(fill = "none", size = "none")
    
  ## Enfin, on sauvegarde la figure dans le dossier "plans_fct_longueur" en 
  ## adaptant son titre avec paste() - cette fonction est un peu différente de 
  ## paste0() en cela qu'elle recquiert que l'on précise un séparateur à ajouter
  ## entre les blocs de texte. Ici ce sera "_" (argument "sep"). 
  ggsave(paste("figures/plans_fct_longueur/repart_pieces_entre ", borne.min, "et", borne.max, ".png", sep = "_"), 
         width = 6, height = 4)
}



###################################################################
# FELICITATIONS ! Vous avez fait votre première boucle sur R !!####
###################################################################



