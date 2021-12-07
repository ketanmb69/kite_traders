
#Run the application

sudo chmod -R 775 /home/ec2-user/kite-traders

cd /home/ec2-user/kite-traders
pip3 install requirements.txt

echo "Running the application"
python3 application.py & 