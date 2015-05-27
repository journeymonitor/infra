# managed by puppet

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

	location /api/internal {
		deny all;
	}

	location /testresult-screenshots {
		proxy_pass http://127.0.0.1:8083/;
	}

}

server {

	server_name control-api;
	listen 127.0.0.1:8082;
	access_log /var/log/nginx/journeymonitor-control-api.access.log;
	error_log /var/log/nginx/journeymonitor-control-api.error.log;
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

}

server {

	server_name monitor-api;
	listen 127.0.0.1:8081;
	access_log /var/log/nginx/journeymonitor-monitor-api.access.log;
	error_log /var/log/nginx/journeymonitor-monitor-api.error.log;
	charset utf-8;

	root /opt/selenior/monitor/web;
	index index.php;

	location ~ \.php$ {
		fastcgi_pass unix:/var/run/php5-fpm.sock;
		fastcgi_index index.php;
		include fastcgi_params;
		fastcgi_param PHP_ENV prod;
	}

	location / {
		if (-f $request_filename) {
			expires max;
			break;
		}
		rewrite ^(.*) /index.php last;
	}

}

server {

	server_name monitor-media;
	listen 127.0.0.1:8083;
	access_log /var/log/nginx/journeymonitor-monitor-media.access.log;
	error_log /var/log/nginx/journeymonitor-monitor-media.error.log;
	charset utf-8;

	root /var/tmp/selenior-screenshots;
	index index.html;

	location / {
		if (-f $request_filename) {
			expires max;
			break;
		}
	}

}
