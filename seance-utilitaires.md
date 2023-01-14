## 📖 Packages utilitaires

De nombreux packages permettent de manipuler des fichiers librement, rapidement et gratuitement, plutôt que de passer par des logiciels propriétaires. 
Voici une liste non exhaustive:

📦 [qpdf](https://cran.r-project.org/web/packages/qpdf/index.html) permet de transformer des PDF (séparer, combiner, compresser) en préservant le contenu.
```{r}
install.packages("qpdf")
library(qpdf)
qpdf::pdf_combine(input = c("doc1.pdf", "doc2.pdf"),
                  output = "doc3-combiné.pdf")
```

📦 [pdftools](https://cran.r-project.org/web/packages/pdftools/index.html)
Package basé sur 'libpoppler' qui permet d'extraitre du texte, des polices d'écriture, des documents insérés et des métadonnées depuis un fichier PDF. 
Permet également de convertir des PDF aux formats PNG, JPEG, TIFF format, ou en raw bitmap vectors pour utilisation dans R.
```{r}
install.packages("pdftools")
library(pdftools)
```

📦 [R.utils](https://cran.r-project.org/web/packages/R.utils/index.html)
```{r}
install.packages("R.utils")
library(R.utils)
```
