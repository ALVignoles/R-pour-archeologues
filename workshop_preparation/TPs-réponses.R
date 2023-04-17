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


# TP 3 : faire des boucles ####
data("BarmoseI.pp")
data(BarmoseI.grid)
plot(BarmoseI.grid$East, BarmoseI.grid$North)
points(BarmoseI.pp$East, BarmoseI.pp$North, col = BarmoseI.pp$Class)

data("Snodgrass")

# TP 4 : SIG avec R ####
data("Acheulean")