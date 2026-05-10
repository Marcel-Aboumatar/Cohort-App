
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

<<<<<<< Updated upstream
from status_enums import Status
=======
from .status_enums import Status
>>>>>>> Stashed changes

#takes a username and a password as strings
#if the username is unique it adds it to the database and returns 1
#otherwise it returns 0
def add_user_to_database(username:str, age:str, major:str, email:str, password:str, discoverable:bool):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    #check for unique username
    all_users = [user for user in collection.find()]

    for user in all_users:
        if user.get("email") == email:
            client.close()
            print("email already exists")
            return Status.EMAIL_ALREADY_EXISTS


    #hash password
    salt_length = 50
    salt = ''.join(random.choices(string.ascii_letters + string.digits, k=salt_length))
    password_hash = hashlib.sha256((password + salt).encode('utf-8')).hexdigest()

    #add the info to the database
    user_info = {
                "email": email, 
                "password_hash": password_hash, 
                "salt": salt, 
                "username": username,
                "major": major,
                "age": age,
                "discoverable": discoverable,
                "courses": [], 
                "friends": [],
                "incoming_friend_requests":[]
    }
    collection.insert_one(user_info)
    
    client.close()
    print("added new user")
    return 1