# 1. Download and Install Alertmanager
# Create a new user for Alertmanager
sudo useradd --no-create-home --shell /bin/false alertmanager

# Download the latest Alertmanager release
VERSION="0.27.0"  # Check https://github.com/prometheus/alertmanager/releases for latest version
wget https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz

# Extract and move binaries
tar xvf alertmanager-${VERSION}.linux-amd64.tar.gz
sudo mv alertmanager-${VERSION}.linux-amd64/alertmanager /usr/local/bin/
sudo mv alertmanager-${VERSION}.linux-amd64/amtool /usr/local/bin/

# Create directories for Alertmanager
target_dir="/etc/alertmanager"
sudo mkdir -p $target_dir
sudo mkdir -p /var/lib/alertmanager

# Set permissions
sudo chown -R alertmanager:alertmanager $target_dir /var/lib/alertmanager


# 2. Create a systemd Service
sudo tee /etc/systemd/system/alertmanager.service <<EOF
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager --config.file=$target_dir/alertmanager.yml --storage.path=/var/lib/alertmanager/

[Install]
WantedBy=multi-user.target
EOF


# 3. Create a Basic Alertmanager Configuration
sudo tee $target_dir/alertmanager.yml <<EOF
route:
  receiver: 'default-receiver'
receivers:
  - name: 'default-receiver'
    email_configs:
      - to: 'your-email@example.com'
        from: 'alertmanager@example.com'
        smarthost: 'smtp.example.com:587'
        auth_username: 'your-username'
        auth_password: 'your-password'
EOF

# Set correct ownership
sudo chown alertmanager:alertmanager $target_dir/alertmanager.yml


# 4. Start and Enable Alertmanager
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager


# 5. Verify that Alertmanager is Running
sudo systemctl status alertmanager


# 6. Check What Port Alertmanager is Running On
# sudo netstat -tulnp | grep alertmanager  # or
# sudo ss -tulnp | grep alertmanager

# Alertmanager runs on port 9093 by default. Access it via:
# http://<your-server-ip>:9093


# 7. (Optional) Open Port 9093 in Firewall
# For UFW (Ubuntu/Debian)
sudo ufw allow 9093/tcp

# For Firewalld (RHEL/CentOS)
# sudo firewall-cmd --add-port=9093/tcp --permanent
# sudo firewall-cmd --reload


