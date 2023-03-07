import requests
from bs4 import BeautifulSoup
import json
import csv


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
    pattern_id = int(pattern_id_str[1:])

    # pattern URL
    pattern_url = curr_pattern['href']

    # preview img URL
    img_tag = pattern.find('img')
    img_url_list = [img_tag['src']]
    srcset_list = img_tag['srcset'].split(',')
    img_url_list.append(srcset_list[0][:-3])
    img_url_list.append(srcset_list[1][1:-3])
    
    # dimensions
    pattern_dim = pattern.find('div', {'class': 'dimensions_icon'}).find_next_sibling('span').text.strip()
    # print('dimensions:', pattern_dim)
    # cols: p_json['dimensions'][0]
    #       pairs of strings that are knotted in the 1st row in the pattern
    # cols == pattern_num_strs / 2 should always be true
    cols, rows = pattern_dim.split('x')
    dimensions = [int(cols), int(rows)]

    # strings
    pattern_num_strs = pattern.find('div', {'class': 'strings_icon'}).find_next_sibling('span').text.strip()
    pattern_num_strs = int(pattern_num_strs)

    # colors
    pattern_colors = pattern.find('div', {'class': 'colors_icon'}).find_next_sibling('span').text.strip()
    pattern_colors = int(pattern_colors)

    # contributor
    added_by_tag = pattern.find('span', {'class': 'added_by'})
    contributor_name = added_by_tag.find('a').text
    contributor_url = added_by_tag.find('a')['href']

    return [pattern_id, pattern_url, img_url_list, dimensions, pattern_num_strs, pattern_colors, contributor_name, contributor_url]
    

def scrapeCurrPage(soup, json_list, toJSON=True, toCSV=False):
    '''
    Given the soup of current url, scrape for pattern items.

    Param:
    soup: parsed HTML of current page/url

    Returns:
    None
    '''
    patterns = soup.find_all("div", class_="patterns_item")
    # find_all returns a list

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
        
        if toCSV:
            pattern_CSVRow = [currInfoList[0], currInfoList[1], currInfoList[2][0], currInfoList[2][1], currInfoList[2][2], currInfoList[3][0], currInfoList[3][1], currInfoList[4], currInfoList[5], currInfoList[6], currInfoList[7]]
            # open the file in append mode and append the data
            with open('patterns.csv', mode='a', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(pattern_CSVRow)

    # num photos, videos, loves, rating
    # user defined tags


#----------------------- MAIN FUNCTION ------------------------
if __name__ == "__main__":
    url_n = "https://www.braceletbook.com/patterns/?type=n"
    # result = requests.get(url_n).text
    # print(result)

    # -------------------------------------
    # if toJSON
    # continuous writing to JSON is not efficient
    json_list = []
    # -------------------------------------

    # -------------------------------------
    # if toCSV
    # continuous writing to CSV
    # csv_header = ['id', 'pattern_url', 'preview_url', 'preview_url2', 'preview_url3', 'cols', 'rows', 'num_strings', 'num_colors', 'contributor_name', 'contributor_url']
    # with open('patterns.csv', mode='a', newline='') as file:
    #     writer = csv.writer(file)
    #     writer.writerow(csv_header)
    # -------------------------------------

    i = 0
    while url_n:
        result = requests.get(url_n).text
        soup = BeautifulSoup(result, "html.parser")
        # print(soup.prettify())
        next_page = soup.find('a', {'class': 'next'})
        # scrape current page

        # -------------------------------------
        # if toJSON
        scrapeCurrPage(soup, json_list)
        # -------------------------------------

        # -------------------------------------
        # if toCSV
        # scrapeCurrPage(soup, json_list, toJSON=False, toCSV=True)
        # -------------------------------------

        i += 1
        print(i)
        # check if there is a next page
        if next_page:
            # update url_n with the link to the next page
            url_n = next_page["href"]
        else:
            # stop looping if there is no next page
            url_n = None
    
    # -------------------------------------
    # if toJSON
    # Write the list of patterns to a JSON file
    with open('patterns.json', 'w') as f:
        json.dump(json_list, f)
