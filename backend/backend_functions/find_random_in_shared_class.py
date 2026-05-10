
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

from .status_enums import Status

def find_random_in_shared_class(email:str, num:int):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    current_user = collection.find_one(
        {"email": email},
        {"_id": 0, "courses": 1}
    )

    if not current_user:
        client.close()
        return []
    
    user_courses = [course["name"] for course in current_user.get("courses", [])]

    users = collection.find({
        "email": {"$ne": email},
        "courses.name": {"$in": user_courses}
    })

    result = []
    for user in users:
        other_courses = [c["name"] for c in user.get("courses", [])]

        shared = list(set(user_courses) & set(other_courses))

        if shared:
            result.append({
                "username": user.get("username"),
                "email": user.get("email"),
                "age": user.get("age"),
                "major": user.get("major"),
                "shared_courses": shared
            })

        if len(result) == num:
            break
    
    client.close()
    return result