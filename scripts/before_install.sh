
#Before Starting the Application


DIR="/home/ec2-user/kite-traders"
if [ -d "$DIR" ]; then
  echo "${DIR} exists"
else
  echo "Creating ${DIR} directory"
  mkdir ${DIR}
fi

export API_KEY=pk_2417e95c90454964b39de4be237537de