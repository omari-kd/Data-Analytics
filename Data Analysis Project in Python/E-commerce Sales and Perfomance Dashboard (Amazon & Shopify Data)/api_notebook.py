import requests
import pandas as pd

# Step 1:  Fetch live data from Fake Store API 
url = 'https://fakestoreapi.com/products'
response = requests.get(url)
data = response.json()

# Step 2: Convert JSON to DataFrame
df = pd.DataFrame(data)

# Step 3: Flatten nested fields(ratings)
df['rating_rate'] = df['rating'].apply(lambda x:x['rate'])
df['rating_count'] = df['rating'].apply(lambda x: x['count'])
df.drop(columns='rating', inplace=True)

# Step 4: Rename columns for clarity
df.rename(columns={
    'id':'Product_ID',
    'title':'Product_Title',
    'price': 'Price_USD',
    'category': 'Category',
    'rating_rate': 'Rating',
    'rating_count': 'Num_Reviews'
}, inplace=True)

# Step 5: Convert to local Currency (GHS) - assume 1 USD = 15 GHS
df['Price_GHS'] = df['Price_USD'] * 15

# Step 6: Save cleaned data
df.to_csv('./01_clean_data/live_fakestore_data.csv', index=False)

print('Live API data fetched, cleaned and saved as live_fakestore_data.csv')
print(df.head())
print(df.columns)
