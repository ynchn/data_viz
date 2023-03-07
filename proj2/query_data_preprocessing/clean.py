import pandas as pd

df = pd.read_csv('query_cout_cin_tagged.csv')
# 67183 rows

'''
    1. Remove irrelevant books
'''
# print(df.title.unique())
# 'Dead men dont crochet'
# 'un friendship bracelet'

df = df[df.title != 'Dead men dont crochet']
df = df[df.title != 'un friendship bracelet']
# 66907 rows
# print(len(df))

'''
    No longer need this step after updated query
    2.1. Drop unnecessary columns
'''
# df = df.drop(['barcode','bibNumber','collcode','callNumber'], axis=1)

'''
    2.2 Drop duplicate cout rows
'''
# df.drop_duplicates(subset=['cout'], keep='first', inplace=True)
# df.drop_duplicates(subset=['cout'], keep='last', inplace=True)
# print(df.to_markdown())

'''
    3. Save cleaned df to CSV
'''
df.to_csv('cleaned_data.csv', encoding='utf-8', index=False)
# df.to_csv('data_nodup_first.csv', encoding='utf-8', index=False)
# df.to_csv('data_nodup_last.csv', encoding='utf-8', index=False)


'''
outliers
1970-01-01 00:00:00
1996-10-14 00:00:00
2000-05-13 00:00:00
2001-03-14 00:00:00
'''