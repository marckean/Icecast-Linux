# Icecast-Linux

## Container Build and Push to Container Registry

f
```
docker build -t icecast-linux:latest .

docker tag icecast-linux marcregistry.azurecr.io/icecast-linux:latest


docker network create --name music_stack
docker run -d -p 8000:8000 marcregistry.azurecr.io/icecast-linuxd --net music_stack
docker exec -it 68 vi

docker push marcregistry.azurecr.io/icecast-linux:latest

## Container Build


az group create --name 'Icecast-Linux' --location australiaeast

az container create --resource-group 'Icecast-Linux' --name icecastlinux --registry-username marcregistry --image marcregistry.azurecr.io/icecast-linux:latest --registry-password Qd3LUE743AT78tiekt0=Hfwzo3oneTPv --restart-policy OnFailure --ip-address Public --cpu 1 --memory 1 --ports 8000 --location southeastasia --verbose

az container show --resource-group 'icecast-Linux' --name icecastlinux


docker logs 56

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```
