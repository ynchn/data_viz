import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
import numpy as np

# df_l = pd.read_csv('./data/trend_l.csv')
# df_g = pd.read_csv('./data/trend_g.csv')
# df_b = pd.read_csv('./data/trend_b.csv')
# df_t = pd.read_csv('./data/trend_t.csv')
# df_q = pd.read_csv('./data/trend_q.csv')
# df_i = pd.read_csv('./data/trend_i.csv')
# df_a = pd.read_csv('./data/trend_a.csv')
# df_h = pd.read_csv('./data/trend_homo.csv')


# # test = pd.DataFrame().join([df_l, df_g, df_b, df_t], how="outer")
# df = df_l.merge(df_g, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_b, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_t, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_q, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_i, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_a, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df = df.merge(df_h, how='outer', left_on=['YR','MO'], right_on=['YR','MO'])
# df.sort_values(by=['YR', 'MO'])

# df.to_csv('./data/merged_trend.csv', index=False)

df_merged = pd.read_csv('./data/merged_trend.csv')
# df_merged = df_merged.astype('Int64')
df_merged= df_merged.drop(['YR', 'MO'], axis=1)
df_merged = df_merged.set_index(pd.date_range(start='2006/01', end='2023/02', freq='M'))
df_merged.fillna(0, inplace=True)

# print(df_merged.to_string())

# fig, ax = plt.subplots()

width = 14
height = 8
ax = df_merged.plot.area(colormap="Pastel1", figsize=(width, height))

ax.set_title("Trends of Queer Books/Media Checked out from 2006 to 2023\n(stacked area chart)")
ax.set_ylabel("Total Number of Checkouts")

ax.set_xlabel('Year')

plt.show()
plt.close()

# dwy_col = df_dewey['deweyClass']

# fig, ax = plt.subplots()

# counts, edges, bars = plt.hist(dwy_col, bins=10, edgecolor = 'k', range = (0,1000))
# plt.bar_label(bars)

# plt.xticks(np.arange(0, 1000, step=100))
# plt.yticks(np.arange(0, 2000, step=100))



# plt.show()

df_merged = df_merged.divide(df_merged.sum(axis=1), axis=0)
ax = df_merged.plot(kind='area', stacked=True, colormap="Pastel1", figsize=(width, height))
ax.set_title("Trends of Queer Books/Media Checked out from 2006 to 2023\n(100% stacked area chart)")
ax.set_ylabel('Percent (%)')
ax.margins(0, 0) # Set margins to avoid "whitespace"

plt.show()
plt.close()