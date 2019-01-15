# Build image
`PS C:\docker-playground> docker build -t webapp .`
# Test image, run as a single container
`PS C:\docker-playground> docker run --name webapp -d -p 4000:80 webapp`
# Access on browser
`http://localhost:4000/`
# Start swarm (correct your IP)
`PS C:\docker-playground> docker swarm init --advertise-addr 192.168.1.2`
# Create a network
`PS C:\docker-playground> docker network create --driver overlay my-swarm-network`
# Run as a service, with 4 replicas
`docker service create --replicas 4 --name my-swarm-service --publish 4000:80 --network my-swarm-network webapp`
# Test load balance, you have go to outside of host machine
`PS C:> powershell curl http://192.168.1.2:4000`
or
`PS C:> powershell "(iwr http://192.168.8.16:4000/raw.aspx).Content"`


# Run Portainer:
```
netsh interface portproxy add v4tov4 listenaddress=10.0.75.1 listenport=2375 connectaddress=127.0.0.1 connectport=2375
netsh advfirewall firewall add rule name="docker management" dir=in action=allow protocol=TCP localport=2375
```
```
docker volume create portainer_data
docker run -d -p 9000:9000 -v portainer_data:/data portainer/portainer -H tcp://10.0.75.1:2375
```
or
```
docker run -d -p 9000:9000 --name portainer --restart always -v \\.\pipe\docker_engine:\\.\pipe\docker_engine -v portainer_data:C:\data portainer/portainer
```
[details here](https://lemariva.com/blog/2018/05/tutorial-portainer-for-local-docker-environments-on-windows-10)
and [here](https://www.portainer.io/installation/)
