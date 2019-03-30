from nytimesarticle import articleAPI
import json
import requests

r = requests.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=Stock+Market&begin_date=20190301&end_date=20190323&api-key=WC1NjsQEi1IGxG4PY3hT8AqRCq6xCogy")
data = r.json()
# api = articleAPI("WC1NjsQEi1IGxG4PY3hT8AqRCq6xCogy")
# articles = api.search(q="Wall+Street", begin_date=20191001)
url = data["response"]["docs"]
print(len(url))


with open('nyt_data.txt', 'a') as f:

    for row in url:

        f.write("%s\n" % str(row["web_url"]))

json_file = json.dumps(url, indent=1)
print(json_file)