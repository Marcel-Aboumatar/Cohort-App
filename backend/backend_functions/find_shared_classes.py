
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

from .status_enums import Status

def find_friends_in_shared_class(email:str, classname:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    friends = collection.find({
        "courses": {"$elemMatch": {"name": classname}},
        "email": {"$ne": email}
    })

    result = []
    for user in friends:
        result.append({
            "username": user.get("username")
        })
    
    client.close()
    return result