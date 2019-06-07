# proxi
##   Clone and up, for localhost (no config needed):
```bash
git clone https://github.com/dcomposed/proxi.git && cd proxi
docker-compose up -d
```

running `docker-compose ps` will show three containers:
 * [traefik](https://github.com/containous/traefik) - Edge Router / modern HTTP reverse proxy 
 * [portainer](https://github.com/portainer/portainer-compose) - docker container management interface
 * [watchtower](https://hub.docker.com/r/v2tec/watchtower/) - to automatically upgrade Portainer ([?and traefik?](https://github.com/dcomposed/proxi/issues/1))

Without changing the config files you can go to:
 * http://traefik.localhost  (default user/pass is admin/12345)
 * http://portainer.localhost (create your own user account on first visit)
--note: lets encrypt will not work on localhost so you will need to "proceed anyway" past your browsers https warnings

##    Config (minimal config needed to use your domain and Lets Encrypt)

If you want to customize the configs (and not commit your likely private changes back to any repo), you can first run:
`./scripts/ignore.sh` to avoid changes showing up in git status.

### Required Config for Lets Encrypt
 * Adapt traefik.toml with your [domain](https://github.com/dcomposed/proxi/blob/master/traefik.toml#L36) and [email](https://github.com/dcomposed/proxi/blob/master/traefik.toml#L28)
 * Adapt .env 
    * with your [BASE_HOSTNAME](https://github.com/dcomposed/proxi/blob/master/.env#L5) (traefik and portainer will be prepended by default)
    * with a different [user/pass](https://github.com/dcomposed/proxi/blob/master/.env#L16) for auth 
       * (to generate, use `./scripts/makepw.sh yourusername yoursecurepasswd`)
 * Adapt docker-compose.yml 
    * adapt the [network name](https://github.com/dcomposed/proxi/blob/master/docker-compose.yml#L5) if you want/need an alternative name
    * adapt the subdomain hostname of the containers ([traefik](https://github.com/dcomposed/proxi/blob/master/docker-compose.yml#L18) and [portainer](https://github.com/dcomposed/proxi/blob/master/docker-compose.yml#L34) by default):
      * traefik.frontend.rule=Host:YOURCHOSENHOST.${BASE_HOSTNAME:-localhost}


### Inside of other docker-compose files, you can reference the proxi like this:
networks:
  haven:
    external:
      name: haven
service:
  networks:
    - haven
  labels:
    - traefik.enable=true
    - traefik.frontend.rule=Host:www.example.com  #,more.comma.sep
    - traefik.port=80 # port exposed by container
    - traefik.docker.network=haven # docker network name
