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

Start the Server:

```
$ python server.py
```

Start Sending Messages:

```
$ python producer.py
[2018-02-18 17:46:35,696: INFO/MainProcess] celery@decb090fb38b ready.
[2018-02-18 17:46:35,707: INFO/MainProcess] Received task: tasks.add[82dd1196-1edd-4bdd-83c4-0e0d72dbe145]
[2018-02-18 17:46:35,714: INFO/MainProcess] Received task: tasks.add[a8fbe7b0-5b08-4000-8782-156c1ba10d7c]
[2018-02-18 17:46:35,721: INFO/MainProcess] Received task: tasks.add[6469bfb1-106e-4562-acf0-f033914a54a4]
[2018-02-18 17:46:35,729: INFO/MainProcess] Received task: tasks.add[14f99e5a-e160-420a-bb87-aaff0d8c41d9]
[2018-02-18 17:46:35,736: INFO/MainProcess] Received task: tasks.add[eb4cfbf0-106c-4fea-871a-45112d8fcc17]
[2018-02-18 17:46:35,880: INFO/ForkPoolWorker-4] Task tasks.add[6469bfb1-106e-4562-acf0-f033914a54a4] succeeded in 0.0345151410438s: 349938
[2018-02-18 17:46:35,902: INFO/ForkPoolWorker-4] Task tasks.add[eb4cfbf0-106c-4fea-871a-45112d8fcc17] succeeded in 0.0118801490171s: 922533
[2018-02-18 17:46:35,907: INFO/ForkPoolWorker-2] Task tasks.add[14f99e5a-e160-420a-bb87-aaff0d8c41d9] succeeded in 0.0462401340483s: 968934
[2018-02-18 17:46:35,919: INFO/ForkPoolWorker-1] Task tasks.add[a8fbe7b0-5b08-4000-8782-156c1ba10d7c] succeeded in 0.0733721340075s: 223970
[2018-02-18 17:46:35,920: INFO/ForkPoolWorker-3] Task tasks.add[82dd1196-1edd-4bdd-83c4-0e0d72dbe145] succeeded in 0.0593248090008s: 1855830
```
