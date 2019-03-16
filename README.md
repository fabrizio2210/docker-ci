# docker-ci
It is a webserver on 5000 port that help to  do some development automation.
It exposes the location 'manifest' that updates the _latest_ tag pushing a updated manifest.

## manifest
It needs the docker login passed as environment variable. It is a base64 string of user:password.
You can find it in your $HOME/.docker/config.json

```
docker run fabrizio2210/docker-ci -e DOCKER_LOGIN='dXNlcjpwYXNzd29yZA=='
```

You have to configure webhhok in for the repository target.
