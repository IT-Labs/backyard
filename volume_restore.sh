#! /bin/bash
# restore volume from docker
# remove previous postgres container and alumni-docker volume
# please note if the container or da volume does not exist error will apprear in the console, but this is expected

#db vloume
docker container stop api-postgres
docker container rm api-postgres
docker volume rm api-postgres 
docker volume create --name=api-postgres
root=$1
echo 'Root -> '$root
docker run --rm -v api-postgres:\/recover -v \/$root\/backup:\/backup postgres:12.2 bash -c "cd \/recover && tar xvf \/backup\/api_postgres_volume.tar"

