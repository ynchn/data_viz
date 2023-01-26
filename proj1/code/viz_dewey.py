import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
import numpy as np

df_dewey = pd.read_csv('./data/title_dewey.csv')
dwy_col = df_dewey['deweyClass']

fig, ax = plt.subplots()

counts, edges, bars = plt.hist(dwy_col, bins=10, edgecolor = 'k', range = (0,1000))
plt.bar_label(bars)

plt.xticks(np.arange(0, 1000, step=100))
plt.yticks(np.arange(0, 2000, step=100))

ax.set_title("Queer Literature and Media Dewey Class Distribution")
ax.set_ylabel("Number of Books/Media")

ax.set_xlabel('Dewey Classes')

width = 14
height = 8
fig.set_size_inches(width, height)

plt.show()
plt.close()

# finer, more detailed class categories
fig, ax = plt.subplots()

counts, edges, bars = plt.hist(dwy_col, bins=100, edgecolor = 'k', range = (0,1000))
plt.bar_label(bars)

plt.xticks(np.arange(0, 1000, step=10))
ax.tick_params(axis='x', labelrotation=90)
plt.yticks(np.arange(0, 2000, step=100))

ax.set_title("Queer Literature and Media Dewey Class Distribution")
ax.set_ylabel("Number of Books/Media")

ax.set_xlabel('Dewey Classes')

width = 20
height = 8
fig.set_size_inches(width, height)

fig.tight_layout()
plt.show()
