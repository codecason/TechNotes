from pymongo import MongoClient
from datetime import datetime

# Connect to the MongoDB instance
client = MongoClient('mongodb://localhost:27017/')

# Select the sales database and the sales collection
db = client['sales']
sales = db['sales']

# Define the pipeline for the aggregation query
pipeline = [
    # Match documents that meet certain criteria
    {
        '$match': {
            'saleDate': {
                '$gte': datetime(2022, 1, 1),
                '$lte': datetime(2022, 12, 31, 23, 59, 59, 999000)
            }
        }
    },

    # Group documents by the customer and calculate the total sales amount
    {
        '$group': {
            '_id': '$customer',
            'totalSales': { '$sum': '$amount' }
        }
    },

    # Sort the documents by the total sales amount in descending order
    {
        '$sort': {
            'totalSales': -1
        }
    },

    # Limit the output to the top 10 documents
    {
        '$limit': 10
    }
]

# Execute the aggregation query
result = sales.aggregate(pipeline)

# Print the output documents
for doc in result:
    print(doc)
