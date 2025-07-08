import requests

# Making a GET reuest 
r = requests.get('https://en.wikipedia.org/wiki/List_of_highest-grossing_films')

# Check status code for response recieved 
'''
success code - 200
not found  - 404
'''
print(r)

# print content of request
print(r.content)


