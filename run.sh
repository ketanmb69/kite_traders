
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

echo "removing the code-agent"
sudo dpkg --purge codedeploy-agent

echo "deleting the codeagent dir"
sudo rm -rf /opt/codedeploy-agent/

#echo "killing teh codeagent processes"
#sudo ps -fu root | grep codedeploy | awk -F" " '{print $2}' | xargs sudo kill


if sudo ps -fu 'root' | grep codedeploy
then
PID=`sudo ps -fu root | grep codedeploy | awk -F" " '{print $2}' | head -1`; 
sudo kill -9 $PID; 
while [ -e /proc/$PID ]; 
do echo "Process: $PID is still running" > /home/ubuntu/pid.log;
sleep .6; 
done; 
echo "Process $PID has finished" >> /home/ubuntu/pid.log; 
else
echo "no process running as codeagent"
fi

echo "installing the codeagent"
cd /home/ubuntu/
sudo ./install auto > /dev/null 2>&1 &