import requests
import argparse
import datetime
import calendar

parser = argparse.ArgumentParser()

parser.add_argument("-o", "--owner", help="owner of repository", type=str, default="alenaPy")
parser.add_argument("-r", "--repo", help="name of repository", type=str, default="devops_lab")
parser.add_argument("-p", "--pull", help="name of pull request", type=int, default=56)
parser.add_argument("-t", "--token", help="token for access", type=str,
                    default="c89387f103bf254d1d95371a6bdb35f00d73b246")
parser.add_argument("--version", help="version of program",
                    version="Version 1.0", action="version")
parser.add_argument("--all", help="Output all available parameters", action="store_true")
parser.add_argument("-l", "--labels", help="Output names of attached labels", action="store_true")
parser.add_argument("-c", "--comments", help="Output number of comments", action="store_true")
parser.add_argument("--open", help="Output open information about pull request",
                    action="store_true")
parser.add_argument("--close", help="Output close information about pull request",
                    action="store_true")

args = parser.parse_args()

owner = args.owner
repo = args.repo
pull = args.pull
token = args.token

url_request = "https://api.github.com/repos/" + owner + "/" + repo + "/pulls/" + str(pull)
headers = {'Authorization': 'token ' + token}

req = requests.get(url_request, headers=headers).json()
if not requests.get(url_request, headers=headers).headers["Status"] == '200 OK':
    print("Page is not found")
    quit()

date = req['created_at']
day = datetime.datetime.strptime(date, "%Y-%m-%dT%H:%M:%SZ")
substact = datetime.datetime.now() - day
author = req['user']['login']

if args.all or args.labels:
    if req['labels']:
        print("labels = ", dict(*req['labels'])['name'])
    else:
        print("labels = 0")
if args.all or args.comments:
    print("Number of comments created = ", req['comments'])

if args.all or args.open:
    print("Number of days opened = ", substact.days)
    print("Day of week opened = ", calendar.day_name[day.weekday()])
    print("Hour of day opened = ", day.time())
    print("Week opened = ", day.isocalendar()[1])
    print("User who opened = ", author)

if args.all or args.close:
    if req['closed_at']:
        date = req['closed_at']
        day = datetime.datetime.strptime(date, "%Y-%m-%dT%H:%M:%SZ")
        author = req['closed_by']['login']

        print("Day of week closed = ", calendar.day_name[day.weekday()])
        print("Hour of day closed = ", day.time())
        print("Week closed = ", day.isocalendar()[1])
        print("User who closed = ", author)
    else:
        print("Request is still open")
