from flask import Flask, request, jsonify, logging
from flask.logging import create_logger
import logging

import pandas as pd
from sklearn.externals import joblib
from sklearn.preprocessing import StandardScaler

app = Flask(__name__)

# load pretrained model as clf
clf = joblib.load("./model_data/boston_housing_prediction.joblib")

def get_local_logger():
    """Defines and returns the logger for a local environment"""
    LOG = create_logger(app)
    LOG.setLevel(logging.DEBUG)
    return LOG
    
def get_production_logger():
    """Defines and returns the logger for the production environment"""
    return logging.getLogger("gunicorn.error")

def scale(payload):
    """Scales Payload"""
    
    LOG.info(f"Scaling Payload: \n{payload}")
    scaler = StandardScaler().fit(payload.astype(float))
    scaled_adhoc_predict = scaler.transform(payload.astype(float))
    return scaled_adhoc_predict

@app.route("/")
def home():
    html = f"<h3>Sklearn Prediction Home</h3>"
    return html.format(format)

@app.route("/predict", methods=['POST'])
def predict():
    """Performs an sklearn prediction
        
        input looks like:
        {
        "CHAS":{
        "0":0
        },
        "RM":{
        "0":6.575
        },
        "TAX":{
        "0":296.0
        },
        "PTRATIO":{
        "0":15.3
        },
        "B":{
        "0":396.9
        },
        "LSTAT":{
        "0":4.98
        }
        
        result looks like:
        { "prediction": [ <val> ] }
        
        """
    
    # Logging the input payload
    json_payload = request.json
    LOG.info(f"JSON payload: \n{json_payload}")
    inference_payload = pd.DataFrame(json_payload)
    LOG.info(f"Inference payload DataFrame: \n{inference_payload}")
    # scale the input
    scaled_payload = scale(inference_payload)
    LOG.info(f"Scaled payload: \n{scaled_payload}")
    # get an output prediction from the pretrained model, clf
    prediction = list(clf.predict(scaled_payload))
    LOG.info(f"Prediction: \n{prediction}")
    
    return jsonify({'prediction': prediction})

if __name__ == "__main__": # development server
    LOG = get_local_logger()
    app.run(host='0.0.0.0', port=8000, debug=True)
else: #gunicorn
    LOG = get_production_logger()