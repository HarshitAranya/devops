alias terraform=tf
git config --global user.name "Harshit Aranya"
git config --global user.email harshit.aranya@gmail.com
git remote add origin https://github.com/HarshitAranya/devops.git

aws ec2 describe-instances --filters "Name=tag:Name,Values=AWSControllerVM" --query "Reservations[].Instances[].PublicIpAddress" #--output text

# update /ansible/hosts
# ansible-playbook -i /ansible/hosts /ansible/jenkinsPlay.yaml