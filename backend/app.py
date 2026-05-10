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
        "user": user
    }), 200

if __name__ == "__main__":
    app.run(host="localhost", port=8001, debug=True)