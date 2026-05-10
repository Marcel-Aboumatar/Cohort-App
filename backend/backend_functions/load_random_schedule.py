import random
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv
import os

# Load .env once
load_dotenv()
DATABASE_URI = os.getenv("DATABASE_URI")

# MongoDB client
client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
database = client["user_database"]
collection = database["users"]

# Sample courses
sample_courses = [
    {
        "name": "Operating Systems",
        "code": "CIS*3110*1010",
        "course_sections": [
            {
                "type": "LEC",
                "location": "CRSC, 116",
                "days": [0,0,1,0,1,0,0],
                "starttime": "10:00AM",
                "endtime": "11:20AM",
                "course_duration": "1/5/2026 - 4/21/2026"
            }
        ],
        "instructor": "Kotseruba, I"
    },
    {
        "name": "Data Structures",
        "code": "CIS*2520*1010",
        "course_sections":[
            {
                "type": "LEC",
                "location": "CRSC, 200",
                "days": [1,0,1,0,1,0,0],
                "starttime": "2:00PM",
                "endtime": "3:20PM",
                "course_duration": "1/5/2026 - 4/21/2026"
            }
        ],
        "instructor": "Smith, J"
    },
    {
        "name": "Database Systems",
        "code": "CIS*3520*1010",
        "course_sections":[
            {
                "type": "LEC",
                "location": "CRSC, 101",
                "days": [0,1,0,1,0,1,0],
                "starttime": "11:30AM",
                "endtime": "12:50PM",
                "course_duration": "1/5/2026 - 4/21/2026"
            }
        ],
        "instructor": "Lee, K"
    },
    {
        "name": "Computer Networks",
        "code": "CIS*4430*1010",
        "course_sections":[
            {
                "type": "LEC",
                "location": "CRSC, 220",
                "days": [1,0,1,0,1,0,0],
                "starttime": "9:00AM",
                "endtime": "10:20AM",
                "course_duration": "1/5/2026 - 4/21/2026"
            }
        ],
        "instructor": "Nguyen, T"
    },
    {
        "name": "Software Engineering",
        "code": "CIS*3750*1010",
        "course_sections":[
            {
                "type": "LEC",
                "location": "CRSC, 150",
                "days": [0,1,0,1,0,1,0],
                "starttime": "1:00PM",
                "endtime": "2:20PM",
                "course_duration": "1/5/2026 - 4/21/2026"
            }
        ],
        "instructor": "Brown, L"
    }
]

# Emails of users
emails = [
    "alice.smith1@gmail.com",
    "bob.johnson2@yahoo.com",
    "charlie.brown3@outlook.com",
    "david.taylor4@gmail.com",
    "eva.anderson5@example.com",
    "frank.thomas6@gmail.com",
    "grace.jackson7@yahoo.com",
    "hannah.white8@outlook.com",
    "ian.harris9@gmail.com",
    "julia.martin10@example.com",
    "kevin.smith11@gmail.com",
    "lara.johnson12@yahoo.com",
    "mason.brown13@outlook.com",
    "nina.taylor14@gmail.com",
    "oscar.anderson15@gmail.com",
    "paula.thomas16@gmail.com",
    "quinn.jackson17@yahoo.com",
    "ryan.white18@outlook.com",
    "sophia.harris19@gmail.com",
    "tom.martin20@example.com"
]

# Function to load random schedule
def load_sample_schedule(email: str, course_list: list):
    collection.update_one(
        {"email": email},
        {"$set": {"courses": course_list}}
    )
    print(f"Added courses for {email}")
    return "SUCCESS"

# Assign random schedules to all emails
for email in emails:
    courses = random.sample(sample_courses, k=random.randint(1, 3))
    load_sample_schedule(email, courses)

# Close the client at the end
client.close()