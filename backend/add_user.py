
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

#takes a username and a password as strings
#if the username is unique it adds it to the database and returns 1
#otherwise it returns 0
def add_user_to_database(username:str, password:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["users"]
    collection = database["login"]

    #check for unique username
    all_users = [user for user in collection.find()]

    for user in all_users:
        if user.get("username") == username:
            client.close()
            print("username already exists")
            return 0


    #hash password
    salt_length = 50
    salt = ''.join(random.choices(string.ascii_letters + string.digits, k=salt_length))
    password_hash = hashlib.sha256((password + salt).encode('utf-8')).hexdigest()

    #add the info to the database
    user_info = {"username": username, "password_hash": password_hash, "salt": salt, "courses": [], "friends": []}
    collection.insert_one(user_info)
    
    client.close()
    print("added new user")
    return 1


#print(add_user_to_database("marcel1", "1234"))