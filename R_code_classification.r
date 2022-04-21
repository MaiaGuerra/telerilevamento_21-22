# 08/04/2022 IMMAGINI SOLAR ORBITER ESA

library(RStoolbox)
library(raster)
setwd("C:/lab/")

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun.jpg")
so

plotRGB(so, 1, 2, 3, stretch="lin")

# costruiamo un modello con la funzione unsuperClass, che raggruppa in modo casuale i raster caricati con un algoritmo di kmeans clustering
# il k means clustering è un algoritmo che divide un insieme di oggetti in k gruppi sulla base dei loro attributi
soc <- unsuperClass(so, nClasses=3) # nel modello è compresa una mappa che decidiamo di dividere i 3 categorie energetiche (cluster)
# la valutazione della categoria nella quale cade ogni pixel è randomica, come definito dalla funzione stessa
# possiamo verificare le classi in cui abbiamo impostato la divisione dei pixel nell'ultima riga delle statistiche del modello (values)
soc

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc$map, col=cl) # plottiamo solo la mappa del modello, visualizzando le 3 classi che abbiamo stabilito
# classe rossa = a più alta energia
# classe nera = intermedia
# classe gialla = a più bassa energia
# in realtà ogni persona che ha usato il codice ottiene mappe diverse a livello di colori
# perchè l'algoritmo raggruppa in modo casuale i pixel dell'immagine nelle 3 categorie che abbiamo impostato,
# prendendo casualmente 10000 pixel sul totale dei pixel dell'immagine (7669050 pixel) ma in maniera diversa ogni volta che viene utilizzato.
# L'algoritmo mantiene però il pattern spaziale dell'immagine (se il numero di categorie in cui è stata divisa rimane lo stesso)



# 21/04/2022 Analisi immagini Grand Canyon

setwd("C:/lab/")
library(raster)
library(RStoolbox)

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") # gc = grand canyon
gc


plotRGB(gc, r=1, g=2, b=3, stretch="lin")
dev.off()
# visualizziamo un'immagine molto simile a quella reale
# di solito le bande sono r=3, g=2, b=3, ma essendo già elaborata perchè è un'immagine landsat,
# si possono visualizzare anche come lo abbiamo impostato noi

# cambiamo lo stretch per avere una colorazione più differenziata
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
dev.off()

# classificazione non supervisionata (Unsupervised Classification)
# clustering di dati raster basato su k gruppi
gcclass2 <- unsuperClass(gc, nClasses=2)
gcclass2

# visualizziamo la mappa creata con due classi
plot(gcclass2$map)
dev.off()

# visualizziamo quella con quattro
gcclass4 <- unsuperClass(gc, nClasses=4)
plot(gcclass4$map)
