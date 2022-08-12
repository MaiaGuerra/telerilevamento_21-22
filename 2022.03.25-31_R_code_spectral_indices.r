# 25/03/2022 INDICI SPETTRALI

library(raster)
setwd("C:/lab/")

l1992 <- brick("defor1_.jpg") # carichiamo un'immagine già elaborata del Landsat
l1992

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# visualizziamo la foresta del Rio Peixoto con l'infrarosso nel rosso (NIR in r)
# nelle immagini originali di landsat la banda NIR è sempre la 4, mentre in questa che è già elaborata corrisponde all'1
# sono passati da un immagine con oggetti r=4, g=3, b=2 a r=1, g=2, b=3
# siamo sicuri che l'1 in r in questa immagine già elaborata sia l'infrarosso, perchè la vegetazione è diventata tutta rossa (r)
# andando in ordine partendo dalla successione dei colori nello spettro elettromagnetico, dopo l'infrarosso c'è
# il rosso che in questo caso è il 2 probabilmente, e corrisponde alla parte di immagine che si è colorata in verde (g)
# il 3 invece 

l2006 <- brick("defor2_.jpg") # carichiamo la seconda immagine modificata del Landsat
l2006

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")


par(mfrow=c(2,1)) # par è la funzione per parametri grafici
plotRGB(l1992, r=1, g=2, b=3, stretch="lin") # costruiamo multiframe di due immagini per visualizzare le differenze tra le due situazioni tra il '92 e il 2006
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI (Difference Vegetation Index)

dvi1992 = l1992[[1]] - l1992[[2]]
dvi1992

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992, col=cl)

dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

plot(dvi2006, col=cl)
dev.off()

dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)

plot(dvi_dif, col=cld)
# con questo plot riusciamo a visualizzare le zone nelle quali dal 1992 al 2006 è avvenuta deforestazione e con quale intensità
# i valori della legenda sono l'indice dvi e indicano l'intensità della deforestazione attraverso la salute delle piante
# l'indice si basa sulla salute delle piante, che riflettono diversamente l'infrarosso a seconda delle loro condizioni di salute


# 31/03/2022

# Range DVI (immagine a 8 bit): - 255 a 255
# Range DVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1 
# NDVI varia sempre da -1 a 1 a prescindere dai bit dell'immagine, perciò può essere utiizzato per fare confronti


library(raster) # raster = da rastrum, che significa "aratro" in inglese
setwd("C:/lab/")

l1992 <- brick("defor1_.jpg")
l1992 # l'immagine è a 8 bit perchè vediamo tra i valori come minimo 0 e massimo 256

l2006 <- brick("defor2_.jpg")
l2006 # anche questa è a 8 bit


# NDVI 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])

ndvi1992 # il range è tra -1 e 1

cl <- colorRampPalette(c('darkblue','yellow','red','blue')) (100)
plot(ndvi1992, col=cl)

# multiframe con immagine della foresta nel '92 e NDVI correlato
par(mfrow=c(2, 1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

# l'acqua del fiume, a differenza di quella del mare, al sensore del satellite appare chiara invece che nera perchè ha molti sali disciolti che riflettono


# NDVI 2006
dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

# multiframe con NDVI1992 sopra e NDVI2006 sotto
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)


# Indici spettrali (si = spectral indices) automatici
install.packages("rgdal")
library(RStoolbox)

# vediamo gli indici spettrali per l'immagine del 1992
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992, col=cl)
# mostra tutti gli indici spettrali possibili calcolabili su quell'immagine
# NDWI calcola l'ammontare di acqua rilevato per ogni pixel dell'immagine

# vediamo gli indici spettrali anche per quella del 2006
si2006 <- spectralIndices(l2006, green=3, red=2, nir=1)
plot(si2006, col=cl)

install.packages("rasterdiv")
library(rasterdiv)

# immagine globale NDVI
plot(copNDVI) # verde =NDVI più alto, giallo = NDVI più basso (valori della biomassa)



