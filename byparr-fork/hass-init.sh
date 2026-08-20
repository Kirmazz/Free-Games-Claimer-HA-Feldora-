#!/usr/bin/env sh
# Convertit les options de l'add-on (/data/options.json) en variables
# d'environnement lues par Byparr, puis lance l'app comme le fait l'image
# upstream. Pas de bashio ici (image Ubuntu/uv, pas la base HA) : on parse
# le JSON avec le Python du venv, garanti présent.
set -e

OPTIONS="/data/options.json"
PY="/app/.venv/bin/python"

# Lit une clé de options.json (chaîne vide si absente/null/pas de fichier).
opt() {
  [ -f "$OPTIONS" ] || return 0
  "$PY" -c "import json,sys
d=json.load(open('$OPTIONS'))
v=d.get('$1')
print('' if v is None else v)" 2>/dev/null || true
}

PROXY_SERVER_VALUE="$(opt proxy_server)"
PROXY_USERNAME_VALUE="$(opt proxy_username)"
PROXY_PASSWORD_VALUE="$(opt proxy_password)"
LOG_LEVEL_VALUE="$(opt log_level)"

# On n'exporte que ce qui est renseigné, pour laisser les défauts de Byparr
# si les champs sont vides.
[ -n "$PROXY_SERVER_VALUE" ]   && export PROXY_SERVER="$PROXY_SERVER_VALUE"
[ -n "$PROXY_USERNAME_VALUE" ] && export PROXY_USERNAME="$PROXY_USERNAME_VALUE"
[ -n "$PROXY_PASSWORD_VALUE" ] && export PROXY_PASSWORD="$PROXY_PASSWORD_VALUE"
[ -n "$LOG_LEVEL_VALUE" ]      && export LOG_LEVEL="$LOG_LEVEL_VALUE"

# Valeurs sûres pour un usage en add-on (écoute sur toutes les interfaces,
# port fixe mappé dans config.yaml).
export HOST="0.0.0.0"
export PORT="8191"

cd /app
# Réplique l'ENTRYPOINT upstream : tini -- python main.py
exec tini -- "$PY" main.py
