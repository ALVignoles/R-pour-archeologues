# TP 1 & 2 ####
## 1.
### 1. 
#install.packages("archdata")
library(archdata)

### 2. 
help(archdata)
?archdata

data("DartPoints")

## 2.
### 1. 
DartPoints
ncol(DartPoints) # 17
nrow(DartPoints) # 91

### 2.
summary(DartPoints) 
class(DartPoints$Name) 
class(DartPoints$Length) #character, numeric, factor : 3 

### 3.
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
### 1.
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


### 2. 
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

# TP 3 : faire des boucles ####
data("BarmoseI.pp")
data(BarmoseI.grid)
plot(BarmoseI.grid$East, BarmoseI.grid$North)
points(BarmoseI.pp$East, BarmoseI.pp$North, col = BarmoseI.pp$Class)

data("Snodgrass")

# TP 4 : SIG avec R ####
data("Acheulean")