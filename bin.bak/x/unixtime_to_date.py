#!/usr/bin/env python3

from datetime import datetime
import sys

print(datetime.fromtimestamp(int(sys.argv[1])/ 1000))
