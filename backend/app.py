from flask import Flask, request, jsonify, render_template
from flask_cors import CORS

import backend.backend_functions as f
#from backend.backend_functions import login_user, create_user, query_user, query_private_user

from backend.backend_functions.status_enums import Status

app = Flask(__name__)
CORS(app)

#=========================for testing=======================#
@app.route("/")
def home():
    return render_template("home.html")

@app.route("/signup_form")
def signup_form():
    return render_template("signup.html")

@app.route("/login_form")
def login_form():
    return render_template("login.html")
#=========================for testing=======================#


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

    return jsonify({
        "success": True,
    }), 200


@app.route("/delete_user", methods=["POST"])
def delete_user():
    email = request.form.get("email")

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
    email = request.form.get("email")

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

    email_sender = request.form.get("email_sender")
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
    email_receiver = request.form.get("email_receiver")

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
    email_receiver = request.form.get("email_receiver")

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

    email_user = request.form.get("email_user")
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

    email = request.form.get("email")
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

if __name__ == "__main__":
    app.run(host="localhost", port=8001, debug=True)