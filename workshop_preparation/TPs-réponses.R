# TP 1 ####
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
class(DartPoints$Name) #character, numeric, factor : 3 


# TP 2 : visualiser un jeu de données #### 
data("DartPoints")


# TP 3 : faire des boucles ####
data("BarmoseI.pp")
data(BarmoseI.grid)
plot(BarmoseI.grid$East, BarmoseI.grid$North)
points(BarmoseI.pp$East, BarmoseI.pp$North, col = BarmoseI.pp$Class)

data("Snodgrass")

# TP 4 : SIG avec R ####
data("Acheulean")