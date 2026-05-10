
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random

<<<<<<< Updated upstream
<<<<<<< Updated upstream
from status_enums import Status
=======
from .status_enums import Status
>>>>>>> Stashed changes
=======
from .status_enums import Status
>>>>>>> Stashed changes

def delete_user(email:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    collection.delete_one({"email": email})    

    client.close()
    return Status.SUCCESS
    