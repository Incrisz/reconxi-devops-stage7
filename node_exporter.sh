# 1. Download and Install Node Exporter
# Create a new user for Node Exporter
sudo useradd -rs /bin/false node_exporter

# Download the latest Node Exporter release
VERSION="1.8.1"  # Check https://prometheus.io/download/#node_exporter for latest version
wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz

# Extract and move binaries
tar xvf node_exporter-${VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${VERSION}.linux-amd64/node_exporter /usr/local/bin/

# Set permissions
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter


# 2. Create a systemd Service
sudo tee /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF


# 3. Start and Enable Node Exporter

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# 4. Verify that Node Exporter is Running

sudo systemctl status node_exporter
