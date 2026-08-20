FROM ghcr.io/feldorn/free-games-claimer:2.11.9

# Persistance : le dossier data de l'app pointe vers /data (persistant + sauvegardé par HA)
RUN rm -rf /fgc/data && ln -s /data /fgc/data

# Injection des options de l'add-on HA comme variables d'environnement
COPY hass-init.sh /usr/local/bin/hass-init.sh
RUN chmod +x /usr/local/bin/hass-init.sh

# On enveloppe l'entrypoint : options -> env, puis entrypoint feldorn d'origine
# (qui lance lui-même le panneau et ignore le CMD, donc rien à re-déclarer).
ENTRYPOINT ["/usr/local/bin/hass-init.sh"]
