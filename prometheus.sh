# 1. Download and Install Prometheus
# Create a new user for Prometheus
sudo useradd --no-create-home --shell /bin/false prometheus

# Download the latest Prometheus release
VERSION="2.50.1"  # Check https://github.com/prometheus/prometheus/releases for latest version
wget https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz

# Extract and move binaries
tar xvf prometheus-${VERSION}.linux-amd64.tar.gz
sudo mv prometheus-${VERSION}.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-${VERSION}.linux-amd64/promtool /usr/local/bin/

# Create Prometheus directories
sudo mkdir -p /etc/prometheus /var/lib/prometheus
sudo mv prometheus-${VERSION}.linux-amd64/consoles /etc/prometheus/
sudo mv prometheus-${VERSION}.linux-amd64/console_libraries /etc/prometheus/
sudo mv prometheus-${VERSION}.linux-amd64/prometheus.yml /etc/prometheus/

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool


# 2. Create a systemd Service
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Monitoring System
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
EOF


# 3. Start and Enable Prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# 4. Verify that Prometheus is Running
sudo systemctl status prometheus


# http://<your-server-ip>:9090
