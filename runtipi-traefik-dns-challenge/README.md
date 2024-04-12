## Runtipi Traefik DNS Challenge

Simply make the changes to the files I have here. Then start/restart tipi with the `--env-file` flag set to `.env.local`. Here is an exmaple:

```Bash
sudo ./runtipi-cli start --env-file ./.env.local
```

After that traefik should automatically generate certificates for the domains. Make sure you have a domain configured in settings though.
