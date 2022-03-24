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

