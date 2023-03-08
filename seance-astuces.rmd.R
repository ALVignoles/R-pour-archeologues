

https://cran.r-project.org/web/packages/qpdf/qpdf.pdf
install.packages("qpdf")
library(qpdf)

qpdf::pdf_compress(                             # compresse le pdf
  input = "data/exemple.pdf",                   # fichier à traiter
  output = "figures/qpdf/exemple-compress.pdf") # fichier obtenu

qpdf::pdf_subset(                       # échantillonne le pdf
  input = "data/exemple.pdf",           # fichier à traiter
  pages = c(1:4),                       # choisir un ensemble de pages
  #pages = c(1,2,3,4),                  # vs choisir des pages individuellement
  output = "figures/qpdf/exemple-subset.pdf")

qpdf::pdf_split(                               # sépare toutes les pages
  input = "figures/qpdf/exemple-subset.pdf",   # fichier à traiter
  output = "figures/qpdf/page")                # préfixe   

qpdf::pdf_combine(                              # combine deux pdf
  input = c("data/exemple.pdf",                 # fichiers à traiter
            "figures/qpdf/exemple-subset.pdf"),
  output = "figures/qpdf/exemple-combined.pdf") # fichier obtenu

qpdf::pdf_rotate_pages(       # change l'orientation des pages
  input = "data/exemple.pdf", # fichier à traiter
  pages = c(2:3),             # choisir un ensemble de pages
  #pages = c(2,3),            # vs choisir des pages individuellement
  angle = 90,                 # choisir l'angle de rotation
  relative = FALSE,           # si TRUE, les pages tournent par rapport à l'orientation actuelle
                              # si FALSE, la rotation se fait sur des valeurs absolues: 0 = portrait, 
                              # 90 = landscape rotation à 90 degrés dans le sens des aiguilles
  output = "figures/qpdf/exemple-rotated.pdf" # fichier obtenu
  )
  
qpdf::pdf_length(             # indique le nombre de pages dans un pdf
  input = "data/exemple.pdf"  # fichier à traiter
)
