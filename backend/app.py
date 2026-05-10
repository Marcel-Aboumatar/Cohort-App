from flask import Flask, request, render_template
from flask_cors import CORS

from add_user import add_user_to_database
from login_user import login_user

app = Flask(__name__)
CORS(app)


@app.route("/")
def home():
    return render_template("home.html")

@app.route("/signup_form")
def signup_form():
    return render_template("signup.html")

@app.route("/login_form")
def login_form():
    return render_template("login.html")

@app.route("/signup", methods=["GET", "POST"])
def signup():

    # Show signup page
    if request.method == "GET":
        return render_template("login_form_sample.html")

    # Handle form submit
    username = request.form.get("username")
    password = request.form.get("password")

    if not username:
        return "Missing username"

    if not password:
        return "Missing password"

    result = add_user_to_database(username, password)

    return str(result)


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