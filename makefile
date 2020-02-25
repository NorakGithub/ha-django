dev-backend:
	docker-compose up -d postgres
	bash postgres-is-ready.sh
	docker-compose up -d django
	docker-compose logs -f

initial:
	rm -rf .docker_volumes/nginx
	mkdir -p .docker_volumes/nginx
	cp nginx/nginx.green.conf .docker_volumes/nginx/nginx.default.conf
	docker-compose up -d postgres
	sleep 20
	docker-compose up -d django-green
	docker-compose scale django-green=3
	sleep 5
	docker-compose up -d nginx
	docker-compose logs -f django-green django-blue
	
build-django:
	docker build ./django -t ha-django:$(NEW_TAG)

deploy:
	docker-compose up -d django-blue
	docker-compose scale django-blue=3
	sleep 5
	cp nginx/nginx.blue.conf .docker_volumes/nginx/nginx.default.conf
	docker-compose exec nginx nginx -s reload
	docker-compose scale django-green=0
	docker-compose up -d django-green
	docker-compose scale django-green=3
	sleep 5
	cp nginx/nginx.green.conf .docker_volumes/nginx/nginx.default.conf
	docker-compose exec nginx nginx -s reload
	docker-compose scale django-blue=0

down:
	rm -rf .docker_volumes/nginx
	docker-compose down


test-status:
	for ((i=1;i<=100000;i++)); do   curl "http://localhost/status/"; sleep 0.01; done
