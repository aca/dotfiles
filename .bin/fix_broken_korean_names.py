#!/usr/bin/env -S python3 

import os
import sys
import argparse
import unicodedata
import re

parser = argparse.ArgumentParser(description='Change the encoding of file or directory name from UTF-8 to CP949.')
parser.add_argument('path', type=str, help='File or directory path to change the encoding of name.')
args = parser.parse_args()

INVALID_CHARS = '<>:"/\\|?*'
INVALID_CHARS_WIN = INVALID_CHARS + '. '
CONTROL_CHARS = ''.join(map(chr, list(range(0,32)) + list(range(127,160))))

def is_already_cp949(name):
    try:
        name.encode('cp949')
        return True
    except UnicodeEncodeError:
        return False

def change_encoding(root):
    for dirpath, dirnames, filenames in os.walk(root, topdown=False):
        for name in dirnames + filenames:
            if not is_already_cp949(name):
                old_path = os.path.join(dirpath, name)
                try:
                    basename, ext = os.path.splitext(name)  # separate extension from name
                    combined_name = unicodedata.normalize('NFC', basename)  # combine the characters
                    safe_name = re.sub(r'[{}]+'.format(re.escape(INVALID_CHARS_WIN + CONTROL_CHARS)), '', combined_name)
                    safe_name = safe_name.rstrip('.')  # Remove trailing dots
                    if safe_name:  # Check if name is not empty
                        safe_name += ext  # add the extension back
                        new_path = os.path.join(dirpath, safe_name.encode('cp949').decode('cp949'))
                        os.rename(old_path, new_path)
                        print(old_path, "=>", new_path)
                except Exception as e:
                    print(f"Error while converting name {name}")
                    print(type(e), str(e))

if __name__ == "__main__":
    change_encoding(args.path)
