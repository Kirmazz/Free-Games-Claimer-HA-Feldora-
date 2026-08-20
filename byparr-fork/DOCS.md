# Byparr (add-on Home Assistant)

Wrapper de l'image officielle [`ghcr.io/thephaseless/byparr`](https://github.com/ThePhaseless/Byparr),
un solveur Cloudflare / Turnstile exposant une API **compatible FlareSolverr**.
Remplaçant direct de FlareSolverr pour Prowlarr / Jackett, vStream (Kodi), etc.

## Utilisation

1. Installer et démarrer l'add-on.
2. L'API écoute sur le port **8191** de l'hôte HA.
3. Dans le client (vStream, Prowlarr…), renseigner l'URL FlareSolverr :
   `http://<ip-de-HA>:8191`
   - Endpoint compatible FlareSolverr : `POST /v1`
   - Documentation interactive : `http://<ip-de-HA>:8191/docs`

## Options

| Option           | Rôle                                                        |
| ---------------- | ----------------------------------------------------------- |
| `proxy_server`   | Proxy sortant `protocol://host:port` (optionnel)            |
| `proxy_username` | Identifiant proxy (optionnel)                               |
| `proxy_password` | Mot de passe proxy (optionnel)                              |
| `log_level`      | `debug` / `info` / `warning` / `error`                      |

Tous les champs sont optionnels : sans proxy, l'add-on fonctionne tel quel.

## Notes

- Byparr **ne garantit pas** le passage de tous les challenges : il augmente
  fortement les chances. Cloudflare peut exiger du trafic depuis ton IP
  publique réelle — en LAN, c'est bien ton cas.
- Architecture publiée : **amd64** uniquement (l'ARM upstream est expérimental).
