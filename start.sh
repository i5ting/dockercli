#! /bin/bash

name=$(node -e "console.log(process.env.npm_package_name)")
version=$(node -e "console.log(process.env.npm_package_version)")

echo $name
echo $version

fullname=$name":"$version

docker ps -a |grep $fullname | awk '{print $1}' | xargs docker stop
docker ps -a |grep $fullname | awk '{print $1}' | xargs docker rm

docker build . -t $fullname

docker run -p 8888:3000 --name $name $fullname