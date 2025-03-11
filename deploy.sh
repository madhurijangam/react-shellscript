#!/bin/bash

REACT_REPO_URL="https://github.com/Syknapse/react-hello-world-app.git" # Replace with your React repository URL
APP_NAME="react-hello-world-app" # Replace with your React app's name
read -p "Enter the deployment directory (e.g., /opt/react): " DEPLOY_DIR

# Check if the directory is provided
if [ -z "$DEPLOY_DIR" ]; then
    echo "Deployment directory not provided. Exiting."
    exit 1
fi
NGINX_CONFIG_FILE="/etc/nginx/sites-enabled/react-app"

# Deployment Steps
echo "#################################"
echo "React Deployment"
echo "#################################"
echo

# 1. Clone the React Repository
echo "###### --- Git Cloning --- ########"
mkdir -p "$DEPLOY_DIR"
cd "$DEPLOY_DIR"
git clone "$REACT_REPO_URL"
if [ $? -ne 0 ]; then
    echo "Cloning failed. Check the repository URL."
    exit 1
fi

# 2. Navigate to the Cloned Directory
cd "$DEPLOY_DIR/$APP_NAME"
echo "Moved to directory: $(pwd)"

# 3. Install Dependencies and Build
echo "#######################"
echo "npm install and npm run build"
echo "#######################"
npm install
if [ $? -ne 0 ]; then
    echo "npm install failed."
    exit 1
fi
npm run build
if [ $? -ne 0 ]; then
    echo "npm run build failed."
    exit 1
fi

# 4. Set Build Folder Permissions
echo "##################################"
echo "Build folder is ready"
echo "##################################"
chmod -R 755 build

# 5. Nginx Configuration
echo "###########################"
echo "Modify the configuration file"
echo "###########################"
read -p "Enter the IP address or domain: " SERVER_NAME

cat <<EOF > "$NGINX_CONFIG_FILE"
server {
    listen 80;
    listen [::]:80;
    server_name $SERVER_NAME;

    root $DEPLOY_DIR/$APP_NAME/build;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

chmod 644 "$NGINX_CONFIG_FILE"

# 6. Test and Reload Nginx
if sudo nginx -t; then
    echo "Nginx configuration test successful."
    sudo nginx -s reload
    echo "Nginx reloaded."
    echo "Configuration file contents:"
    cat "$NGINX_CONFIG_FILE"
else
    echo "Nginx configuration test failed. Check the configuration file."
    sudo nginx -t 2>&1
    exit 1
fi

echo "###########################"
echo "Deployment complete."
