#!bin/bash

pip install -r requirements.txt
timeout 10

export API_KEY=pk_2417e95c90454964b39de4be237537de


python application.py &