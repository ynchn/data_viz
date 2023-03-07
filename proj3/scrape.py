import requests
from bs4 import BeautifulSoup

url_n = "https://www.braceletbook.com/patterns/?type=n"
result = requests.get(url_n).text
# print(result)

soup = BeautifulSoup(result, "html.parser")
# print(soup.prettify())

patterns = soup.find_all("div", class_="patterns_item")
# print(patterns)
# a list

for p in patterns:
    if pattern.find('div', {'class': 'ad_center_nomargin'}):
        continue  # Skip adslot div

    pattern_id = p.find('a', {'class': 'id'})
    # if pattern_id:
    pattern_id = pattern_id.text.strip()
    print(pattern_id)
    # else:
    #     # adslot - skip
    #     # print(p)
    #     continue



# # Find the pattern ID
# pattern_id = soup.find('a', {'class': 'id'}).text.strip()

# # Find the pattern dimensions
# pattern_dimensions = soup.find('span', {'class': 'caption padded'}, string='19x36').text.strip()

# # Find the number of strings
# num_strings = soup.find('span', {'class': 'caption padded'}, string='20').text.strip()

# # Find the number of colors
# num_colors = soup.find('span', {'class': 'caption'}, string='4').text.strip()

# # Find the number of photos
# num_photos = soup.find('span', {'class': 'caption padded'}, {'class': 'photos_icon'}).text.strip()

# # Find the number of videos
# num_videos = soup.find('span', {'class': 'caption padded'}, {'class': 'videos_icon'}).text.strip()

# # Find the number of loves
# num_loves = soup.find('span', {'