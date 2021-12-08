
#Run the application

sudo chmod -R 775 /home/ubuntu/kite-traders1/myproj
#sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1
#sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1/*

cd /home/ubuntu/kite-traders1
python3 -m venv venv
source /home/ubuntu/kite-traders1/venv/bin/activate

cd /home/ubuntu/kite-traders1/myproj
pip install -r requirements.txt

sudo chown ubuntu:ubuntu finance.db

export API_KEY="pk_2417e95c90454964b39de4be237537de"

echo "Running the application"
python application.py >> /dev/null 2>&1 &

