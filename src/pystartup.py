# Add auto-completion and a stored history file of commands to your Python
# interactive interpreter. Requires Python 2.0+, readline. Autocomplete is
# bound to the Esc key by default (you can change it - see readline docs).
#
# Store the file in ~/.pystartup, and set an environment variable to point
# to it:  "export PYTHONSTARTUP=~/.pystartup" in bash.

import atexit
import os
import readline
import rlcompleter
import pdb
from importlib import reload

try:
    from lxml import etree
    import requests
except ImportError:
    pass

from pprint import pprint as pp

try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO


readline.parse_and_bind("tab: complete")

historyPath = os.path.expanduser("~/.pyhistory")


def save_history(historyPath=historyPath):
    readline.write_history_file(historyPath)


if os.path.exists(historyPath):
    readline.read_history_file(historyPath)


atexit.register(save_history)
os.system("clear")


del os, atexit, rlcompleter, save_history, historyPath


def write_file(file_path, content):
    f = open(file_path, 'w+')
    f.write(content)
    f.close()


def get_response(*args, **kwargs):
    try:
        res = requests.get(*args, **kwargs)
        return res
    except Exception as e:
        import pdb
        pdb.set_trace()
        raise e


def get_html_str(*args, **kwargs):
    return get_response(*args, **kwargs).text


def get_dom_from_text(text):
    return etree.parse(StringIO(text), etree.HTMLParser())


def get_dom(*args, **kwargs):
    html_str = get_html_str(*args, **kwargs)
    return get_dom_from_text(html_str)


def _r():
    reload()


'''
def get_redirect_and_html_str(url, *args, **kwargs):
    response = get_response(url, *args, **kwargs)
    return response.url, response.text


def get_html_str_and_dom(url, *args, **kwargs):
    html_str = get_html_str(url, *args, **kwargs)
    return html_str, get_dom_from_text(html_str)


def get_redirect_html_str_and_dom(url, *args, **kwargs):
    response = get_response(url, *args, **kwargs)
    html_str = response.text
    return response.url, html_str, get_dom_from_text(html_str)
'''
