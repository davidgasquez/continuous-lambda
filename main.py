import requests


def handler(event, context):
    r = requests.get('https://api.github.com/events')
    return r.json()
