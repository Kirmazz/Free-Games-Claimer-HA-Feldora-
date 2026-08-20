#!/usr/bin/env bash
set -e

# HA écrit les options de l'add-on dans /data/options.json.
# On les convertit en variables d'environnement pour feldorn,
# puis on passe la main à son entrypoint d'origine (qui lance le panneau).
if [ -f /data/options.json ]; then
  while IFS= read -r kv; do
    [ -n "$kv" ] && export "$kv"
  done < <(python3 - <<'PY'
import json
try:
    data = json.load(open("/data/options.json"))
except Exception:
    data = {}
for key, value in data.items():
    if value in (None, "", [], {}):
        continue
    print(f"{key}={value}")
PY
)
fi

exec /usr/local/bin/docker-entrypoint.sh
