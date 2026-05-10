
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

from .status_enums import Status

#takes a username and a password as strings
#if the username is unique it adds it to the database and returns 1
#otherwise it returns 0
def create_user(username:str, age:str, major:str, email:str, password:str, discoverable:bool):
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

create_user("aliceSmith1", "20", "Computer Science", "alice.smith1@gmail.com", "password123", True)
create_user("bobJohnson2", "22", "Mathematics", "bob.johnson2@yahoo.com", "password123", False)
create_user("charlieBrown3", "19", "Physics", "charlie.brown3@outlook.com", "password123", True)
create_user("davidTaylor4", "21", "Engineering", "david.taylor4@gmail.com", "password123", True)
create_user("evaAnderson5", "23", "Biology", "eva.anderson5@example.com", "password123", False)
create_user("frankThomas6", "20", "Economics", "frank.thomas6@gmail.com", "password123", True)
create_user("graceJackson7", "22", "Computer Science", "grace.jackson7@yahoo.com", "password123", False)
create_user("hannahWhite8", "18", "Mathematics", "hannah.white8@outlook.com", "password123", True)
create_user("ianHarris9", "24", "Physics", "ian.harris9@gmail.com", "password123", True)
create_user("juliaMartin10", "21", "Engineering", "julia.martin10@example.com", "password123", False)
create_user("kevinSmith11", "20", "Biology", "kevin.smith11@gmail.com", "password123", True)
create_user("laraJohnson12", "23", "Economics", "lara.johnson12@yahoo.com", "password123", False)
create_user("masonBrown13", "22", "Computer Science", "mason.brown13@outlook.com", "password123", True)
create_user("ninaTaylor14", "19", "Mathematics", "nina.taylor14@gmail.com", "password123", False)
create_user("oscarAnderson15", "21", "Physics", "oscar.anderson15@example.com", "password123", True)
create_user("paulaThomas16", "20", "Engineering", "paula.thomas16@gmail.com", "password123", True)
create_user("quinnJackson17", "22", "Biology", "quinn.jackson17@yahoo.com", "password123", False)
create_user("ryanWhite18", "23", "Economics", "ryan.white18@outlook.com", "password123", True)
create_user("sophiaHarris19", "19", "Computer Science", "sophia.harris19@gmail.com", "password123", False)
create_user("tomMartin20", "21", "Mathematics", "tom.martin20@example.com", "password123", True)