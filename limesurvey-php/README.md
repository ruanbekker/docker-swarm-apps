## Limesurvey on Docker

Limesurvey Application on Docker

## Dependencies:

- Limesurvey Source
- Apache/PHP
- MySQL


## Usage:

Clone the repository:

```
$ git clone https://github.com/ruanbekker/docker-swarm-apps
$ cd docker-swarm-apps/limesurvey-php
```

Getting the Source:

```
$ wget --content-disposition -O limesurvey.tar.gz 'https://github.com/LimeSurvey/LimeSurvey/archive/3.2.1+180207.tar.gz'
```

Build the Image:

```
$ docker login
$ docker build -t youruser/limesurvey:3.2.1 .
$ docker push youruser/limesurvey:3.2.1
```

Deploy the stack:

```
$ docker stack deploy -c docker-compose.yml limesurvey
```
