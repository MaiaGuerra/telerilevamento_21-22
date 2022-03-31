# questo è il primo script che useremo a lezione (04.03.2022)

library(raster)

setwd("C:/lab/") # definiamo la cartella di lavoro
lan2011 <- brick("p224r63_2011.grd") # assegniamo a un oggetto che decidiamo noi la funzione brick che crea un oggetto RaterBrick
lan2011
plot(lan2011) # plottiamo per costruire l'immagine dal dato .grd

cl <- colorRampPalette(c("black", "grey", "light grey")) (100) # con questa funzione definiamo una nuova palette di colori per la legenda delle immagini restituite dal plot e la assegniamo a un oggetto
plot(lan2011, col=cl) # riplottiamo con la nuova palette di colori


# 18.03.2022

# plottiamo la banda del blu, che nell'immagine satelitare caricata lan2011 è definita col nome B1_sre, corrispondente all'elemento di indice [1]
plot(lan2011$B1_sre)
plot(lan2011[[1]])

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(lan2011$B1_sre, col=cl)

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(lan2011$B1_sre, col=clb)

# esportiamo il plot in pdf nella cartella lab
pdf("banda1.pdf")
plot(lan2011$B1_sre, col=clb)
dev.off()

# possiamo esportarlo ache come png
png("banda1.png")
plot(lan2011$B1_sre, col=clb) 
dev.off()

# plottiamo la banda del verde con 3 livelli di colore
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(lan2011$B2_sre, col=clg) 

# multiframe
par(mfrow=c(1,2)) # plot con 1 riga e due colonne in cui si visualizzano entrambe le immagini con la banda del blu a sinista e quella del verde a destra
plot(lan2011$B1_sre, col=clb)
plot(lan2011$B2_sre, col=clg)

# esportiamo il multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(lan2011$B1_sre, col=clb)
plot(lan2011$B2_sre, col=clg)
dev.off()

# esercizio: ribaltare il multiframe
par(mfrow=c(2,1))
plot(lan2011$B1_sre, col=clb)
plot(lan2011$B2_sre, col=clg)
dev.off()

# plottiamo le prime 4 bande
par(mfrow=c(2,2))
# banda blu
plot(lan2011$B1_sre, col=clb) 
# banda verde
plot(lan2011$B2_sre, col=clg) 
# banda rossa
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(lan2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(lan2011$B4_sre, col=clnir)


# 24/03/2022

library(raster)
setwd("C:/lab/")

l2011 <- brick("p224r63_2011.grd") # p = path, r = row, p224 = path 224 (percorso fatto dal satellite attorno alla Terra), r63 = riga 63 (incrociando riga e path (colonna) individuiamo l'immagine di riferimento)

# plottare immagine l2011 nella banda dell'infrarosso vicino (NIR)

l2011 # cerchiamo che nome ha la banda dell'infrarosso (è B4_sre (spectral reflectance))
# B1 = blu
# B2 = verde
# B3 = rosso
# B4 = infrarosso vicino (NIR)

colnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre) # plotta la banda infrarossa ma con colori bruttini
plot(l2011$B4_sre, col=colnir)

# i pc e altri tipi di schermi moderni utilizzano il sistema RGB per riprodurre i colori


plotRGB(l2011, r=3, g=2, b=1, stretch="lin") # plotta immagini satellitari fatte di vari layer, permette di plottare le bande che vogliamo
# l'argomento stretch amplia i valori in modo che possiamo vedere i contrasti il più possibile
# visualizziamo un'immagine detta "a colori naturali"
# ha una parte in cui non sono stati registrati valori (parte simile a dendriti neri/blu scuro)

plotRGB(l2011, r=4, g=3, b=2, stretch="lin") # per inserire la banda dell'infrarosso nell'immagine manteniamo la banda 2 e 3 e sostituiamo all'argomento r (banda del rosso) il numero 4 che definisce la banda dell'infrarosso vicino
# attenzione a inserire i nuovi valori numerici (2, 3 e 4) facendo "scorrere" i numeri precedenti

# spostiamo l'infrarosso dalla componente red alla green
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# così facendo vediamo la banda dell'infrarosso colorata di verde

plotRGB(l2011, r=3, g=2, b=4, stretch="lin") # plottando l'infrarosso nella banda del blu (si fa mettendo il 4 nell'oggetto b che è la banda del blu) si notano meglio le zone di suolo nudo (giallognole)

plotRGB(l2011, r=3, g=4, b=2, stretch="hist") # specificando "hist" come stretch e mettendo l'infrarosso nel verde si notano meglio le zonazioni della foresta e le differenze nella vegetazione (viola = giallo di prima, ovvero suolo nudo)
# come si sceglie dove mettere l'infrarosso? non c'è uno schema ideale, si sceglie quale delle combinazioni restituisce meglio i dettagli che ci servono

# multiframe = insieme di più immagni
# costruire multiframe con immagine a RGB visibile (linear stretch) sopra l'immagine a falsi colori (histigram stretch)

par(mfrow=c(2, 1)) # mf = multiframe, row = ragiona per righe, prima 2 a definire che vogliamo due righe, poi 1 per definire che vogliamo una colonna
plotRGB(l2011, r=3, g=2, b=1, stretch="lin") # immagine a colori naturali
plotRGB(l2011, r=3, g=4, b=2, stretch="hist") # immagine con infrarosso nel verde e stretch più marcato
dev.off()

# prendiamo l'immagine della stessa zona ma nel 1988

l1988 <- brick("p224r63_1988.grd")
l1988

# costruiamo un multiframe per visualizzare la situazione della foresta del Parakana (Brasile) nel 1988 e poi nel 2011
par(mfrow=c(2, 1)) # par è una funzione generale per la costruizione di grafici
plotRGB(l1988, r=4, g=3, b=2, stretch="lin") # in entrambe le immagini l'infrarosso è nella banda del rosso
plotRGB(l2011, r=4, g=3, b=2, stretch="lin") # si nota la differenza tra le due situazioni nell'estensione maggiore di strade e campi coltivati dall'88 al 2011
# l'immagine sopra (1988) pare più sbiadita solo perchè il sensore usato era di tipologia diversa


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

l2006 <- brick("defor2_.jpg")
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


