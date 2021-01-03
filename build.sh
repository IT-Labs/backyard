#!/bin/sh
apps=(jmeter api-gateway api fe/app)
for app in "${apps[@]}"
do
    echo "----Start building  $app ----"
    cd "$app"
    ./build.sh
   cd ..	
done 
 