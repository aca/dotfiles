#!/usr/bin/env python3

# echo "hello world" | get_word.py --pos 8
# world

import re
import sys
import fire

pattern = re.compile('[\S]+')
line = sys.stdin.read()

def get_word(txt=line, pos=0):
    words = []
    endpos = -1
    while word := pattern.search(txt, endpos):
        endpos = word.end()
        words.append(word)

    for word in words:
        span =  word.span()
        if span[0] <= pos < span[1]:
            return txt[span[0]:span[1]]
    return ''

fire.Fire(get_word)
