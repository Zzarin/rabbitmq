build_run_consumer:
	docker build . -t rabbit/rabbitmq-consumer:v1.0.0
	docker run -it --rm --net rabbits -e RABBIT_HOST=rabbit-1 -e RABBIT_PORT=5672 -e RABBIT_USERNAME=guest -e RABBIT_PASSWORD=guest rabbit/rabbitmq-consumer:v1.0.0