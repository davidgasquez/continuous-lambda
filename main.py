import requests


def none():
    return None


def handler(event, context):
    r = requests.get('https://api.github.com/events')
    return r.json()
