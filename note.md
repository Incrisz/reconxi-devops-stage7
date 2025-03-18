Prometheus (for collecting and storing metrics)
Grafana (for visualization)
Node Exporter (for system metrics)
Blackbox Exporter (for monitoring uptime and SSL expiry)
Alertmanager (for handling alerts)

ls -l /home/ubuntu/devops/prometheus.yml

touch /home/ubuntu/devops/prometheus.yml
chmod 777 prometheus.yml 
chmod 777 alertmanager.yml 


sudo apt install net-tools
sudo netstat -tulnp