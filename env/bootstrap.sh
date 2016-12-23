#!/usr/bin/env bash
print_step () {
    echo $1
}

apt-get update
sudo apt-get upgrade -y
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#Install Ansible
echo "Install Ansible..."
apt-get install --assume-yes software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
#apt-get -y upgrade
apt-get install --assume-yes ansible
sudo -H -u ubuntu echo "LS_COLORS=\$LS_COLORS:'di=0;35:' ; export LS_COLORS" >> /home/ubuntu/.bashrc

echo "Install Docker..."
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-engine
sudo service docker start
sleep 3
echo "Test Docker..."
sudo docker run hello-world

#setup Jenkins
echo "Install Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins

#setup jdk 
echo "Install JDK"
sudo apt-get -y install default-jdk

#setup maven
echo "Install maven"
sudo apt-get -y install maven

#setup git
sudo apt-get -y install git


# *********************************************
# Commenting out Docker jenkins
#  Howto guide for when we get further along
#  https://www.wouterdanes.net/2014/04/11/continuous-integration-using-docker-maven-and-jenkins.html
#mkdir -p /home/ubuntu/jenkins
#mkdir -p /home/ubuntu/jenkins/plugins/
# Jenkins plugins
# If you add plugins after the install need to login and then go to <jenkinsIP>:8080/restart
#cd /home/ubuntu/jenkins/plugins/
#wget http://updates.jenkins-ci.org/latest/authentication-tokens.hpi
#wget http://updates.jenkins-ci.org/latest/docker-commons.hpi
#wget http://updates.jenkins-ci.org/latest/docker-custom-build-environment.hpi

#sudo chmod ugo+rw ~/jenkins   # maybe permissiosn too much not sure
#sudo docker run -p 8080:8080 -p 50000:50000 -v /home/ubuntu/jenkins:/var/jenkins_home -d jenkins
# **** end of Docker Jenkins

# Goal put Ruby in docker file and add cucumber to that container for now just pull ruby into Host
echo "Install Ruby..."
sudo apt-get -y install ruby-full
sudo gem install cucumber
sudo gem install gherkin


echo "Install node js"
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# install chrome/chrome driver
echo "Install Chrome..."
sudo apt-get -y install libxss1 libappindicator1 libindicator7
echo "Downloading Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome*.deb
sudo apt-get install -f -y
sudo apt-get install -y xvfb # headless chrome
sudo apt-get install -y unzip

echo "Install ChromeDriver..."
wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver

sudo mv -f chromedriver /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver


# enable insecure registry DOCKER_OPTS="--insecure-registry 10.100.198.200:5000"in file /etc/default/docker/ 
#ansible-playbook -i "localhost," -c local docker.yml

# Force upgde dist for changed dependencies
sudo apt-get dist-upgrade -y
