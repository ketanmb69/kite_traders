
#Run the application

sudo chmod -R 775 /home/ec2-user/kite-traders1
sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1
sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1/*

cd /home/ec2-user/
python3 -m venv env
source /home/ec2-user/env/bin/activate

cd /home/ec2-user/kite-traders1
pip install -r requirements.txt

export API_KEY="pk_2417e95c90454964b39de4be237537de"

echo "Running the application"
python application.py >> /dev/null 2>&1 &
