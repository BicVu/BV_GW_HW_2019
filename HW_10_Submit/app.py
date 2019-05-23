from flask import Flask

import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect

# connect to Flask
from flask import Flask, jsonify

#################################################
# Database Setup
#################################################
# set up path for engine
engine = create_engine("sqlite:///hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()

# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to each table. Reflection table to classes.
Measurement = Base.classes.measurement
Station = Base.classes.station

# initiate session
session = Session(engine)

# Set up Flask
app = Flask(__name__)

# Homepage
@app.route("/")
def home():
    return (
        f"Aloha! Welcome to the the Hawaiin climate API.<br/>"
        f"Here you can find:<br/>"
        f"Stations at /api/v1.0/stations<br/>"
        f"Precipitations at /api/v1.0/precipitation<br/>"
        f"Temps at /api/v1.0/temp<br/>"
        f"Start date at /api/v1.0/start_date</br>"
        f"Vacation on at /api/v1.0/vacation"
    )

@app.route("/api/v1.0/stations")
def stations():
    """Return the station data as json"""
    # Query all stations
    results = session.query(Measurement.station).all()
    all_stations = list(np.ravel(results))
    return jsonify(all_stations)

@app.route("/api/v1.0/precipitation")
def precipitation():
    results = session.query(Measurement.prcp).all()
    all_prcp = list(np.ravel(results))
    return jsonify(all_prcp)

@app.route("/api/v1.0/temp")
def tobs():
    results = session.query(Measurement.tobs).all()
    all_tobs = list(np.ravel(results))
    return jsonify(all_tobs)

@app.route("/api/v1.0/start_date")
def start_date():
    results = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= '2010-01-01').all()
    start_date = list(np.ravel(results))
    return jsonify(start_date)


@app.route("/api/v1.0/vacation")
def vacation():
    results = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= '2016-05-12').filter(Measurement.date <= '2016-05-24').all()
    vacation = list(np.ravel(results))
    return jsonify(vacation)

if __name__ == "__main__":
    app.run(debug=True)
