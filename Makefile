create_network:
	docker network create rabbits

rabbit_run:
	docker run -d --rm --net rabbits -p 8080:15672 -e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT --hostname rabbit-1 --name rabbit-1 rabbitmq:3.8-management
	docker exec -it rabbit-1 rabbitmq-plugins enable rabbitmq_management

rabbit_3_instances_run:
	docker run -d --rm --net rabbits -p 8080:15672 -e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT --hostname rabbit-1 --name rabbit-1 rabbitmq:3.8-management
	docker run -d --rm --net rabbits -p 8081:15672 -e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT --hostname rabbit-2 --name rabbit-2 rabbitmq:3.8-management
	docker run -d --rm --net rabbits -p 8082:15672 -e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT --hostname rabbit-3 --name rabbit-3 rabbitmq:3.8-management

clean_up:
	docker rm -f rabbit-1

run_publisher:
	cd applications\publisher
	docker run -it --rm --net rabbits -e RABBIT_HOST=rabbit-1 -e RABBIT_PORT=5672 -e RABBIT_USERNAME=guest -e RABBIT_PASSWORD=guest -p 80:80 rabbit/rabbitmq-publisher:v1.0.0

_run_consumer:
	cd applications\consumer
	docker run -it --rm --net rabbits -e RABBIT_HOST=rabbit-1 -e RABBIT_PORT=5672 -e RABBIT_USERNAME=guest -e RABBIT_PASSWORD=guest rabbit/rabbitmq-consumer:v1.0.0