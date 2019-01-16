from flask import Flask, jsonify, request, render_template, json

from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///resources/congress_list.sqlite"

db = SQLAlchemy(app)


class Congress_list(db.Model):
    __tablename__ = 'congress_list'
    year = db.Column(db.Integer, primary_key=True)
    json = db.Column(db.String)

    def __repr__(self):
        return '<Congress_list %r>' % (self.json)


@app.route('/')
def home():
    return render_template("index.html")


@app.route("/api/dashboard")
def dashboard():

    data = json.load(open("resources/dashboard_us_congress_list.json"))

    return jsonify(data)


@app.route("/api/data")
def list_pets():
    results = db.session.query(Congress_list.json).filter(
        Congress_list.year == 2018)

    return results[0]


@app.route("/api/map")
def map():

    data = json.load(open("resources/cb_2017_us_cd115_20m.json"))

    return jsonify(data)


if __name__ == "__main__":
    app.run()
