## RabbitMQ on ARMHF

Source:
- https://github.com/docker-library/rabbitmq/tree/b5543df2789c16d8ea1c2119484378d4c23baa6c/3.7/alpine

Image:
- rbekker87/rabbitmq-armhf:3.7.3

On RabbitMQ:

```
$ rabbitmqctl add_user ruan pass123
$ rabbitmqctl add_vhost rabbittest
$ rabbitmqctl set_permissions -p rabbittest ruan ".*" ".*" ".*"
```

- `tasks.py`

```
from celery import Celery

app = Celery('tasks', backend='redis://redis:6379', broker='amqp://ruan:pass123@rabbitmq/rabbittest')

@app.task
def add(x, y):
    return x + y
```

- `worker.py`

```
from tasks import app
from tasks import add
app.start(argv=['celery', 'worker', '-l', 'info'])
```

- `producer.py`

```
import random
from tasks import add

while True:
    result = add.delay(random.randint(1,999999), random.randint(1,999999))
    if result.ready() == False:
        try:
            # state is not ready, trying to get, after 2 seconds
            # raise time out
            print(result.get(timeout=2))
        except Exception as e:
            print(e)
    else:
        # state is ready, getting result
	print(result.get())
```
