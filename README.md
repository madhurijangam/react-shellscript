# Deploy React Js  Application using Shell-Script

🚀Streamline your React frontend deployments with this well-structured shell script 🚀📁 📄🛠️

## 👉Installation Set Up

Ensure you have the following packages installed in ec-2 terminal: 

* Nginx
* Node.js

 If not there try to install using :

* For Nginx
```bash
apt install nginx
```
* For Node-js
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```
```bash
apt install nodejs -y
```
```bash
sudo apt install npm -y
```




## 👉Script file Set Up
* Create shellscript file. 

 example: deploy.sh
```bash
vi deploy.sh 
```

* Give permissions to that file. 
```bash
chmod 755 deploy.sh
```
* Copy the Above shell script file and paste in deploy.sh 
* Replace **REACT_REPO_URL** with your git-hub react code url. 

* Replace **APP_NAME** with your app - name. 

## 👉Execution of Script file

* Execute the command to execute the shell script file
```bash
./deploy.sh
```

* ⚠️ensure that port 80 have access in inbound rules under security group rules of your  instance ⚠️

** optional **
* Give your Public-IP of Your ec2 instance when it prompts you to ask 

✨🎉🥳 Once deployment is done your **React-application** will be available at  **PORT 80** 🎉🥳🥳




[ 👉Dowload this Sample React Code and Try 👈 ](https://github.com/Syknapse/react-hello-world-app.git)

## 👋 Hi! from Sneha-Madhuri-Jangam 
