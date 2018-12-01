import sys
import requests
from lxml import etree

def main(url):
    res = requests.get(url)
    parser = etree.HTMLParser()
    root = etree.fromstring(res.content, parser)
    import pdb
    pdb.set_trace()

if __name__ == '__main__':
    main(sys.argv[1])
