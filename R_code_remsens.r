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


