# Pour débuter avec R

## Installer  
[R](https://cran.r-project.org/bin/macosx/)  
[R studio](https://www.rstudio.com/products/rstudio/download/)

## Pour commencer
Toujours ouvrir R et Rstudio en même temps. La fenêtre de R peut juste rester en arrière plan, il n'est pas nécessaire d'interagir avec.  
Pour commencer installons l'environnement de travail. Pour cela il faut installer un certain nombre de packages qui permettent d'utiliser des fonctionnalités particulières, comme cela est évoqué dans [l'introduction](https://r4ds.had.co.nz/introduction.html#the-tidyverse) du volume 'R for Data Science'.

Avant notre prochaine session de travail, il faudrait que tu aies installé les packages suivants:
```{r}
install.packages("tidyverse")
install.packages("knitr")
install.packages("rmarkdown")
install.packages("bookdown")
install.packages("DBI")
install.packages("dbplyr")
install.packages("RSQLite")
```
Pour cela tu dois copier ces commandes telles quelles dans la fenetre haut gauche de R studio et les exécuter une par une en utilisant les touches  
Command (or Cmd) &#8984; **+** Entrer ↵ Return

Les packages seront installés définitivement dans R studio.  
Pour les utiliser il faudra exécuter les lignes de code suivantes:
```{r}
library(tidyverse)
library(knitr)

# etc.
```
Les packages devront être activés à chaque début de session R.  


## Premiers pas
Pour prendre en main R, voir toute l'introduction de [R for Data Science](https://r4ds.had.co.nz/index.html) par Hadley Wickham et Garrett Grolemund, notamment pour les activités proposées à partir des dataframes (jeux de données en table) directement insérés dans les packages, tel que `mpg` dans ggplot2 ([`ggplot2::mpg`](https://ggplot2.tidyverse.org/reference/mpg.html)). Il y est expliqué ce qu'est un dataframe, comment l'explorer, le manipuler, et produire des visualisation des données qu'il contient.  

Pour s'aider à utiliser les principaux packages, il existe des fiches aide-mémoire (cheatsheets) mises en lignes sur le [site officiel de Rstudio](https://www.rstudio.com/resources/cheatsheets/).

## Ressources en ligne
Voir également les ressources en ligne listées [ici](https://github.com/tupuni/karno-elliott-master-1/blob/main/ressources-en-ligne.md)

