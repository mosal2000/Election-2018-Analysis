from flask import Flask, jsonify, request, render_template, json

import os

import pandas as pd
import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine

from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///resources/congress_list.sqlite"

db = SQLAlchemy(app)


# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(db.engine, reflect=True)

# Save references to each table
Congress_list = Base.classes.congress_list


@app.route('/')
def home():
    return render_template("index.html")


@app.route("/api/dashboard")
def dashboard():
    results = db.session.query(Congress_list).all()

    all_district = []
    for district in results:
        district_dict = {}
        district_dict["congress_num"] = district.congress_num
        district_dict["election_year"] = district.election_year
        district_dict["state"] = district.state
        district_dict["st_abbrev"] = district.st_abbrev
        district_dict["fips"] = district.fips
        district_dict["STATEFP"] = district.STATEFP
        district_dict["district"] = district.district
        district_dict["CD115FP"] = district.CD115FP
        district_dict["GEOID"] = district.GEOID
        district_dict["name"] = district.name
        district_dict["party"] = district.party
        district_dict["fec_candidate_id"] = district.fec_candidate_id
        district_dict["url"] = district.url
        district_dict["fin_total_receipt"] = district.fin_total_receipt
        district_dict["fin_total_disbursement"] = district.fin_total_disbursement
        district_dict["employment"] = district.employment
        district_dict["annual_payroll_in_1000"] = district.annual_payroll_in_1000
        district_dict["num_of_establishment"] = district.num_of_establishment
        all_district.append(district_dict)

    return jsonify(all_district)


@app.route("/api/state/<postal_code>")
def one_state(postal_code):
    results = db.session.query(Congress_list).filter(
        Congress_list.st_abbrev == postal_code).all()

    # Convert list of tuples into normal list
    # all_names = list(np.ravel(results))

    all_district = []
    for district in results:
        district_dict = {}
        district_dict["congress_num"] = district.congress_num
        district_dict["election_year"] = district.election_year
        district_dict["state"] = district.state
        district_dict["st_abbrev"] = district.st_abbrev
        district_dict["fips"] = district.fips
        district_dict["STATEFP"] = district.STATEFP
        district_dict["district"] = district.district
        district_dict["CD115FP"] = district.CD115FP
        district_dict["GEOID"] = district.GEOID
        district_dict["name"] = district.name
        district_dict["party"] = district.party
        district_dict["fec_candidate_id"] = district.fec_candidate_id
        district_dict["url"] = district.url
        district_dict["fin_total_receipt"] = district.fin_total_receipt
        district_dict["fin_total_disbursement"] = district.fin_total_disbursement
        district_dict["employment"] = district.employment
        district_dict["annual_payroll_in_1000"] = district.annual_payroll_in_1000
        district_dict["num_of_establishment"] = district.num_of_establishment
        all_district.append(district_dict)

    return jsonify(all_district)


@app.route("/api/map")
def map():

    data = json.load(open("resources/cb_2017_us_cd115_20m.json"))

    return jsonify(data)


if __name__ == "__main__":
    app.run()
