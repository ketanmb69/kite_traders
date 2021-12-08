
#Run the application

sudo chmod -R 775 /home/ubuntu/kite-traders1/myproj
#sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1
#sudo chown ec2-user:ec2-user /home/ec2-user/kite-traders1/*

cd /home/ubuntu/kite-traders1
python3 -m venv venv
source /home/ubuntu/kite-traders1/venv/bin/activate

cd /home/ubuntu/kite-traders1/myproj
pip install -r requirements.txt

export API_KEY="pk_2417e95c90454964b39de4be237537de"

echo "Running the application"
python application.py >> /dev/null 2>&1 &

sudo dpkg --purge codedeploy-agent
sudo rm -rf /opt/codedeploy-agent/
sudo ps -fu root | grep codedeploy | awk -F" " '{print $2}' | xargs sudo kill
sleep 10
cd /home/ubuntu/
sudo ./install auto
