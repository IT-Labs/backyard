#!/bin/sh
apps=(api api-gateway fe/app)
for app in "${apps[@]}"
do
    echo "----Start building  $app ----"
    cd "$app"
    ./build.sh
   cd ..	
done 
 