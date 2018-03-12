import os
from flask import Flask

flask_host = str(os.environ['flask_host'])
flask_port = int(os.environ['flask_port'])

app = Flask(__name__)

@app.route('/')
def index():
    return 'ok\n'

if __name__ == '__main__':
    app.run(host=flask_host, port=flask_port)
