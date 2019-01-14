# To build image
`PS C:\docker-playgroud> docker build -t webapp .`
# Testing image, run as a single container
`PS C:\docker-playgroud> docker run --name webapp -d -p 4000:80 webapp`
# To access on browser
`http://localhost:4000/`
# To start swarm
`PS C:\docker-playgroud> docker swarm init --advertise-addr 192.168.8.16`
# To create a network
`PS C:\docker-playgroud> docker network create --driver overlay my-swarm-network`
# To run as a service, with 4 replicas
`docker service create --replicas 4 --name my-swarm-service --publish 4000:80 --network my-swarm-network webapp`
# To test load balance, you have go to outside of host machine
`PS C:\Users\joao.melo> powershell curl http://192.168.8.16:4000`