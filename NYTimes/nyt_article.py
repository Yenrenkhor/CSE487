import scrapy
import requests
from bs4 import BeautifulSoup as bs

with open("nyt_data.txt", "rt") as f:
    urls = [url.strip() for url in f.readlines()]
    print(urls)

for url in range(len(urls)):
    r = requests.get(urls[url])
    soup = bs(r.text, 'html.parser')
    for items in soup.find_all('div', {'class': 'css-53u6y8'}):
        article = items.text
        print(article)
        with open('nyt_article.txt', 'a') as f:
            f.write(str(article))
