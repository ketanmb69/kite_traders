
#Run the application

sudo chmod -R 775 /home/ec2-user/kite-traders1

cd /home/ec2-user/
python3 -m venv env
source /home/ec2-user/env/bin/activate

cd /home/ec2-user/kite-traders1
pip3 install -r requirements.txt


export API_KEY="pk_2417e95c90454964b39de4be237537de"

echo "Running the application"
python3 application.py > app.out.log 2> app.err.log < /dev/null & 