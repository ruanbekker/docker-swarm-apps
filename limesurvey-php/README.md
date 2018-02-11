## Limesurvey on Docker

Limesurvey Application on Docker

## Dependencies:

- Limesurvey Source
- Apache/PHP
- MySQL


## Usage:

Clone the repository:

```
$ git clone {}
$ cd {}
```

Getting the Source:

```
$ wget --content-disposition -O limesurvey.tar.gz 'https://github.com/LimeSurvey/LimeSurvey/archive/3.2.1+180207.tar.gz'
```

Deploy the stack:

```
$ docker stack deploy -c docker-compose.yml limesurvey
```
