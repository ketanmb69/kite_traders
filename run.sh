
#Run the application

sudo chmod -R 775 /home/ec2-user/kite-traders

cd /home/ec2-user/kite-traders
pip3 install -r requirements.txt


export API_KEY="pk_2417e95c90454964b39de4be237537de"

echo "Running the application"
python3 application.py & 