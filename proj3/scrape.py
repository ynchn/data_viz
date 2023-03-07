import requests
from bs4 import BeautifulSoup
import json

def scrapSinglePatternItem(pattern, all_patterns_json):
    p_json = {}

    curr_pattern = pattern.find('a', {'class': 'id'})

    # pattern id
    pattern_id_str = curr_pattern.text.strip()
    # print('id:', int(pattern_id[1:]))
    p_json['id'] = int(pattern_id_str[1:])

    # pattern URL
    pattern_url = curr_pattern['href']
    # print('pattern url:', pattern_url)
    p_json['pattern_url'] = pattern_url

    # preview img URL
    img_tag = pattern.find('img')
    img_url_list = [img_tag['src']]
    srcset = img_tag['srcset']
    img_url_list.extend(srcset.split(','))
    # print('preview urls:', img_url_list)
    p_json['preview_url_list'] = img_url_list

    # dimensions
    pattern_dim = pattern.find('div', {'class': 'dimensions_icon'}).find_next_sibling('span').text.strip()
    # print('dimensions:', pattern_dim)
    # cols: p_json['dimensions'][0]
    #       pairs of strings that are knotted in the 1st row in the pattern
    # cols == pattern_num_strs / 2 should always be true
    # cols, rows = pattern_dim.split('x')
    p_json['dimensions'] = pattern_dim.split('x')

    # strings
    pattern_num_strs = pattern.find('div', {'class': 'strings_icon'}).find_next_sibling('span').text.strip()
    # print('strings:', pattern_num_strs)
    p_json['num_strings'] = pattern_num_strs

    # colors
    pattern_colors = pattern.find('div', {'class': 'colors_icon'}).find_next_sibling('span').text.strip()
    # print('colors:', pattern_colors)
    p_json['num_colors'] = pattern_num_strs

    # contributor
    added_by_tag = pattern.find('span', {'class': 'added_by'})
    contributor_url = added_by_tag.find('a')['href']
    contributor_name = added_by_tag.find('a').text
    # print('contributor info:', contributor_name, contributor_url)
    p_json['contributor_info'] = [contributor_name, contributor_url]

    # print()
    all_patterns_json.append(p_json)
    

def scrapeCurrPage(soup, all_patterns_json):
    '''
    Given the soup of current url, scrape for pattern items.

    Params:
    soup: parsed HTML by BeautifulSoup

    Returns:
    None
    '''
    patterns = soup.find_all("div", class_="patterns_item")
    # returns a list

    for p in patterns:
        # skip adslot div
        if p.find('div', {'class': 'ad_center_nomargin'}):
            continue

        # scrape current pattern div p
        scrapSinglePatternItem(p, all_patterns_json)
        


    # num photos, videos, loves, rating

#----------------------- MAIN FUNCTION ------------------------
if __name__ == "__main__":
    url_n = "https://www.braceletbook.com/patterns/?type=n"
    # result = requests.get(url_n).text
    # print(result)

    all_patterns_json = []

    i = 0
    while url_n:
        result = requests.get(url_n).text
        soup = BeautifulSoup(result, "html.parser")
        # print(soup.prettify())
        next_page = soup.find('a', {'class': 'next'})
        # scrape current page
        scrapeCurrPage(soup, all_patterns_json)
        i += 1
        # check if there is a next page
        if next_page:
            # update url_n with the link to the next page
            url_n = next_page["href"]
        else:
            # stop looping if there is no next page
            url_n = None
        
        if i == 2:
            break
    print(all_patterns_json)
