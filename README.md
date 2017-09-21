Oracle XE 11g on CentOS 7
============================

[![](https://images.microbadger.com/badges/image/brunodias20/centos-oracle11g.svg)](https://microbadger.com/images/brunodias20/centos-oracle11g "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/brunodias20/centos-oracle11g.svg)](https://microbadger.com/images/brunodias20/centos-oracle11g "Get your own version badge on microbadger.com")

Oracle Express Edition 11g Release 2 on CentOS 7

_Based on wnameless/oracle-xe-11g/ docker image_ 

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/brunodias20/oracle-11g_debian/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation(with CentOS 7)
```
docker pull brunodias20/centos-oracle11g
```

Run with 1521 ports opened:
```
docker run -p 1521:1521 brunodias20/centos-oracle11g
```

Password for SYS & SYSTEM
```
oracle
```

Password for dbuser
```
us3rdb
```

Support custom DB Initialization, create db for example
```
# Dockerfile 
FROM brunodias20/centos-oracle11g

ADD create-db.sql /docker-entrypoint-initdb.d/
```

## How to contribute?

Check the issues section: [Issues](https://github.com/brunojdo/centos-oracle11g/issues)

Open new issues or make a PR! 

Enjoy!
