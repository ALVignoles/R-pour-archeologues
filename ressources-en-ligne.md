# R et archéologie  

## Ressources en ligne sur l'usage générique de R
Voici quelques ressources pour découvrir le fonctionnement général de R et R studio :  
- [le blog d'Allison Horst](https://blog.rstudio.com/2019/11/18/artist-in-residence/)  
- [Big Book of R](https://www.bigbookofr.com/) par Oscar Baruffa  
- [R for Data Science](https://r4ds.had.co.nz/index.html) par Hadley Wickham et Garrett Grolemund  
- [Découvrir R et RStudio](https://mtes-mct.github.io/parcours_r_socle_introduction/) est un manuel en français réalisé par Thierry Zorn, Murielle Lethrosne, Vivien Roussez, Pascal Irz & Nicolas Torterotot. Il s'agit d'un dispositif de formation proposé par les Ministères de la transition écologique et solidaire (MTES), et de la Cohésion des territoires et des Relations avec les collectivités territoriales (MCTRCT) du gouvernement français.  

## Ressources concernant l'usage de R pour des applications en archéologie
- [Ben Marwick](https://github.com/benmarwick) est professeur à l'Université de Washington et est l'un des archéologues les plus actifs dans le développement de pratiques liées à l' "ouverture" des données et à la reproductibilité des analyses et codes sources.  
A voir notamment 
[ce powerpoint](https://benmarwick.github.io/tidyverse-for-archaeology/tidyverse-for-archaeology.html#1) par B Marwick et le repository associé dans [ctv-archaeology](https://github.com/benmarwick/ctv-archaeology#making-maps-and-using-r-as-a-geographical-information-system).  
le CRAN Task view archéologie, qui constitute une documentation ouverte concernant l'usage de R en archéologie a été mise en ligne [accessible ici](https://github.com/benmarwick/ctv-archaeology).  
On y trouve une liste des packages (liés à leur description sur github ou [Comprehensive R Archive Network (CRAN)](https://cran.rstudio.com/)) regroupés par catégories liés aux différentes étapes du traitement de données :  
[1/ l'acquisition des données](https://github.com/benmarwick/ctv-archaeology#data-acquisition)  
[2/ la manipulation des données](https://github.com/benmarwick/ctv-archaeology#data-manipulation)  
[3/ la visualisation des données](https://github.com/benmarwick/ctv-archaeology#visualising-data)  
[4/ les analyses statistiques](https://github.com/benmarwick/ctv-archaeology#analysis-in-general)  
[5/ la réalisation de cartes](https://github.com/benmarwick/ctv-archaeology#making-maps-and-using-r-as-a-geographical-information-system)  
[6/ la calibration de dates](https://github.com/benmarwick/ctv-archaeology#dating)  
etc.
Ainsi qu'[une liste des publications dans le domaine de l'archéologie qui incluent des scripts R](https://github.com/benmarwick/ctv-archaeology#publications-that-include-r-code).  

- [ce powerpoint](https://rzine.fr/publication/20210713_archeologie_usages_disciplinaires_de_r/) par Sébastien Plutniak (cliquer sur consulter pour télécharger).    
- [open-archaeo.info](https://open-archaeo.info), un répertoire de ressources maintenu par [Zack Batist](https://github.com/zackbatist).
- Le [site web Rchaeology](https://rchaeology.github.io/about/) a une [page dédiée aux débutants](https://rchaeology.github.io/resources/beginners/).
- Le package [**swirl**](https://swirlstats.com/) a été créé pour aider l'apprentissage de R. Après l'avoir installé et ouvert avec les commandes suivantes il ne reste plus qu'à suivre les instructions directement dans la console de R studio!
```{r}
install.packages("swirl")
library(swirl)
```

