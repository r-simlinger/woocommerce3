# Start

```


docker run -d --rm -p 443:443 \
  --name nginx-proxy \
  -v /path/to/certs:/etc/nginx/certs:ro \
  -v /etc/nginx/vhost.d \
  -v /usr/share/nginx/html \
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy \
  jwilder/nginx-proxy


docker run -d --rm \
  --name letsencrypt \
  -v /path/to/certs:/etc/nginx/certs:rw \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --volumes-from nginx-proxy \
  jrcs/letsencrypt-nginx-proxy-companion


docker run -d -it --rm \
  --expose 443 \
  --name w3 \
  -e "LETSENCRYPT_HOST=woocommerce3.runtest.de" \
  -e "LETSENCRYPT_EMAIL=foo@simlinger.eu" \
  -e "VIRTUAL_PORT=443" \
  -e "SSL_POLICY=Mozilla-Modern" \
  sdafj123/woocommerce3
```

# URL

https://woocommerce3.runtest.de/
