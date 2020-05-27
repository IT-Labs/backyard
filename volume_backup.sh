#! /bin/bash
# backup volume from docker

mkdir -p -- backup
root=$1
echo 'Root -> '$root
docker run --rm --volumes-from api-postgres -v \/$root/backup:\/backup postgres:12.2 bash -c "cd \/var\/lib\/postgresql\/data && tar cvf \/backup\/api_postgres_volume.tar ."