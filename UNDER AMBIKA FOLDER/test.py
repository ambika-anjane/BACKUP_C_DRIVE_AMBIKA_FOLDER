# Store input numbers
num1 = 12
num2 = 12

# Add two numbers
sum = float(num1) + float(num2)

# Display the sum
print('The sum of {0} and {1} is {2}'.format(num1, num2, sum))

def greet(name):
    """
    This function greets to
    the person passed in as
    a parameter
    """
    print("Hello, " + name + ". Good morning!")
greet('Ambika')

import sys
import requests
from bs4 import BeautifulSoup

BASE_URL = 'https://fakestoreapi.com'

response = requests.get(f"{BASE_URL}/products")
print(response.json())

def get_url_paths(url, ext='', params={}):
    response = requests.get(url, params=params)
    if response.ok:
        response_text = response.text
     #print(response_text)
    else:
        return response.raise_for_status()
    soup = BeautifulSoup(response_text, 'html.parser')
    parent = [node.get('href') for node in soup.find_all('a') if node.get('href').endswith(ext)]
    return parent

url = 'https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles/'
ext = 'gz'
result = get_url_paths(url, ext)
detailsList = []
for i in result:
    if 'location' in i:
      detailsList.append(i)
print(detailsList)

