build:
	sbt dist

docker-build:
	docker build -t debug-openjdk-w-docker .
	docker image prune -f

docker-run:
	echo "Once it's running, you can press CTRL+C to stop it"
	docker run -it --publish-all --name debug-openjdk-w-docker --rm debug-openjdk-w-docker:latest

docker-curl:
	docker exec -it debug-openjdk-w-docker curl -Ikv https://localhost:9443

compose-build:
	docker-compose build
	docker image prune -f

compose-up:
	docker-compose up --remove-orphans
