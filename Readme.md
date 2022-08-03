# Golang-AWS-ECS

## Build artifact
```sh
$ go build
```

## Build Docker Image from Dockerfile
```sh
$ docker build -t golang-aws-ecs .
```

## Start With docker compose 
```sh
$ docker compose up -d --build
```

### Before Test API
After start with docker-compose. Go to http://localhost:9000 to login pgAdmin for create Table ***Items***
- ***username***: admin@mail.com
- ***password***: P@ssw0rd

Add connection to server with this credentials
- ***Host***: golang-database
- ***Username***: go-user
- ***Password***: go-password
- ***Database Name***: go-db

Then Run this SQL Script below
```SQL
CREATE TABLE IF NOT EXISTS items(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Test API
Use `curl`command for purpose test api

- Create Items 
```sh
curl --location --request POST 'http://localhost:8080/items' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Jack Denail",
    "description": "This is Author'\''s name"
}'
```

- Get Items
```sh
curl --location --request GET 'http://localhost:8080/items'
```

- Get Items By Id
```sh
curl --location --request GET 'http://localhost:8080/items/1'
```

- Update Items By Id
```sh
curl --location --request PUT 'http://localhost:8080/items/1' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Jack Dorsey",
    "description": "Twitter Founder name."
}'
```

- Delete Items By Id
```sh
curl --location --request DELETE 'http://localhost:8080/items/1'
```

### Document Reference
https://blog.logrocket.com/how-to-build-a-restful-api-with-docker-postgresql-and-go-chi/