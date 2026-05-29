# TP 1 & 2 ####

## 1.
### 1.1.
#install.packages("archdata")
library(archdata)

### 1.2. 
help(archdata)
?archdata

data("DartPoints")

## 2.
### 2.1. 
DartPoints
ncol(DartPoints) # 17
nrow(DartPoints) # 91

### 2.2.
summary(DartPoints) 
class(DartPoints$Name) 
class(DartPoints$Length) #character, numeric, factor : 3 

### 2.3.
Darl <- DartPoints[DartPoints$Name == "Darl",] # exemple avec le premier type 
summary(Darl)

#boucle pour obtenir un tableau final 
df <- data.frame(levels(DartPoints$Name)) #create df with points types for each row
colnames(df) <- c("Types")

df$Length_Median <- NA #initialise col for each stat
df$Length_Range <- NA
df$Width_Median <- NA
df$Width_Range <- NA
df$Thickness_Median <- NA
df$Thickness_Range <- NA

for(i in 1:nrow(df)){
  type <- DartPoints[DartPoints$Name == levels(DartPoints$Name)[i], ]#retrieving data for each type
  
  df$Length_Median[i] <- median(type$Length) 
  df$Length_Range[i] <- max(type$Length) - min(type$Length)
  df$Width_Median[i] <- median(type$Width) 
  df$Width_Range[i] <- max(type$Width) - min(type$Width)
  df$Thickness_Median[i] <- median(type$Thickness) 
  df$Thickness_Range[i] <- max(type$Thickness) - min(type$Thickness)
  
  i <- i + 1
}
df #tableau de résultats


## 3.
### 3.1.
?DartPoints #vérifier les levels 

#test du plot
plot(x = DartPoints$Width, y = DartPoints$B.Width,
     bg = DartPoints$Base.Sh, 
     pch = c(21, 22, 23, 24, 25)[as.numeric(DartPoints$Name)], 
     cex = 1.5,
     xlab = "Width (mm)", ylab = "Base width (mm)")
##rajout légende
legend("topright",
       legend = c("Excurvate", "Incurvate", "Recurvate", "Straight", "No Data"), fill = 1:5, 
       title = "Base Shape", cex = 0.7)
legend(40, 21.8, 
       legend = levels(DartPoints$Name), pch = 21:25,
       title = "Dart point type", cex = 0.7) 

#sauvegarde : manuelle ou avec la commande suivante 
pdf("figures/Figure_TP1.pdf",
    width = 7, height = 4.8)

plot(x = DartPoints$Width, y = DartPoints$B.Width,
     bg = DartPoints$Base.Sh, 
     pch = c(21, 22, 23, 24, 25)[as.numeric(DartPoints$Name)], 
     cex = 1.5,
     xlab = "Width (mm)", ylab = "Base width (mm)")

legend("topright",
       legend = c("Excurvate", "Incurvate", "Recurvate", "Straight", "No Data"), fill = 1:5, 
       title = "Base Shape", cex = 0.7)
legend(40, 21.8, 
       legend = levels(DartPoints$Name), pch = 21:25,
       title = "Dart point type", cex = 0.7) 

dev.off()


### 3.2. 
#length
jpeg("figures/boxplot_length.jpg",
     width = 550, height = 450)
boxplot(Length ~ Name, data = DartPoints, 
        main = "Plot of length by dart point type", xlab = "Dart point type", ylab = "Length (mm)",
        col = c("#fde725", "#5ec962", "#21918c", "#3b528b", "#440154"),
        frame = FALSE)
dev.off()

#width
jpeg("figures/boxplot_width.jpg",
     width = 550, height = 450)
boxplot(Width ~ Name, data = DartPoints, 
        main = "Plot of width by dart point type", xlab = "Dart point type", ylab = "Width (mm)",
        col = c("#fde725", "#5ec962", "#21918c", "#3b528b", "#440154"),
        frame = FALSE)
dev.off()

#thickness
jpeg("figures/boxplot_thickness.jpg",
     width = 550, height = 450)
boxplot(Thickness ~ Name, data = DartPoints, 
        main = "Plot of thickness by dart point type", xlab = "Dart point type", ylab = "Thickness (mm)",
        col = c("#fde725", "#5ec962", "#21918c", "#3b528b", "#440154"),
        frame = FALSE)
dev.off()



# TP 3 : sous-ensembles et visualisation avec tidyverse ####
## 1.
jdd <- read.csv("data/Data_exemple.csv", header = TRUE, sep = ",")

library(archdata)
data("DartPoints")

## 2.
### 2.1. 
jdd.silexBC <- subset(jdd, silex != "type A",)

plan.modif +
  geom_point(data = jdd.silexBC, 
             mapping = aes(x = x_cm, y = y_cm, 
                           color = silex, fill = silex,
                           shape = type_fac, size = 1)) +
  # titre et légende
  labs(title = "Répartition spatiale des objets en silex autres que de type A", 
       color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")


### 2.2.
jdd.lamn <- subset(jdd, type == "eclat" | type == "lame" | 
                     type == "nucleus a eclats laminaires",)
plan.modif +
  geom_point(data = jdd.lamn, 
             mapping = aes(x = x_cm, y = y_cm, 
                           color = silex, fill = silex, 
                           shape = type_fac, size = 1)) +
  # titre et légende
  labs(title = "Répartition spatiale des pièces non retouchées pouvant
       s'intégrer dans un schéma laminaire",
       color = "Matière première", shape = "Catégorie d'objet") +
  guides(fill = "none", size = "none")


### 2.3.
summary(DartPoints$Blade.Sh)

### 2.4.
d <- subset(DartPoints, Blade.Sh == "E" | Blade.Sh == "S")
summary(d$H.Length)

E <- subset(DartPoints, Blade.Sh == "E")
ggplot(data = E, aes(x = Thickness, y = Length/Width, 
                     color = H.Length)) +
  geom_point() +
  scale_x_continuous(limits=c(0, 15), expand=c(0, 0)) +
  scale_y_continuous(limits=c(1.5, 4.5), expand=c(0, 0)) +
  scale_color_distiller(direction = 1, limits=c(5,24)) +
  theme_linedraw() +
  labs(title = "Module d'allongement versus épaisseur pour les pointes de type E", 
       color = "Longueur de l'emmanchement")

S <- subset(DartPoints, Blade.Sh == "S",)
ggplot(data = S, aes(x = Thickness, y = Length/Width, 
                     color = H.Length)) +
  geom_point() +
  scale_x_continuous(limits=c(0, 15), expand=c(0, 0)) +
  scale_y_continuous(limits=c(1.5, 4.5), expand=c(0, 0)) +
  scale_color_distiller(direction = 1, limits=c(5,24)) +
  theme_linedraw() +
  labs(title = "Module d'allongement versus épaisseur pour les pointes de type S", 
       color = "Longueur de l'emmanchement")




# TP 4 : SIG avec R ####
data("Acheulean")