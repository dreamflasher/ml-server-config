import json
import socket
import time
import urllib.error
import urllib.parse
import urllib.request

metadata_url = "http://169.254.169.254/metadata/scheduledevents?api-version=2019-01-01"
this_host = socket.gethostname()


def get_scheduled_events():
    req = urllib.request.Request(metadata_url)
    req.add_header('Metadata', 'true')
    resp = urllib.request.urlopen(req)
    data = json.loads(resp.read())
    return data


def handle_scheduled_events(data):
    for evt in data['Events']:
        status = evt['EventStatus']
        resources = evt['Resources']
        eventtype = evt['EventType']
        resourcetype = evt['ResourceType']
        notbefore = evt['NotBefore'].replace(" ", "_")
        if this_host in resources:
            print(("+ Scheduled Event. This host " + this_host +
                   " is scheduled for " + eventtype + " not before " + notbefore))
            # Add logic for handling events here


def main():
    while True:
        handle_scheduled_events(get_scheduled_events())
        time.sleep(10)


if __name__ == '__main__':
    main()
