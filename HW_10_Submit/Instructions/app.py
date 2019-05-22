from flask import Flask

import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

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
        f"/api/v1.0/stations"
        f"/api/v1.0/precipitation"
        f"/api/v1.0/tobs"
    )

@app.route("/api/v1.0/stations")
def stations():
    """Return the station data as json"""
    # Query all stations
    results = session.query(Measurement.station).all()
    # Convert list of tuples into normal list
    # format from route to lis
    all_stations = list(np.ravel(results))
    return jsonify(all_stations)

@app.route("/api/v1.0/precipitation")
def precipitation():
    """Return preciptation levels as JSON"""
    # Query precipitation
    results = session.query(Measurement.pcpr)
    all_prcp = list(np.navel(results))
    return jsonify(all_prcp)

if __name__ == "__main__":
    app.run(debug=True)