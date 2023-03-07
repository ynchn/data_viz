import requests
from bs4 import BeautifulSoup
import json

## TODO: to JSON

## TODO: to CSV

def scrapSinglePatternItem(pattern):
    '''
    Given a single pattern_item div, extract pattern information

    Param:
    pattern: parsed HTML of current pattern_item div

    Returns:
    a list of 8 pattern information elements
        pattern_id (int)
        pattern_url (string)
        img_url_list (list of string), [preview_url, preview_urlx2, preview_urlx3]
        dimensions (list of int), [cols, rows]
        pattern_num_strs (int)
        pattern_colors (int)
        contributor_name (string)
        contributor_url (string)
    '''
    curr_pattern = pattern.find('a', {'class': 'id'})

    # pattern id
    pattern_id_str = curr_pattern.text.strip()
    # print('id:', int(pattern_id[1:]))
    pattern_id = int(pattern_id_str[1:])
    # p_json['id'] = int(pattern_id_str[1:])

    # pattern URL
    pattern_url = curr_pattern['href']
    # print('pattern url:', pattern_url)
    # p_json['pattern_url'] = pattern_url

    # preview img URL
    img_tag = pattern.find('img')
    img_url_list = [img_tag['src']]
    srcset = img_tag['srcset']
    img_url_list.extend(srcset.split(','))
    # print('preview urls:', img_url_list)
    # p_json['preview_url_list'] = img_url_list

    # dimensions
    pattern_dim = pattern.find('div', {'class': 'dimensions_icon'}).find_next_sibling('span').text.strip()
    # print('dimensions:', pattern_dim)
    # cols: p_json['dimensions'][0]
    #       pairs of strings that are knotted in the 1st row in the pattern
    # cols == pattern_num_strs / 2 should always be true
    cols, rows = pattern_dim.split('x')
    dimensions = [int(cols), int(rows)]
    # p_json['dimensions'] = pattern_dim.split('x')

    # strings
    pattern_num_strs = pattern.find('div', {'class': 'strings_icon'}).find_next_sibling('span').text.strip()
    # print('strings:', pattern_num_strs)
    pattern_num_strs = int(pattern_num_strs)
    # p_json['num_strings'] = pattern_num_strs

    # colors
    pattern_colors = pattern.find('div', {'class': 'colors_icon'}).find_next_sibling('span').text.strip()
    # print('colors:', pattern_colors)
    pattern_colors = int(pattern_colors)
    # p_json['num_colors'] = pattern_colors

    # contributor
    added_by_tag = pattern.find('span', {'class': 'added_by'})
    contributor_name = added_by_tag.find('a').text
    contributor_url = added_by_tag.find('a')['href']
    # print('contributor info:', contributor_name, contributor_url)
    # p_json['contributor_info'] = [contributor_name, contributor_url]

    # print()
    # all_patterns_json.append(p_json)
    return [pattern_id, pattern_url, img_url_list, dimensions, pattern_num_strs, pattern_colors, contributor_name, contributor_url]
    

def scrapeCurrPage(soup, json_list, toJSON=True, toCSV=False):
    '''
    Given the soup of current url, scrape for pattern items.

    Param:
    soup: parsed HTML of current page/url

    Returns:
    '''

    patterns = soup.find_all("div", class_="patterns_item")
    # returns a list

    for p in patterns:
        # skip adslot div
        if p.find('div', {'class': 'ad_center_nomargin'}):
            continue

        # scrape current pattern div p
        currInfoList = scrapSinglePatternItem(p)
        if toJSON:
            pattern_jsonOBJ = {}
            pattern_jsonOBJ['id'] = currInfoList[0]
            pattern_jsonOBJ['pattern_url'] = currInfoList[1]
            pattern_jsonOBJ['preview_url_list'] = currInfoList[2]
            pattern_jsonOBJ['dimensions'] = currInfoList[3]
            pattern_jsonOBJ['num_strings'] = currInfoList[4]
            pattern_jsonOBJ['num_colors'] = currInfoList[5]
            pattern_jsonOBJ['contributor_name'] = currInfoList[6]
            pattern_jsonOBJ['contributor_url'] = currInfoList[7]
            json_list.append(pattern_jsonOBJ)

    # num photos, videos, loves, rating


#----------------------- MAIN FUNCTION ------------------------
if __name__ == "__main__":
    url_n = "https://www.braceletbook.com/patterns/?type=n"
    # result = requests.get(url_n).text
    # print(result)

    json_list = []

    while url_n:
        result = requests.get(url_n).text
        soup = BeautifulSoup(result, "html.parser")
        # print(soup.prettify())
        next_page = soup.find('a', {'class': 'next'})
        # scrape current page
        scrapeCurrPage(soup, json_list)

        # check if there is a next page
        if next_page:
            # update url_n with the link to the next page
            url_n = next_page["href"]
        else:
            # stop looping if there is no next page
            url_n = None
    
    # Write the list of patterns to a JSON file
    with open('patterns.json', 'w') as f:
        json.dump(json_list, f)
