#!/bin/bash

# Update package list
sudo apt update -y

# 1. Install Java (Jenkins is a Java-based application)
sudo apt install openjdk-17-jre -y

# 2. Add the Jenkins repository key and source list
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# 3. Update package list again and install Jenkins
sudo apt-get update -y
sudo apt-get install jenkins -y

# 4. Start and enable Jenkins to run on boot
sudo systemctl enable jenkins
sudo systemctl start jenkins

# 5. Install Docker (Jenkins needs Docker to build your images!)
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# 6. Add Jenkins user and Ubuntu user to the Docker group
# This gives them permission to run Docker commands without needing "sudo"
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

# Restart Jenkins so it picks up the new Docker permissions
sudo systemctl restart jenkins

echo "Installation Complete! Jenkins is running on port 8080."
