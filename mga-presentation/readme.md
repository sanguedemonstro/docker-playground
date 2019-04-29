# demonstration 01

## build image
```cd C:\Benner\docker\Wes\servercore2019```

```docker build -t bennersistemas/wes:show .```

## run it!
```
docker run `
    --name wes-show `
    -p 4000:80 `
    -e superserverhost=pegasus `
    -e superserversystemname=WES_DESENVOLVIMENTO `
    -e anonymoususername=aaa `
    -e anonymouspassword=bbb `
    -e systeminstancename=WES_DESENVOLVIMENTO `
    -e loggingserveraddress=http://bnu-aaabbb:9200 `
    -e sessionhost=bnu-vtec012 `
    bennersistemas/wes:show
```

## check if it's ready
```docker container ls --all```

## test \o/
```http://localhost:4000```

## publish
```docker push bennersistemas/wes:show```

## exploring docker hub
```https://hub.docker.com```

# demonstration 02

## download image (at all hosts)
```docker pull bennersistemas/wes:show```

## create service
```
docker service create --replicas 4 `
    --name wes-show `
    --publish 4000:80 `
    -e superServerHost=DTC-aaa `
    -e superServerSystemName=RESERVAS `
    -e anonymousUserName=aaa `
    -e anonymousPassword=bbb `
    -e systemInstanceName=RESERVAS `
    -e loggingServerAddress=http://dtc-aaabbb.bennercloud.com.br:9200 `
    -e sessionHost=dtc-aaabbb `
    bennersistemas/wes:show
```
