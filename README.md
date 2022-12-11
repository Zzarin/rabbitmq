# rabbitmq
Simple message broker based on RabbitMQ

### Start standalone app. This will include publisher, consumer and RabbitMQ
```
make create_network
make rabbit_run
docker exec -it rabbit-1 rabbitmqctl stop_app
docker exec -it rabbit-1 rabbitmqctl reset
docker exec -it rabbit-1 rabbitmqctl start_app
cd applications\publisher
make build_run_publisher
cd ..
cd consumer
make build_run_consumer
```

### Create RabbitMQ cluster
#### Manual cluster creation
```
make create_network
make rabbit_3_run
```

Cluster status
```
docker exec -it rabbit-1 rabbitmqctl cluster_status
```

Connect #2 instance to cluster:
```
docker exec -it rabbit-2 rabbitmqctl stop_app
docker exec -it rabbit-2 rabbitmqctl reset
docker exec -it rabbit-2 rabbitmqctl join_cluster rabbit@rabbit-1
docker exec -it rabbit-2 rabbitmqctl start_app
docker exec -it rabbit-2 rabbitmqctl cluster_status
```

Connect #3 instance to cluster:
```
docker exec -it rabbit-3 rabbitmqctl stop_app
docker exec -it rabbit-3 rabbitmqctl reset
docker exec -it rabbit-3 rabbitmqctl join_cluster rabbit@rabbit-1
docker exec -it rabbit-3 rabbitmqctl start_app
docker exec -it rabbit-3 rabbitmqctl cluster_status
```

#### Auto clustering
```
docker run -d --rm --net rabbits `
-v ${PWD}/config/rabbit-1/:/config/ `
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq `
-e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT `
--hostname rabbit-1 `
--name rabbit-1 `
-p 8080:15672 `
rabbitmq:3.8-management

docker run -d --rm --net rabbits `
-v ${PWD}/config/rabbit-2/:/config/ `
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq `
-e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT `
--hostname rabbit-2 `
--name rabbit-2 `
-p 8081:15672 `
rabbitmq:3.8-management

docker run -d --rm --net rabbits `
-v ${PWD}/config/rabbit-3/:/config/ `
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq `
-e RABBITMQ_ERLANG_COOKIE=DSHEVCXBBETJJVJWTOWT `
--hostname rabbit-3 `
--name rabbit-3 `
-p 8082:15672 `
rabbitmq:3.8-management
```
