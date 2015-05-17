server {

	server_name journeymonitor.com www.journeymonitor.com;
	listen 0.0.0.0:80;
	access_log /var/log/nginx/journeymonitor.com.access.log;
	error_log /var/log/nginx/journeymonitor.com.error.log;
	charset utf-8;

	root /opt/selenior/control-web-frontend/web;
	index index.php;

	location ~ \.php$ {
		fastcgi_pass unix:/var/run/php5-fpm.sock;
		fastcgi_index app.php;
		include fastcgi_params;
	}

	location / {
		if (-f $request_filename) {
			expires max;
			break;
		}
		rewrite ^(.*) /app.php last;
	}

	# This still allows access from anywhere and I don't know why
	location /api {
		allow 127.0.0.1;
		allow 5.45.99.8;
		deny all;
		rewrite ^(.*) /app.php last;
	}

}