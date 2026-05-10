from flask import Flask, request, jsonify, render_template
from flask_cors import CORS

from add_user import add_user_to_database
from login_user import login_user
from flask_api import *

from status_enums import Status

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

    if not username or not age or not major or not email or not password or not discoverable:
        return jsonify({
            "success": False,
            "error": "Missing email"
        }), 400
    
    if not password:
        return jsonify({
            "success": False,
            "error": "Missing password"
        }), 400

    result = add_user_to_database(username, age, major, email, password, discoverable)

    if result == Status.EMAIL_ALREADY_EXISTS:
        return jsonify({
            "success": False,
            "error": "account with this email already exists"
        }), 409

    return jsonify({
        "success": True,
    }), 200


@app.route("/login", methods=["GET", "POST"])
def login():

    # Show login page
    if request.method == "GET":
        return render_template("login_form_sample.html")

    # Handle login form
    username = request.form.get("username")
    password = request.form.get("password")

    if not username:
        return "Missing username"

    if not password:
        return "Missing password"

    login_result = login_user(username, password)

    if login_result:
        return f"Logged in as {username}"

    return "Incorrect username or password"


if __name__ == "__main__":
    app.run(host="localhost", port=8001, debug=True)