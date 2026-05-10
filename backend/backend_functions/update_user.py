
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

from .status_enums import Status

def update_user(email:str, new_username, new_major, new_age, new_private_bool):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    collection.update_one(
        {"email": email},
        {
            "$set": {
                "username": new_username,
                "major": new_major,
                "age": new_age,
                "private_acount": new_private_bool
            }
        }
    )

    client.close()
    return Status.SUCCESS
    