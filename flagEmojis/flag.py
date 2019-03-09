#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""

@author: lp217
@author: quantixed

"""

"""
Converts flag emoji to ascii and back
https://github.com/cvzi/flag
Based on http://schinckel.net/2015/10/29/unicode-flags-in-python/

Unicode country code emoji flags for Python
~~~~~~~~~~~~~~~~

"""

__version__ = '1.0.0'
__author__ = 'cuzi'
__email__ = 'cuzi@openmail.cc'
__source__ = 'https://github.com/cvzi/flag'
__license__ = """
MIT License

Copyright (c) cuzi 2018

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

__all__ = ["flagize", "dflagize"]

import sys
import re
import csv

OFFSET = 127397 # = ord("🇦") - ord("A")

PY2 = sys.version_info.major is 2

def flagize(text):
    def flag(code):
        #if not code:
        #    return u""
        points = list(map(lambda x: ord(x) + OFFSET, code.upper()))

        if PY2:
            return ("\\U%08x\\U%08x" % tuple(points)).decode("unicode-escape")
        else:
            return chr(points[0]) + chr(points[1])

    def flag_repl(matchobj):
        return flag(matchobj.group(1))

    text = re.sub(":([a-zA-Z]{2}):", flag_repl, text)

    return text


with open('file.csv', 'r') as f:
  reader = csv.reader(f)
  countries = list(reader)

flag_list = ''

for c in countries :
    flag_list += (flagize(':'+c[0]+':'))

print(flag_list)
