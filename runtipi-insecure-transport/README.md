# Runtipi Insecure Transport

Some apps (like portainer) use only HTTPS for accessing their web UI. This is fine as long as you access the app through its exposed port. If you try to use traefik (at least with the default runtipi configuration), you will get a bad gateway error because traefik cannot trust the self-signed certificate of the app. This can be fixed by adding the following `extraLabels` in the `docker-compose.json` file:

```json
{
  "extraLabels": {
    "traefik.http.services.{{RUNTIPI_APP_ID}}.loadbalancer.server.scheme": "https",
    "traefik.http.services.{{RUNTIPI_APP_ID}}.loadbalancer.serverstransport": "insecuretransport@file"
  }
}
```

This will use runtipi's built-in insecure transport and will allow the app to be proxied. The same can be done with docker compose labels:

```yaml
labels:
  traefik.http.services.crafty.loadbalancer.server.scheme: https
  traefik.http.services.crafty.loadbalancer.serverstransport: insecuretransport@file
```
