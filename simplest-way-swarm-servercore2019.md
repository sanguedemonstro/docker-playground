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
`PS C:> powershell curl http://192.168.1.2:4000/raw.aspx`
