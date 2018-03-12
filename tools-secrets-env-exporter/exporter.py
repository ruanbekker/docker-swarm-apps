import os
from glob import glob

for var in glob('/run/secrets/*'):
    k=var.split('/')[-1]
    v=open(var).read().rstrip('\n')
    os.environ[k] = v
    print("export {key}={value}".format(key=k,value=v))
