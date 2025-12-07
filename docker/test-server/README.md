# 🐳 Docker Test Servers for Ansible

This folder contains Docker configuration to create "fake servers" for testing Ansible locally.

## 🚀 Quick Start

### 1. Build and Start the Servers

```powershell
cd C:\xampp\htdocs\jenkins\AnsibleJenkinsCICD\docker\test-server
docker-compose up -d --build
```

### 2. Verify Servers are Running

```powershell
docker ps
```

You should see 3 containers:
- `ansible-dev-server` (port 2221)
- `ansible-staging-server` (port 2222)
- `ansible-prod-server` (port 2223)

### 3. Test SSH Connection

```powershell
# Test dev server
ssh -p 2221 ubuntu@localhost
# Password: ansible123
```

### 4. Test Ansible Connection

```powershell
# Using Docker ansible image
docker run --rm -v ${PWD}/../../ansible:/ansible --network host willhallonline/ansible:latest ansible -i /ansible/inventory/hosts.ini all -m ping
```

## 📋 Server Details

| Server | Container Name | SSH Port | User | Password |
|--------|---------------|----------|------|----------|
| Dev | ansible-dev-server | 2221 | ubuntu | ansible123 |
| Staging | ansible-staging-server | 2222 | ubuntu | ansible123 |
| Prod | ansible-prod-server | 2223 | ubuntu | ansible123 |

## 🛑 Stop Servers

```powershell
docker-compose down
```

## 🗑️ Remove Everything

```powershell
docker-compose down -v --rmi all
```

