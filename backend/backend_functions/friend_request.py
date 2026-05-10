
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
        {"$addToSet": {"friend_requests": sender}}
    )

    client.close()
    return Status.SUCCESS
    


def accept_friend_request(email_sender:str, email_receiver):
    pass

def remove_friend(email_user, email_friend):
    pass