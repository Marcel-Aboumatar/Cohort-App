
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

from status_enums import Status

def send_friend_request(email_sender:str, email_receiver:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    sender = collection.find_one(
        {"email": email_sender}, 
    )
    receiver = collection.find_one(
        {"email": email_receiver}, 
    )

    if sender is None or receiver is None:
        client.close()
        return Status.INVALID_EMAIL

    collection.update_one(
        {"email": email_receiver},
        {"$addToSet": {"friend_requests": email_sender}}
    )

    client.close()
    return Status.SUCCESS
    


def accept_friend_request(email_sender:str, email_receiver:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    sender = collection.find_one(
        {"email": email_sender}, 
    )
    receiver = collection.find_one(
        {"email": email_receiver}, 
    )

    if sender is None or receiver is None:
        client.close()
        return Status.INVALID_EMAIL
    
    collection.update_one(
        {"email": email_receiver},
        {"$pull": {"friend_requests": email_sender}}
    )

    collection.update_one(
        {"email": email_sender},
        {"$pull": {"friend_requests": email_receiver}}
    )

    collection.update_one(
        {"email": email_receiver},
        {"$addToSet": {"friends": email_sender}}
    )

    collection.update_one(
        {"email": email_sender},
        {"$addToSet": {"friends": email_receiver}}
    )

    client.close()
    return Status.SUCCESS

def decline_friend_request(email_sender:str, email_receiver:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    sender = collection.find_one(
        {"email": email_sender}, 
    )
    receiver = collection.find_one(
        {"email": email_receiver}, 
    )

    if sender is None or receiver is None:
        client.close()
        return Status.INVALID_EMAIL
    
    collection.update_one(
        {"email": email_receiver},
        {"$pull": {"friend_requests": email_sender}}
    )

    client.close()
    return Status.SUCCESS

def remove_friend(email_user:str, email_friend:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    user = collection.find_one(
        {"email": email_user}, 
    )
    friend = collection.find_one(
        {"email": email_friend}, 
    )

    if user is None or friend is None:
        client.close()
        return Status.INVALID_EMAIL
    
    collection.update_one(
        {"email": email_user},
        {"$pull": {"friends": email_friend}}
    )

    collection.update_one(
        {"email": email_friend},
        {"$pull": {"friends": email_user}}
    )

    client.close()
    return Status.SUCCESS