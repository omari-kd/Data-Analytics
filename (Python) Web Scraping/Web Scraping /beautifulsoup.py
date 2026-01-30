import requests
from bs4 import BeautifulSoup
import csv

# Making a Get request
r = requests.get('https://en.wikipedia.org/wiki/List_of_highest-grossing_films')

# Check the status code 
print(f"Status Code: {r.status_code}")

# Parsing the HTML 
soup = BeautifulSoup(r.content, 'html.parser')
# print(soup.prettify())

# Find the first table with class wikitable
table = soup.find('table', class_='wikitable')

# Print the table to confirm it was found
print(table.prettify() if table else "No table found")

# Extract headers 
headers = [th.text.strip() for th in table.find_all('th')]
print("Headers:", headers)

# Extract rows 
rows = []
for tr in table.find_all('tr')[1:]:  # Skip header row 
    cells = tr.find_all(['td', 'th']) # Some rows might still use 'th'
    row = [cell.text.strip() for cell in cells]
    rows.append(row)

# Print the first rows 
for row in rows[:5]: 
    print(row) 

# Save to CSV
with open('./extracted_data/highest_grossing_films.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(headers)
    writer.writerows(rows)

print("Saved to 'highest_grossing_films.csv'")


# FOR THE THIRD TABLE

# Step 1: Fetch the page
url = 'https://en.wikipedia.org/wiki/List_of_highest-grossing_films'
r = requests.get(url)
soup = BeautifulSoup(r.content, 'html.parser')

# Step 2: Get all tables
tables = soup.find_all('table', class_='wikitable')

# Safety check: Make sure there are at least 3 tables
if len(tables) >= 3:
    table = tables[2]  # 3rd table (index 2)

    # Step 3: Extract headers
    headers = [th.text.strip() for th in table.find_all('th')]

    # Step 4: Extract rows
    rows = []
    for tr in table.find_all('tr')[1:]:
        cells = tr.find_all(['td', 'th'])
        row = [cell.text.strip() for cell in cells]
        rows.append(row)

    # Step 5: Save to CSV
    with open('third_table.csv', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(headers)
       