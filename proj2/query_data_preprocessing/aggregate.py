import pandas as pd

df = pd.read_csv('data_nodup_last.csv')

df = df.drop(['itemNumber','title','deweyClass','time_outside_lib','artform'], axis=1)

df['cout'] = pd.to_datetime(df['cout'])
df['cin'] = pd.to_datetime(df['cin'])

df['cout'] = df['cout'].dt.date
df['cin'] = df['cin'].dt.date
# print(df.to_markdown())

df_cout = df[['cout']].copy()
df_cout['count'] = df_cout.groupby('cout')['cout'].transform('count')
df_cout = df_cout.groupby('cout')['count'].sum().reset_index()

df_cout.sort_values(['cout'], inplace=True)

# df_cin = df[['cin']].copy()
# print(df_cout.to_markdown())
# print(df_cin.to_markdown())
top_10_counts = df_cout.nlargest(10, 'count')
print(top_10_counts)

# df_cout.to_csv('aggregated_cout.csv', encoding='utf-8', index=False)


df_cin = df[['cin']].copy()
df_cin['count'] = df_cin.groupby('cin')['cin'].transform('count')
df_cin = df_cin.groupby('cin')['count'].sum().reset_index()
df_cin.sort_values(['cin'], inplace=True)

top_10_counts = df_cin.nlargest(10, 'count')
print(top_10_counts)

# df_cin.to_csv('aggregated_cin.csv', encoding='utf-8', index=False)
