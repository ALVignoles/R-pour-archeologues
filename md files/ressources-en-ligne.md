# R et archéologie : les ressources en ligne
## Ressources en ligne sur l'usage générique de R
Voici quelques ressources pour découvrir le fonctionnement général de R et R studio :  
- [le blog d'Allison Horst](https://external.ink?to=/blog.rstudio.com/2019/11/18/artist-in-residence/)  
- [Big Book of R](https://external.ink?to=/www.bigbookofr.com/) par Oscar Baruffa  
- [R for Data Science](https://external.ink?to=/r4ds.had.co.nz/index.html) par Hadley Wickham et Garrett Grolemund  
- [Découvrir R et RStudio](https://external.ink?to=/mtes-mct.github.io/parcours_r_socle_introduction/) est un manuel en français réalisé par Thierry Zorn, Murielle Lethrosne, Vivien Roussez, Pascal Irz & Nicolas Torterotot. Il s'agit d'un dispositif de formation proposé par les Ministères de la transition écologique et solidaire (MTES), et de la Cohésion des territoires et des Relations avec les collectivités territoriales (MCTRCT) du gouvernement français.  
- Un document présentant la [Gestion des données avec R](https://external.ink?to=/lms.fun-mooc.fr/c4x/UPSUD/42001S02/asset/data-management.html) est proposé par Christophe Lalanne et Bruno Falissard. Il y est notamment expliqué sous quelle forme apparaissent les données par rapport à excel (concept de data frame) et comment les importer pour travailler dans Rstudio.  
- L'[Introduction à R et au tidyverse](https://external.ink?to=/juba.github.io/tidyverse/) est un livre en français par Julien Barnier (déposé également [sur Zenodo](https://external.ink?to=/doi.org/10.5281/zenodo.6382599)) qui fait le point sur la prise en main de R et Rstudio, le concept de dataframe, les analyses univariées et bivariées, les visualisations et les représentations graphiques. Il propose également des "manuels d'utilisation" pour plusieurs packages courant dans le tidyverse (tels que ggplot2, dplyr, stringr, tidyr et rmarkdown), et propose de nombreux exercices.  
- Pour s'aider à utiliser les principaux packages, il existe des fiches aide-mémoire (cheatsheets) mises en lignes sur le [site officiel de Rstudio/Posit](https://external.ink?to=/rstudio.com/resources/cheatsheets/).  
- Les packages R sont rencensés sur [https://rdocumentation.org/](https://external.ink?to=/rdocumentation.org/).  

## Ressources concernant l'usage de R pour des applications en archéologie
- [Ben Marwick](https://external.ink?to=/rdocumentation.org/github.com/benmarwick) est professeur à l'Université de Washington et est l'un des archéologues les plus actifs dans le développement de pratiques liées à l' "ouverture" des données et à la reproductibilité des analyses et codes sources.  
A voir notamment 
[ce powerpoint](https://external.ink?to=/rdocumentation.org/benmarwick.github.io/tidyverse-for-archaeology/tidyverse-for-archaeology.html#1) par B Marwick et le repository associé dans [ctv-archaeology](https://external.ink?to=/rdocumentation.org/github.com/benmarwick/ctv-archaeology#making-maps-and-using-r-as-a-geographical-information-system).  
le CRAN Task view archéologie, qui constitute une documentation ouverte concernant l'usage de R en archéologie a été mise en ligne [accessible ici](https://external.ink?to=/github.com/benmarwick/ctv-archaeology).  
On y trouve une liste des packages (liés à leur description sur github ou [Comprehensive R Archive Network (CRAN)](https://external.ink?to=/cran.rstudio.com/)) regroupés par catégories liés aux différentes étapes du traitement de données :  
[1/ l'acquisition des données](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#data-acquisition)  
[2/ la manipulation des données](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#data-manipulation)  
[3/ la visualisation des données](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#visualising-data)  
[4/ les analyses statistiques](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#analysis-in-general)  
[5/ la réalisation de cartes](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#making-maps-and-using-r-as-a-geographical-information-system)  
[6/ la calibration de dates](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#dating)  
etc.
Ainsi qu'une [liste des publications dans le domaine de l'archéologie qui incluent des scripts R](https://external.ink?to=/github.com/benmarwick/ctv-archaeology#publications-that-include-r-code).  

- [ce powerpoint](https://external.ink?to=/hal.science/hal-03287121/file/plutniak2021rconference.pdf) par Sébastien Plutniak.   
- [open-archaeo.info](https://external.ink?to=/open-archaeo.info), un répertoire de ressources maintenu par [Zack Batist](https://external.ink?to=/github.com/zackbatist).
- Le [site web Rchaeology](https://external.ink?to=/rchaeology.github.io/about/) a une [page dédiée aux débutants](https://external.ink?to=/rchaeology.github.io/resources/beginners/).
- Le package [**swirl**](https://external.ink?to=/swirlstats.com/) a été créé pour aider l'apprentissage de R. Après l'avoir installé et ouvert avec les commandes suivantes il ne reste plus qu'à suivre les instructions directement dans la console de R studio!
```{r}
install.packages("swirl")
library(swirl)
```

## :books: Ressources en français :books:

* [Introduction à R et au tidyverse](https://external.ink?to=/juba.github.io/tidyverse/) par @juba
* [Logiciel R et programmation](https://external.ink?to=/egallic.fr/Enseignement/R/m1_stat_eco_logiciel_R.pdf) par @3wen
* [Programmer en R](https://external.ink?to=/fr.wikibooks.org/wiki/Programmer_en_R), wikibook collaboratif (licence CC-BY-SA)
* [Introduction à l'analyse d'enquêtes avec R et RStudio](https://external.ink?to=/larmarange.github.io/analyse-R/) par @larmarange
* [R et espace](https://external.ink?to=/framabook.org/r-et-espace/) : manuel d’initiation à la programmation avec R appliqué à l’analyse de l’information géographique, librement téléchargeable en ligne.
* Le [pôle bioinformatique lyonnais](https://external.ink?to=/pbil.univ-lyon1.fr/R/) propose depuis longtemps une somme très importante de documents, qui comprend des cours complets de statistiques utilisant R.
* [Introduction à la programmation en R](https://external.ink?to=/cran.r-project.org/doc/contrib/Goulet_introduction_programmation_R.pdf)
* [C'est l'enfeR](https://external.ink?to=/bioinfo-fr.net/cest-lenfer) donne des exemples de code simple avec R qui donnent des résultats surprenants.
* [Documentation francophone référencée sur CRAN](https://external.ink?to=/cran.opencpu.org/other-docs.html#nenglish)
* [Manuel d’analyse spatiale : Théorie et mise en oeuvre pratique avec R](https://external.ink?to=/insee.fr/fr/information/3635442), Insee Méthodes n° 131 - octobre 2018 par [@inseefr](https://external.ink?to=/github.com/inseefr)
* [Se former au logiciel R : initiation et perfectionnement](https://external.ink?to=/myrbookfr.netlify.com/), François Rebaudo, 2019-02-13.
* [Le grimoire statistique : Contes et stats R](https://external.ink?to=/perso.ens-lyon.fr/lise.vaudor/grimoireStat/_book/intro.html) par @lvaudor
* [UtilitR](https://external.ink?to=/utilitr.org/) manuel de R par les agents de l'Insee
* [Les données spatiales avec R](https://external.ink?to=/github.com/MaelTheuliere/rspatial) par @MaelTheuliere, support de cours sur l'analyse spatiale avec R et sf
* [Contes et stats R](https://external.ink?to=/perso.ens-lyon.fr/lise.vaudor/grimoireStat/_book/intro.html#pourquoi-ce-livre) par Lise Vaudor
