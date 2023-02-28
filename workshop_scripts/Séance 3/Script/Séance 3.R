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

#####
# Pour faciliter notre travail, on va créer un projet R. Cela va nous permettre 
# 1) de rassembler tous les éléments liés à notre séance au sein d'un même 
# dossier
# 2) de simplifier notre code, car nos commandes "path" seront toujours 
# précédées par le path du projet ;
# 3) de partager plus facilement notre travail (toutes les données nécessaires
# au fonctionnement du script seront partagées avec lui) ou de le transférer à 
# un autre ordinateur (puisque le path sera automatiquement modifié !)

## Pour créer un projet, nous pouvons cliquer sur le bouton en haut à droite de
## RStudio > New project... Puis sélectionnez ou créez le dossier dans lequel 
## vous allez mettre votre script et vos données. 
## Remarquez bien que dans l'onglet "Files" dans le panneau en bas à droite, 
## nous sommes directement dans le dossier du projet !

### Personnellement, j'organise tous mes projets de la même façon : trois 
### sous-dossiers : "Data" qui contiendra toutes les données brutes utilisées
### dans ce projet ; "Script" qui contiendra tous les scripts utilisés ;
### "Output" dans lequel on sauvegardera les résultats de nos codes (tableaux, 
### figures etc). On peut créer ces dossiers manuellement dans Explorer mais 
### il existe aussi une commande R pour cela ! Elle peut être très utile quand
### on souhaite automatiser la sauvegarde de fichiers au sein de dossiers 
### différents. 
dir.create("Data")
dir.create("Script")
dir.create("Output")

### En consultant l'onglet "Files" du panneau en bas à droite, on voit que nos 
### dossiers ont bien été créés ! 


#####
# Préparons un peu notre script en ouvrant des librairies 
library(dplyr)
library(ggplot2)

# A présent, ouvrons le jeu de données 
jdd <- as_tibble(read.csv("Data/Data_exemple.csv", header = TRUE, sep = ","))
head(jdd)

## Tout a l'air en ordre ! Nous pouvons donc commencer :)


####################################
# Créer un plan et un carroyage ####
####################################

#####
# Dans un premier temps, nous allons essayer de reproduire un plan de 
# répartition spatiale X, Y, déjà réalisé avec QGIS et Powerpoint. Vous pouvez 
# consulter ce plan dans le dossier du projet, sous le nom de "plan_exemple.pdf"

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

# Ce plan reste toutefois peu informatif sur l'organisation des objets dans le
# site. Il est possible d'améliorer la figure en faisant varier la forme et la 
# couleur des points en fonction des données qualitatives associées à chaque 
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
### n'est pas très efficace... remarquez qu'il y a des répétitions (entre les 
### l.178 et 180) et le fait de définir les palettes dans les fonctions complique 
### la lecture.

## Pour clarifier tout ça, nous pouvons créer des objets qui contiennent nos 
## palettes. Nous n'aurons ensuite qu'à les appeler dans la fonction. 
shape.pal <- c("nucleus a eclats laminaires" = 7, "burin du Raysse" = 12, 
               "eclat" = 22, "lame" = 23, "chute de burin" = 21, "burin" = 8, 
               "burin diedre" = 24, "percoir" = 10, "picardie" = 14, 
               "gravette" = 3)
color.pal <- c("type A" = "#7AD151FF", "type B" = "#2A788EFF", "type C" = "#440154FF")

plan +
  geom_point(data = jdd, mapping = aes(x = x..cm., y = y..cm., color = silex,
                                       fill = silex, shape = type_fac, size = 1)) +
  scale_shape_manual(values = shape.pal) +
  scale_color_manual(values = color.pal) +
  scale_fill_manual(values = color.pal) +
  labs(title = "Répartition spatiale des artéfacts - site de la Forêt")

### même résultat !


######## EXERCICES SUR LA SELECTION DE PARTIES DE DATA SET
######## A REDIGER
##### 
# rajouter raccord
rac <- jdd[complete.cases(jdd$raccord), ]

plan +
  geom_point(data = jdd, mapping = aes(x = x, y = y, shape = type, color = silex)) +
  geom_line(data = rac, mapping = aes(x = x, y = y), size = 0.5)

# inverser pour plus de lisibilité 
plan +
  geom_line(data = rac, mapping = aes(x = x, y = y), size = 0.5) +
    geom_point(data = jdd, mapping = aes(x = x, y = y, shape = type, color = silex)) 

## A FAIRE une légende plus clean 


##### 
# faire des sélections 
## eg les pièces situées entre300 et 500 cm en y, et entre 200 et 400 cm en x
jdd.zoom <- subset(jdd, x >= 200 & x <= 400 
                      & y >= 300 & y <= 500)

plan +
  geom_point(data = jdd.zoom, mapping = aes(x = x, y = y, shape = type, color = silex))

## sélectionner les pièces en silex type A 
jdd.silexA <- subset(jdd, silex == "type A",)

plan +
  geom_point(data = jdd.silexA, mapping = aes(x = x, y = y, shape = type, color = silex))

## sélectionner les produits non retouchés et nucléus à éclats laminaires
jdd.lamn <- subset(jdd, type == "eclat" | type == "lame" | type == "nucleus a eclats laminaires",)

plan +
  geom_point(data = jdd.lamn, mapping = aes(x = x, y = y, shape = type, color = silex))


##### A REDIGER AUSSI 
# découverte du loop !

