#! /bin/bash
# backup volume from docker

mkdir -p -- backup
docker run --rm --volumes-from api-postgres -v \/${PWD}\/backup:\/backup postgres:12.2 bash -c "cd \/var\/lib\/postgresql\/data && tar cvf \/backup\/api_postgres_volume.tar ."