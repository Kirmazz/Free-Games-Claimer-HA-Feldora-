FROM ghcr.io/feldorn/free-games-claimer:2.11.9

# Persistance : le dossier data de l'app pointe vers /data
# (/data = stockage add-on persistant + inclus dans les sauvegardes HA).
# Vérifié : l'image amont ne déclare aucun VOLUME, donc le lien est sûr.
RUN rm -rf /fgc/data && ln -s /data /fgc/data

# On n'écrase NI ENTRYPOINT NI CMD : c'est le panel feldorn qui gère le scheduler.
