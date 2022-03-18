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

cl <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(lan2011$B1_sre, col=cl)

