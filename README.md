# A Dockerized Factom Sandbox

[Factom](https://github.com/FactomProject) is a general purpose data layer for the blockchain.

## Prerequisites

It's assumed that you are familiar with [Docker](https://www.docker.com/) and have it installed. Dive into the [Docker Docs](https://docs.docker.com/) if not.

## Quick start

Run a sandbox container in background:
```
docker run -d --name factom-sandbox 31z4/factom-sandbox
```
Execute `factom-cli` in the running container:
```
docker exec -it factom-sandbox factom-cli properties
```

## Expose ports

This container exposes the following TCP ports: *8088, 8089* and *8090*. You can bind them to your host machine:
```
docker run -d -p 8088:8088 -p 8089:8089 -p 8090:8090 31z4/factom-sandbox
```

## Retrieve logs

Because [Supervisor](http://supervisord.org/) is used to run both `factomd` and `fctwalled` inside one container, `docker logs` will retrieve logs from `supervisord`. Follow `factomd` logs by running:
```
docker exec -it factom-sandbox tail -f /root/.factom/factom-d.log
```
Same for `fctwallet`:
```
docker exec -it factom-sandbox tail -f /root/.factom/fctwallet.log
```

## Data persistence

It's recommended to mount a data volume at `/root/.factom` to persist Factom's data:
```
docker run -d -v /root/.factom --name factom-sandbox 31z4/factom-sandbox
```

## Factom configuration

According to [these recommendations](https://github.com/FactomProject/FactomDocs/blob/master/developerSandboxSetup.md#configure-factomd-for-sandbox-use) several changes to `factomd.conf` were made:
* `NodeMode` is set to `SERVER`
* `ExchangeRate` is `00000100`
* `fctwallet` listens on `0.0.0.0`
