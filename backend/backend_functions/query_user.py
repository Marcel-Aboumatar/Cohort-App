
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

<<<<<<< Updated upstream
from status_enums import Status
=======
from .status_enums import Status
>>>>>>> Stashed changes

def query_user(email:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    user = collection.find_one(
        {"email": email}, 
        {"_id": 0, "password_hash": 0, "salt": 0}
    )

    if user == None:
        client.close()
        return Status.INVALID_EMAIL, None
    
    client.close()
    return Status.SUCCESS, user

def query_private_user(email:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    user = collection.find_one(
        {"email": email}, 
        {"username": 1, "major": 1, "age": 1}
    )

    if user == None:
        client.close()
        return Status.INVALID_EMAIL, None
    
    return Status.SUCCESS, user
