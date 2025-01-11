
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
dpkg -l | grep jenkins
systemctl cat jenkins
sudo cat /etc/passwd | grep jenkins

sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version


sudo systemctl enable jenkins

sudo systemctl start jenkins
sudo systemctl status jenkins

sudo systemctl status jenkins.service


# sudo apt install openjdk-11-jdk -y
sudo apt remove --purge openjdk-11-jdk -y
sudo apt autoremove -y

sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chown -R jenkins:jenkins /var/log/jenkins
sudo chown -R jenkins:jenkins /var/cache/jenkins

sudo netstat -tuln | grep 8080

sudo systemctl restart jenkins


sudo ufw allow 8080
sudo ufw reload

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

#Uninstall Jenkins

sudo systemctl stop jenkins
sudo apt remove --purge jenkins -y
sudo rm -rf /var/lib/jenkins
sudo rm -rf /var/log/jenkins
sudo rm -rf /etc/jenkins
sudo deluser --remove-home jenkins
sudo delgroup jenkins
sudo apt autoremove -y
dpkg -l | grep jenkins


# On jenkins slave
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version

sudo mkdir -p /home/jenkins/.ssh
sudo chmod 700 /home/jenkins/.ssh

# Copy the jenkins_rsa.pub file (the public key) from the Jenkins master to the slave's authorized_keys file

sudo cat /home/harshit/.ssh/id_rsa.pub | sudo tee -a /home/jenkins/.ssh/authorized_keys
sudo chmod 600 /home/jenkins/.ssh/authorized_keys
sudo chown -R jenkins:jenkins /home/jenkins/.ssh

