
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

from .status_enums import Status


#takes a email and a password as strings
#if the email and password match a user in the database return
def login_user(email:str, password:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    #get all users from database
    all_users = [user for user in collection.find()]

    for user in all_users:

        if not(user.get("email") == email):
            continue

        password_inputed_hash = hashlib.sha256((password + user.get("salt")).encode('utf-8')).hexdigest()
        password_in_database_hash = user.get("password_hash")
            
        if password_inputed_hash == password_in_database_hash:
            client.close()
            print("login succesful")
            return Status.SUCCESS
        else: 
            client.close()
            print("password is incorrect")
            return Status.INVALID_PASSWORD
    
    client.close()
    print("account not found")
    return Status.INVALID_EMAIL


#print(login_user("marcel1", "1234"))