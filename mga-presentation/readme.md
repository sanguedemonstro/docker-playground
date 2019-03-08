# demonstration 01

## build image
```cd C:\Benner\docker\Wes\servercore2019```

```docker build -t bennersistemas/wes:mga .```

## run it!
```
docker run `
    --name wes-mga `
    -p 4000:80 `
    -e superserverhost=pegasus `
    -e superserversystemname=WES_DESENVOLVIMENTO `
    -e anonymoususername=sysdba `
    -e anonymouspassword=google `
    -e systeminstancename=WES_DESENVOLVIMENTO `
    -e loggingserveraddress=http://bnu-vtec012:9200 `
    -e sessionhost=bnu-vtec012 `
    bennersistemas/wes:mga
```

## check if it's ready
```docker container ls --all```

## test \o/
```http://localhost:4000```

## publish
```docker push bennersistemas/wes:mga```

## explorig docker hub
```https://hub.docker.com```

# demonstration 02

## download image
```docker pull bennersistemas/wes:mga```
