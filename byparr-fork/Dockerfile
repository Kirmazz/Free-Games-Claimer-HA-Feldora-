# Valeur par défaut si build hors HA ; en add-on, HA fournit BUILD_FROM
# depuis build.yaml.
ARG BUILD_FROM=ghcr.io/thephaseless/byparr:3.0.4
FROM ${BUILD_FROM}

# L'image upstream tourne en USER 1000 : on repasse root le temps d'installer
# le wrapper, puis on rend la main à l'utilisateur d'origine.
USER root
COPY hass-init.sh /usr/local/bin/hass-init.sh
RUN chmod +x /usr/local/bin/hass-init.sh
USER 1000

# Remplace l'entrypoint upstream par notre wrapper, qui réinjecte ensuite
# la commande d'origine (voir hass-init.sh).
ENTRYPOINT ["/usr/local/bin/hass-init.sh"]
