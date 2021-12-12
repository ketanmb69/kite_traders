KiteTraders – Free Stock Market web application using real time value from API

System Prerequisites 
Following packages and tools will be needed to run the application on a system.
    • Python >= 3.7
    • datetime
    • SQLite3
    • Flask and flash, jsonify, redirect, render_template, and request
    • Flask_session
    • tempfile

Steps to Run the application
    • Create account on https://iexcloud.io/ and get the API key
    • Login to aws cloud
    • Check the roles under IAM service, add CodeDeploy role and  add AWSCodeDeployRole policy.
    • Create EC2 instance and with Ubuntu as a platform and provide EC2CodeDeployRole in IAM Role.
    • Under user data for EC2 instance creation, include below scripts

	sudo apt update
	sudo apt-get install ruby
	sudo apt install wget
	cd /home/ubuntu
	wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
	sudo chmod +x ./install
	sudo ./install auto
	export API_KEY=<API_KEY from IEXCloud>

    •  Create the instance
    • create application on CodeDeploy
    • then create CodeDeploy Deployment Group, make sure provide CodeDeployRole as a service role.
    • Create aws codepipeline and provide github account and repository to pull the data.
    • After successful execution of the pipeline, go to public IP of the EC2 instance and 5000 port, eg. 192.168.0.1:5000/

If running the application on local machine use below steps,
    • open the terminal and perform below steps. 
    • python -m venv env   
    • source env/bin/activate
    • git clone https://github.com/ketanmb69/kite_traders.git
    • cd <repository_name>
    • export API_KEY=<API_KEY from IEXCloud>
    • pip install -r requirements.txt
    • Run the application using “python application.py”

The application will be accessible on the IP of the system and 5000 port.

Main Built-in Functionalities:
    • Password Hashing – This application hashes the password of the user, so no one can see the password(Werkzeug.security).
    • Portfolio Balance – The new user will be having 10000$ in the trading account.
    • Quote & Buy - in a three step process, the user will first query for a respective stock symbol, perform a buy estimate, and either executes a buy order, or not, using real time API quotes provided by IEX Cloud (https://iexcloud.io/) This process is concluded with a buy order confirmation
    • Sell - in a two step process, users may estimate, and subsequently, execute a sell order
    • Transaction History - view when all orders were place in the History page where the database displays all executed orders
