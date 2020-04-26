# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START app]
import logging

# [START imports]
from flask import Flask, render_template, request, jsonify
# [END imports]
# 
from bs4 import BeautifulSoup
import urllib
import re 

# [START create_app]
app = Flask(__name__)
# [END create_app]
# 

def search(query):
    address = "http://www.bing.com/search?q=%s" % (urllib.parse.quote_plus(query)+ "&count=20")

    getRequest = urllib.request.Request(address, None, {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:54.0) Gecko/20100101 Firefox/54.0'})

    urlfile = urllib.request.urlopen(getRequest)
    htmlResult = urlfile.read(20000000)
    urlfile.close()

    soup = BeautifulSoup(htmlResult).find('div',id='b_content')

    [s.extract() for s in soup('span')]
    unwantedTags = ['cite']
    
    for tag in unwantedTags:
        for match in soup.findAll(tag):
            match.replaceWithChildren()

    results = soup.findAll('li')
    

    return results

def get_item_info(query):
    links = search(query)
    titles = []
    urls = []
    paragraphs = []
    for link in links :
        try:
            urls.append(str(link.find('h2').find('a')['href']).replace(" ", " "))
            titles.append(str(link.find('h2').text).replace(" ", " "))
        except:
            ""
        try:
            paragraphs.append(str(link.findAll('p')[0].text))
        except:
            paragraphs.append("")

    return titles, urls, paragraphs, links[0]

@app.route('/get_expiration', methods=['GET'])
def get_expiration_data():
    args = request.args
    item = args['item']
    result = {}
    results = search("how long does it take for a "+item+" to expire")
    ans = []
    for r in results:
        ans = parse_expiration_paragraph(str(r))
        if len(ans)>0:
            result['response'] = ans
            return result

    
    result['response'] = ans
    return result

def parse_expiration_paragraph(p):
    tmp = ""
    month = False
    if 'day' in p:
        print("Hello")
        tmp = p[(p.index('day')-15):(p.index('day'))]
    elif 'week' in p:
        tmp = "7"

    nums = re.findall('\d*\.?\d+',tmp)
            
    return nums

@app.route('/get_water', methods=['GET'])
def get_water_data():
    args = request.args
    item = args['item']
    titles, urls, paragraphs, b = get_item_info("how much do I need to water my "+item+" plant")
    i = 0
    result = {}
    for p in paragraphs:
        nums = parse_water_paragraph(p)
        if len(nums)==2:
            print(nums)
            result['response'] = nums
            return result
    result['response'] = [1,10]
    return result

def parse_water_paragraph(p):
    tmp = ""
    if 'inch' in p:
        tmp = p[(p.index('inch')-15):(p.index('inch'))]
    
    nums = re.findall('\d*\.?\d+',tmp)
    
    return nums

@app.route('/get_growth', methods=['GET'])
def get_growth_data():
    args = request.args
    item = args['item']
    result = {}
    results = search("how long does it take for a "+item+" to grow in days")
    ans = []
    for r in results:
        ans = parse_growth_paragraph(str(r))
        if len(ans)>0:
            result['response'] = ans
            return result

    
    result['response'] = ans
    return result

def parse_growth_paragraph(p):
    tmp = ""
    month = False
    if 'day' in p:
        tmp = p[(p.index('day')-15):(p.index('day'))]

    nums = re.findall('\d*\.?\d+',tmp)
            
    return nums

def shop(query):
    address = "http://www.bing.com/shop?q=%s" % (urllib.parse.quote_plus(query))
    getRequest = urllib.request.Request(address, None, {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:54.0) Gecko/20100101 Firefox/54.0'})

    urlfile = urllib.request.urlopen(getRequest)
    htmlResult = urlfile.read(20000000)
    urlfile.close()

    soup = BeautifulSoup(htmlResult)

    results = soup.findAll('li', class_='br-item')

    return results

@app.route('/get_shop_data', methods=['GET'])
def get_shop_data():
    args = request.args
    item = args['item']
    links = shop("Buy "+item+" seeds")
    shopdata = []
    for l in links:
        data = {}
        try:
            data['image']='https://www.bing.com/'+l.findAll('img')[0]['src']
            data['seller'] = l.findAll('span', class_='br-sellersCite')[0].text
            data['price'] = l.findAll('div', class_='pd-price br-standardPrice promoted')[0].text
            try:
                data['item'] = l.findAll('span')[-1]['title']
            except:
                data['item'] = item
            data['url'] = l.findAll('a', class_='br-adClickOut')[0]['href']

            shopdata.append(data)
        except:
            print('DIDNT WORK')
            break
    result = {}
    result['result'] = shopdata
    return result   



@app.errorhandler(500)
def server_error(e):
    # Log the error and stacktrace.
    logging.exception('An error occurred during a request.')
    return 'An internal error occurred.', 500

if __name__=="__main__":
    # For local development:
    #app.run(debug=True)
    # For public web serving:
    app.run(host='0.0.0.0', port=8080, debug=True)
# [END app]

