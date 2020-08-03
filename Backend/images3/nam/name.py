
import os
import re

try:
    for filename in os.listdir("."):
            p = re.compile(r'(p.\d.)')
            ms = re.findall(r'(\d.)', filename)
            filename2 = p.sub('', filename)
            if filename.endswith("jpeg"):
                number = ms.pop()
                print(number  + '. ' + filename2)
                print(filename2)
                os.rename(filename,  number + '. ' + filename2)
except:
    print("File might be dublicate")  