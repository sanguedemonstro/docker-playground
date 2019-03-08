# demonstration 01

## build image
```cd C:\Benner\docker\Wes\servercore2019```

```docker build -t bennersistemas/wes:saude .```

## run it!
```
docker run `
    --name wes-saude `
    -p 4000:80 `
    -e superserverhost=pegasus `
    -e superserversystemname=WES_DESENVOLVIMENTO `
    -e anonymoususername=sysdba `
    -e anonymouspassword=google `
    -e systeminstancename=WES_DESENVOLVIMENTO `
    -e loggingserveraddress=http://bnu-vtec012:9200 `
    -e sessionhost=bnu-vtec012 `
    bennersistemas/wes:saude
```

## check if it's ready
```docker container ls --all```

## test \o/
```http://localhost:4000```

## publish
```docker push bennersistemas/wes:saude```

## explorig docker hub
```https://hub.docker.com```

# demonstration 02

## download image (at all hosts)
```docker pull bennersistemas/wes:saude```

## create service
```
docker service create --replicas 4 `
    --name wes-saude `
    --publish 4000:80 `
    -e superServerHost=DTC-BSCLOUD1 `
    -e superServerSystemName=RESERVAS `
    -e anonymousUserName=joao.melo `
    -e anonymousPassword=benner `
    -e systemInstanceName=RESERVAS `
    -e loggingServerAddress=http://dtc-wesdocker.bennercloud.com.br:9200 `
    -e sessionHost=dtc-wesdocker `
    bennersistemas/wes:saude
```
