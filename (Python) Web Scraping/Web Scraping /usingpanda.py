import pandas as pd

# Read all tables on the page into the a list of DataFrames
tables = pd.read_html('https://en.wikipedia.org/wiki/List_of_highest-grossing_films')

# Select the first table 
df = tables[0]

# Save to Csv
df.to_csv('./extracted_data/highest_grossing_films_using_pandas.csv', index=False)

print("Saved to extracted folder")