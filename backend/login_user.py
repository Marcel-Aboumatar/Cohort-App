
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

from status_enums import Status


#takes a email and a password as strings
#if the email and password match a user in the database then return 1
#otherwise it returns 0
def login_user(email:str, password:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["users"]
    collection = database["login"]

    #get all users from database
    all_users = [user for user in collection.find()]

    for user in all_users:

        password_inputed_hash = hashlib.sha256((password + user.get("salt")).encode('utf-8')).hexdigest()
        password_in_database_hash = user.get("password_hash")

        if not(user.get("email") == email):
            continue
            
        if not(password_inputed_hash == password_in_database_hash):
            continue

        client.close()
        print("login succesful")
        return 1
    
    client.close()
    print("login failed")
    return 0


#print(login_user("marcel1", "1234"))