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
