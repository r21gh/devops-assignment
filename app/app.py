import time
import os

import redis
from flask import Flask

from flask_basicauth import BasicAuth


app = Flask(__name__)
cache = redis.Redis(host=os.environ['REDIS_HOST'], port=os.environ['REDIS_PORT'])

app.config['BASIC_AUTH_USERNAME'] = os.environ['USERNAME']
app.config['BASIC_AUTH_PASSWORD'] = os.environ['PASSWORD']

basic_auth = BasicAuth(app)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)


@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello World! I have been seen {} times.\n'.format(count)

@app.route('/supersecret')
@basic_auth.required
def secret_view():
    count = get_hit_count()
    return os.environ['THEBIGSECRET']+ '\n'
