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


#####
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
# SELECTIONNER DES DONNEES A AFFICHER #### je ne sais pas comment titrer ça autrement, Aymeric si tu as une idée !
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

## Les crochets permettent de dire à R que l'on va sélectionner des lignes (premier
## argument) ou des colonnes (deuxième argument) dans le data frame "jdd". La
## fonction complete.cases() permet ensuite de repérer les cases qui ne sont pas
## vides. Cette ligne de code 244 nous permet donc de sélectionner dans "jdd" 
## les lignes pour lesquelles la valeur de raccord est renseignée. 

## Observons ce que cela donne :
head(jdd)
head(rac)

## Dans la data frame "jdd", notez bien la présence de cases vides ("NA") dans la
## colonne "raccord". En revanche dans "rac", seules les lignes pour lesquelles 
## la valeur de "raccord" est renseignée (1 ou 2 en l'occurrence) sont présentes.
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
    # légende
  labs(color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")

## Les connecteurs logiques permettent de personnaliser vos sélections très 
## facilement. Voici les différentes possibilités : 

###  < : "strictement inférieur à"       ### <= : "inférieur ou égal à"
###  > : "strictement supérieur à"       ### >= : "supérieur ou égal à"     
###  & : "et"                            ###  | : "ou"
### == : "strictement égal à"            ### != : "non égal à"
### !x : "différent de x"                ### isTRUE(x) : teste si x est TRUE

## Essayons quelques exemples !

### On sélectionne les pièces qui ne sont pas en silex de type A
jdd.silexBC <- subset(jdd, silex != "type A",)

plan +
  geom_point(data = jdd.silexBC, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                               fill = silex, shape = type_fac, size = 1)) +
  # légende
  labs(color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")

## On sélectionne les lames et éclats non retouchés et nucléus à éclats laminaires
jdd.lamn <- subset(jdd, type == "eclat" | type == "lame" | type == "nucleus a eclats laminaires",)

plan +
  geom_point(data = jdd.lamn, mapping = aes(x = x..cm., y = y..cm., color = silex, 
                                             fill = silex, shape = type_fac, size = 1)) +
  # légende
  labs(color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")


##### A REDIGER AUSSI 
# découverte du loop !

