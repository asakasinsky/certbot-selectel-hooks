# certbot-selectel-hooks
Certbot pre and post validation hooks for Selectel (manual mode). 

Inspired by [official example](https://certbot.eff.org/docs/using.html#pre-and-post-validation-hooks)

### IMPORTANT
From [oficial manual](https://certbot.eff.org/docs/using.htm):

><code>--dry-run</code> option for test "renew" or "certonly" without saving any certificates to disk. You can try it with `--dry-run` first

><code>--post-hook</code> option can be used to deploy renewed certificates, or to restart any servers that were stopped by --pre-hook. Not necessary.


### Get a Certificate Manually 
```sh
certbot certonly \
    -d [DOMAIN] \
    --dry-run \
    --manual \
    --manual-public-ip-logging-ok \
    --preferred-challenges=dns \
    --manual-auth-hook /PATH/TO/certbot-selectel-hooks/authenticator.sh \
    --manual-cleanup-hook /PATH/TO/certbot-selectel-hooks/cleanup.sh \
    --post-hook /PATH/TO/post-hook.sh
```

### Renew 
If the certificate was issued earlier, but error «The manual plugin is not working;» was raised on renewal, run next command:
```sh
certbot -q renew \
    --dry-run \
    --manual \
    --preferred-challenges=dns \
    --manual-auth-hook /PATH/TO/certbot-selectel-hooks/authenticator.sh \
    --manual-cleanup-hook /PATH/TO/certbot-selectel-hooks/cleanup.sh \
    --post-hook /PATH/TO/post-hook.sh
```
