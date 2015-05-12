server {

	listen 0.0.0.0:80;
	server_name journeymonitor.com www.journeymonitor.com;

	location / {
		proxy_pass http://127.0.0.1:5999;
	}

	location /api {
	    deny all;
	    return 404;
	}

}
