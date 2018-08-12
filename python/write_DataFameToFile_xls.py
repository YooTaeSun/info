import pandas as pd
from collections import OrderedDict
'''
Write DataFrame To File
'''
# df = pd.read_excel("data/test.xls")


df = pd.DataFrame({
    'prdtCode': ['00001','00002'],
    'sellStoreCode': ['06','01'],
    'landCode': ['KR','CN'],
    'acnt': ['100','123'],
    'rds': ['02','04'],
    'desc': ['TEST 1','TEST 2']
})

print(df.head())

print("----------------------------------")

df.to_excel('data/text3.xls', sheet_name='Sheet1', index=False)