# Repo to regroup all other repos

## init the submodules after cloning this repo : 

`git submodule update --init --recursive`

But don't forget to work inside the submodules and not in the root of the repo.\
for that you'll need to `cd` into the submodule and `git checkout` in the branch you wan't to work in.

## Build 
*(Work only for Elouan for now, need settings otherwise)*\
Set your terminal in the root of the subrepo you want to build and run the following command :

First, switch to the right builder for multi architecure build :\
`docker buildx use multarchbuilder`

Then build the image :\
`docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t <image_name> . --push`

the images names:
- ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-api
- ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-front
- ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-owner *(Not ready yet)*
- ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-admin *(Not ready yet)*

And finally, reset the build env :\
`docker context use default` && `docker buildx user default`

## Deployement 

An exemple of docker-compose file to deploy the project : 

#### Panel mongo :
```yaml
mongo-express:
  image: mongo-express:latest
  restart: unless-stopped
  ports:
    - "<MONGO_EXP_PORT>:8081"
  links:
    - db # Link to the db service
  environment:
    - ME_CONFIG_MONGODB_URL=mongodb://<DB_USER>:<DB_PASS>@<DB_HOST>:27017
  networks:
    - <PROXY_NETWORK>
```
#### DB :
```yaml
db:
  image: mongo:jammy
  restart: unless-stopped
  container_name: db
  hostname: <DB_HOST>
  volumes:
    - mongodb-data:/data/db
  ports:
    - "<>:27017"
  environment:
    MONGO_INITDB_ROOT_USERNAME: <DB_USER>
    MONGO_INITDB_ROOT_PASSWORD: <DB_PASS>
  networks:
    - <PROXY_NETWORK>
```
#### Front :
```yaml
front:
  image: ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-front
  container_name: ramenadvisor_front
  restart: unless-stopped
  ports:
    - "<FRONT_PORT>:80"
  networks:
    - <PROXY_NETWORK>
```
#### API :
```yaml
api:
  image: ghcr.io/b3-angers-2324/ramenadvisor/ramenadvisor-api
  container_name: ramenadvisor_api
  restart: unless-stopped
  environment:
    - PORT= <API_INTERN_POINT>
    - HOST= <EXTERNAL_URL>
    - DB_CONN= <CONNECTION_URL>
    - DB_NAME= RAMEN
  ports:
    - "<API_PORT>:<API_INTERN_POINT>"
  networks:
    - <PROXY_NETWORK>
```

