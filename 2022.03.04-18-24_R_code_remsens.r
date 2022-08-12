# questo è il primo script che useremo a lezione (04.03.2022)

# 10.03.2022
library(raster)

setwd("C:/lab/") # definiamo la cartella di lavoro
lan2011 <- brick("p224r63_2011.grd") # assegniamo a un oggetto che decidiamo noi la funzione brick che crea un oggetto RasterBrick
# il nome dell'immagine indica il codice con cui si identificano le immagini landsat
# Durante la sua orbita il satellite acquisisce immagini (NON foto!) attraverso dei sensori che fanno una sorta di scanner alla superficie terrestre.
# Il satellite scannerizza seguendo i meridiani del pianeta (orbita circolare), e una volta riportati i percorsi (circolari) su una mappa, questi appaiono come delle
# sinusoidi. Questi percorsi vengono chiamati "path", e vengono numerati. Essi sono ulteriormente divisi da righe orizzontali che seguono il senso dei paralleli,
# dette "row".

# Nel codice che identifica ogni immagine:
# p = path, indica a quale dei cammini percorsi dal satellite appartiene l'immagine, identificato dal numero (es. p224)
# r = row, indica quale riga identifica l'immagine all'interno del path già indicato (es. r63)

lan2011
# analisi immagine landsat
# classe (class): RasterBrick
# dimensioni (dimensions): 1499, 2967, 4447533, 7 (nrow, ncol, ncell, nlayers)
## ncell= n° di pixel (dati di riflettanza uno accanto all'altro)
## nlayers = n° di layer (bande) -> ogni banda ha 4 milioni circa di pixel! -> 4x7 = 28, abbiamo circa 30 milioni di dati!
# resolution (risoluzione): 30, 30 (x, y) indica a quanto corrisponde ogni immagine nella realtà (30m x 30m)
# extent
# crs (coordinate reference system): +proj=utm +zone=22 + datum=WGS84 +units=m +no_defs
# source (sorgente): p224r63.grd
# names: B1_sre, B2_sre, B3_sre, B4_sre, B5_sre, B6_sre, B7_sre (nomi delle bande, sre = spectral reflectance, bt = banda termica)
## banda del blu = banda 1 = B1_sre
## RIFLETTANZA = quanto flusso radiante entra / quanto flusso radiante viene riflesso
## riflettanza = 0, tutta la radiazione viene assorbita, niente viene riflesso
## riflettanza = 1, tutta la radiazione viene riflessa, niente viene assorbito
## non sempre i valori vanno da 0 a 1, a volte vanno anche da 0 a 255
# min values: sono sempre tutti 0 tranne banda del termico
# max values:

plot(lan2011) # plottiamo per costruire l'immagine dal dato .grd

cl <- colorRampPalette(c("black", "grey", "light grey")) (100) # con questa funzione definiamo una nuova palette di colori per la legenda delle immagini restituite dal plot e la assegniamo a un oggetto
plot(lan2011, col=cl) # riplottiamo con la nuova palette di colori

# 11.03.2022 ripasso su sistemi di riferimento

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

