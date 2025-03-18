# 1. Add Grafana Repository and Install Grafana
sudo apt update && sudo apt install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt update && sudo apt install -y grafana

# For RHEL/CentOS
# sudo yum install -y https://dl.grafana.com/oss/release/grafana-9.6.1-1.x86_64.rpm


# 2. Enable and Start Grafana Service
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server


# 3. Verify that Grafana is Running
sudo systemctl status grafana-server


# 4. Check What Port Grafana is Running On
# sudo netstat -tulnp | grep grafana  # or
# sudo ss -tulnp | grep grafana

# Grafana runs on port 3000 by default. Access it via:
# http://<your-server-ip>:3000


# 5. (Optional) Open Port 3000 in Firewall
# For UFW (Ubuntu/Debian)
sudo ufw allow 3000/tcp

# For Firewalld (RHEL/CentOS)
# sudo firewall-cmd --add-port=3000/tcp --permanent
# sudo firewall-cmd --reload
