# 1. Download and Install Blackbox Exporter
# Create a new user for Blackbox Exporter
sudo useradd --no-create-home --shell /bin/false blackbox_exporter

# Download the latest Blackbox Exporter release
VERSION="0.24.0"  # Check https://github.com/prometheus/blackbox_exporter/releases for latest version
wget https://github.com/prometheus/blackbox_exporter/releases/download/v${VERSION}/blackbox_exporter-${VERSION}.linux-amd64.tar.gz

# Extract and move binaries
tar xvf blackbox_exporter-${VERSION}.linux-amd64.tar.gz
sudo mv blackbox_exporter-${VERSION}.linux-amd64/blackbox_exporter /usr/local/bin/

# Set permissions
sudo chown blackbox_exporter:blackbox_exporter /usr/local/bin/blackbox_exporter


# 2. Create a systemd Service
sudo tee /etc/systemd/system/blackbox_exporter.service <<EOF
[Unit]
Description=Prometheus Blackbox Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=blackbox_exporter
Group=blackbox_exporter
Type=simple
ExecStart=/usr/local/bin/blackbox_exporter --config.file=/etc/blackbox_exporter.yml

[Install]
WantedBy=multi-user.target
EOF


# 3. Start and Enable Blackbox Exporter
sudo systemctl daemon-reload
sudo systemctl enable blackbox_exporter
sudo systemctl start blackbox_exporter


# 4. Verify that Blackbox Exporter is Running
sudo systemctl status blackbox_exporter


# 5. Check What Port Blackbox Exporter is Running On
# sudo netstat -tulnp | grep blackbox_exporter  # or
# sudo ss -tulnp | grep blackbox_exporter

# Blackbox Exporter runs on port 9115 by default. Access it via:
# http://<your-server-ip>:9115


# 6. (Optional) Open Port 9115 in Firewall
# For UFW (Ubuntu/Debian)
sudo ufw allow 9115/tcp

# For Firewalld (RHEL/CentOS)
# sudo firewall-cmd --add-port=9115/tcp --permanent
# sudo firewall-cmd --reload
