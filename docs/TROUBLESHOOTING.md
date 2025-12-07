# 🔍 Troubleshooting Guide

Common issues and solutions.

## Jenkins Issues

### Jenkins not starting
```bash
# Check logs
docker logs jenkins

# Check if port is in use
netstat -ano | findstr 9090

# Restart Jenkins
docker restart jenkins
```

### Build not triggering
1. Check ngrok is running
2. Verify webhook URL in GitHub
3. Check webhook recent deliveries in GitHub
4. Ensure "GitHub hook trigger for GITScm polling" is enabled

### Docker not working in Jenkins
```bash
# Verify Docker socket is mounted
docker exec jenkins docker --version

# If not working, restart with socket
docker stop jenkins && docker rm jenkins
docker run -d --name jenkins \
  -v //var/run/docker.sock:/var/run/docker.sock \
  ...
```

## Ansible Issues

### Connection refused
```bash
# Check if servers are running
docker ps | grep ansible

# Start servers if not running
cd docker/test-server && docker-compose up -d
```

### "localhost" not working
When running Ansible in Docker, use container names instead of localhost:
```ini
# Wrong
ansible_host=localhost ansible_port=2221

# Correct
ansible_host=ansible-dev-server ansible_port=22
```

### Permission denied
```bash
# Run with become (sudo)
ansible-playbook playbook.yml --become
```

### SSH key issues
```bash
# Add to inventory
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

## ngrok Issues

### "Already online" error
```bash
# Kill existing ngrok
taskkill /F /IM ngrok.exe

# Restart
ngrok http 9090
```

### URL changed
Every time ngrok restarts, the URL changes. Update GitHub webhook with new URL.

## Docker Issues

### Network not found
```bash
# Create network
docker network create test-server_ansible-network

# Connect containers
docker network connect test-server_ansible-network jenkins
```

### Container name conflict
```bash
# Remove existing container
docker rm -f jenkins

# Start new one
docker run -d --name jenkins ...
```

### Volume permission issues
```bash
# Run as root
docker run -u root ...
```

## GitHub Webhook Issues

### 404 Response
- Install "GitHub Integration Plugin" in Jenkins
- Configure GitHub Server in Jenkins System settings
- Restart Jenkins after installing plugin

### 502/503 Response
- Jenkins is not running or not accessible
- Check Docker container status

### Connection timeout
- ngrok is not running
- Firewall blocking connection

## Quick Fixes

### Reset Everything
```bash
# Stop all containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm $(docker ps -aq)

# Start fresh
cd docker/test-server && docker-compose up -d
docker start jenkins
ngrok http 9090
```

### Check All Services
```bash
# Jenkins running?
docker ps | grep jenkins

# Test servers running?
docker ps | grep ansible

# ngrok running?
# Check terminal for ngrok output

# Networks connected?
docker network inspect test-server_ansible-network
```

