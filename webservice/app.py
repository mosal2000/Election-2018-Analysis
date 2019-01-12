from flask import Flask, jsonify, request, render_template, json

app = Flask(__name__)


@app.route('/')
def home():
    return render_template("index.html")


@app.route("/api/dashboard")
def dashboard():

    data = json.load(open("resources/dashboard_us_congress_list.json"))

    return jsonify(data)


if __name__ == "__main__":
    app.run()
