
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

from dotenv import load_dotenv
import os

import hashlib
import random
import string

from .student_detail_finder import run_playwright
from .status_enums import Status

def load_schedule(email:str):
    #load the database
    load_dotenv()
    DATABASE_URI = os.getenv("DATABASE_URI")

    client = MongoClient(DATABASE_URI, server_api=ServerApi('1'))
    database = client["user_database"]
    collection = database["users"]

    raw_courses = run_playwright()
    formated_courses = convert_courses(raw_courses)
    
    collection.update_one(
        {"email": email},
        {"$set": {"courses": formated_courses}}
    )
    
    client.close()
    return Status.SUCCESS


def convert_courses(raw_courses):
    formatted = []

    for course in raw_courses:
        new_course = {
            "name": course.get("name"),
            "code": "*".join((course.get("code").split("*"))[:2]),
            "course_sections": [],
            "instructor": course.get("instructor")
        }

        for section in course.get("course_sections", []):
            time_range = section.get("time_range", "")

            # split time into start/end if possible
            if time_range != "TBD" and "-" in time_range:
                start, end = [t.strip().replace(" ", "") for t in time_range.split("-")]
            else:
                start, end = "TBD", "TBD"

            new_section = {
                "type": section.get("course_type"),
                "location": None,  # optional (you can map later if needed)
                "days": section.get("days"),
                "starttime": start,
                "endtime": end,
                "course_duration": section.get("course_duration")
            }

            new_course["course_sections"].append(new_section)

        formatted.append(new_course)

    return formatted
