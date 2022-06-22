#!/bin/bash

set -exuo pipefail

if [ "$1" = "nginx" ]; then
    echo "NGINX started"

    cat >/etc/nginx/conf.d/default.conf <<EOF
server {
    listen  443 ssl;
    listen  [::]:443 ssl;

    server_name $DOMAIN_NAME;

    ssl_certificate     /etc/nginx/ssl/$CERT_CRT;
    ssl_certificate_key /etc/nginx/ssl/$CERT_KEY;
    ssl_protocols       TLSv1.2 TLSv1.3;

    root    /var/www/html;
    index   index.php;

    location / {
        autoindex   on;
        try_files   \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass            wordpress:9000;
        fastcgi_index           index.php;
        include                 fastcgi_params;
        fastcgi_param           SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param           PATH_INFO \$fastcgi_path_info;
    }
}
EOF

fi

exec "$@"
