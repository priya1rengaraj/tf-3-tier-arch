#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jdk -y

cd /opt
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
sudo tar -xvzf apache-tomcat-9.0.85.tar.gz
sudo mv apache-tomcat-9.0.85 tomcat

sudo chmod +x /opt/tomcat/bin/*.sh

sudo /opt/tomcat/bin/startup.sh