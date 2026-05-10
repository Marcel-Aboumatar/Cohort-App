from flask import Flask, request, session, jsonify, render_template
from flask_cors import CORS

import backend_functions as f
from backend_functions.status_enums import Status

from dotenv import load_dotenv
import os

app = Flask(__name__)


app.config["SESSION_COOKIE_SAMESITE"] = "None"
app.config["SESSION_COOKIE_SECURE"] = True

CORS(
    app,
    supports_credentials=True,
    origins=[
        r"http://localhost:\d+",
        r"http://127.0.0.1:\d+",
    ]
)
load_dotenv()
app.secret_key = os.getenv("SECRET_KEY")

#=========================for testing=======================#
@app.route("/")
def home():
    return "HOME"

#inputs: username, password
#returns: 
@app.route("/signup", methods=["POST"])
def signup():

    # Handle form submit
    username = request.form.get("username")
    age = request.form.get("age")
    major = request.form.get("major")
    email = request.form.get("email")
    password = request.form.get("password")
    discoverable = request.form.get("discoverable")

    if username is None or age is None or major is None or email is None or password is None or discoverable is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400

    result = f.create_user(username, age, major, email, password, discoverable)

    if result == Status.EMAIL_ALREADY_EXISTS:
        return jsonify({
            "success": False,
            "error": "account with this email already exists"
        }), 409

    session["email"] = email

    return jsonify({
        "success": True,
    }), 200


@app.route("/login", methods=["POST"])
def login():

    email = request.form.get("email")
    password = request.form.get("password")

    if email is None or password is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400

    login_result = f.login_user(email, password)

    if login_result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Not Found"
        }), 409
    if login_result == Status.INVALID_PASSWORD:
        return jsonify({
            "success": False,
            "error": "Password Is Incorrect"
        }), 409

    session["email"] = email

    return jsonify({
        "success": True,
    }), 200

@app.route("/logout")
def logout():
    session.clear()
    return jsonify({
        "success": True,
    }), 200

@app.route("/delete_user", methods=["POST"])
def delete_user():
    email = session.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    f.delete_user(email)

    return jsonify({
        "success": True,
    }), 200

@app.route("/get_user_info", methods=["POST"])
def get_user_info():
    email = session.get("email")

    print(session)

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result, user = f.query_user(email)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Not Found"
        }), 409

    return jsonify({
        "success": True,
        "user": user
    }), 200

#gives only the name, age, and major
@app.route("/get_private_user_info", methods=["POST"])
def get_private_user_info():
    email = request.form.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result, user = f.query_private_user(email)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Not Found"
        }), 409

    return jsonify({
        "success": True,
        "user": user
    }), 200

@app.route("/send_friend_request", methods=["POST"])
def send_friend_request():

    email_sender = session.get("email")
    email_receiver = request.form.get("email_receiver")

    if email_sender is None or email_receiver is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400

    result = f.send_friend_request(email_sender, email_receiver)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409
    
    return jsonify({
        "success": True,
    }), 200

@app.route("/accept_friend_request", methods=["POST"])
def accept_friend_request():

    email_sender = request.form.get("email_sender")
    email_receiver = session.get("email")

    if email_sender is None or email_receiver is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.accept_friend_request(email_sender, email_receiver)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409
    
    return jsonify({
        "success": True,
    }), 200

@app.route("/decline_friend_request", methods=["POST"])
def decline_friend_request():

    email_sender = request.form.get("email_sender")
    email_receiver = session.get("email")

    if email_sender is None or email_receiver is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.decline_friend_request(email_sender, email_receiver)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409
    
    return jsonify({
        "success": True,
    }), 200

@app.route("/remove_friend", methods=["POST"])
def remove_friend():

    email_user = session.get("email")
    email_friend = request.form.get("email_friend")

    if email_user is None or email_friend is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.remove_friend(email_user, email_friend)

    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409
    
    return jsonify({
        "success": True,
    }), 200

@app.route("/update_user", methods=["POST"])
def update_user():

    email = session.get("email")
    new_username = request.form.get("new_username")
    new_major = request.form.get("new_major")
    new_age = request.form.get("new_age")
    new_private_bool = request.form.get("new_private_bool")

    if email is None or new_username is None or new_major is None or new_age is None or new_private_bool is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    f.update_user(email, new_username, new_major, new_age, new_private_bool)
    
    return jsonify({
        "success": True,
    }), 200


@app.route("/get_all_friends", methods=["POST"])
def get_all_friends():

    email = session.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result, friends = f.get_all_friends(email)
    
    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409

    return jsonify({
        "success": True,
        "friends": friends
    }), 200

@app.route("/get_all_friend_requests", methods=["POST"])
def get_all_friend_requests():

    email = session.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result, friend_requests = f.get_all_friend_requests(email)
    
    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409

    return jsonify({
        "success": True,
        "friends": friend_requests
    }), 200

@app.route("/get_all_friends_in_class", methods=["POST"])
def get_all_friends_in_class():

    email = session.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result, friend_requests = f.get_all_friends_in_class(email)
    
    if result == Status.INVALID_EMAIL:
        return jsonify({
            "success": False,
            "error": "Account Error"
        }), 409

    return jsonify({
        "success": True,
        "friends": friend_requests
    }), 200

@app.route("/find_friends_in_shared_class", methods=["POST"])
def find_friends_in_shared_class():

    email = session.get("email")
    classname = request.form.get("classname")

    if email is None or classname is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    friends = f.find_friends_in_shared_class(email, classname)
    
    return jsonify({
        "success": True,
        "friends": friends
    }), 200

@app.route("/find_random_in_shared_class", methods=["POST"])
def find_random_in_shared_class():

    email = session.get("email")

    if email is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    friends = f.find_random_in_shared_class(email, 10)
    
    return jsonify({
        "success": True,
        "friends": friends
    }), 200

@app.route("/load_schedule_login", methods=["POST"])
def load_schedule_login():
    
    email = request.form.get("email")
    password = request.form.get("password")

    if email is None or password is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.run_authenticator_assistant(email, password)

    return jsonify({
        "success": True,
        "code": result
    }), 200

@app.route("/load_schedule_login", methods=["POST"])
def load_schedule_login():
    
    email = request.form.get("email")
    password = request.form.get("password")

    if email is None or password is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.run_playwright(email, password)

    return jsonify({
        "success": True,
        "code": result
    }), 200

@app.route("/scrape", methods=["POST"])
def scrape():
    
    email = session.get("email")

    if email is None or password is None:
        return jsonify({
            "success": False,
            "error": "Missing field"
        }), 400
    
    result = f.load_schedule(email)

    return jsonify({
        "success": True,
        "code": result
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)