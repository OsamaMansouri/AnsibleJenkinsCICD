# 🚀 AnsibleJenkinsCICD

A complete CI/CD pipeline demonstrating Jenkins, Ansible, Docker, and multi-language application deployment.

## 📋 Overview

This project showcases a production-ready CI/CD pipeline that:

- ✅ Automatically triggers on Git push (via GitHub Webhook)
- ✅ Runs Python tests
- ✅ Builds and tests Java applications
- ✅ Deploys to multiple servers using Ansible

## 🏗️ Architecture

```
git push → GitHub → Webhook → Cloudflare Tunnel → Jenkins
                                                      │
                                                      ├── 🐍 Python Tests (Docker)
                                                      ├── ☕ Java Build & Test (Docker)
                                                      └── 🔧 Ansible Deployment (Docker)
                                                              │
                                                              ├── dev-server (:2221)
                                                              ├── staging-server (:2222)
                                                              └── prod-server (:2223)
```

**Permanent Webhook URL:** `https://jenkins-osama.osamansouri.me/github-webhook/`

## 📁 Project Structure

```
AnsibleJenkinsCICD/
├── ansible/                 # Ansible automation
│   ├── ansible.cfg         # Ansible configuration
│   ├── inventory/          # Server inventories
│   ├── playbooks/          # Deployment playbooks
│   ├── group_vars/         # Variables per environment
│   ├── templates/          # Jinja2 templates
│   └── roles/              # Reusable Ansible roles
├── docker/                  # Docker configurations
│   └── test-server/        # Test server containers
├── java/                    # Java application
│   ├── pom.xml
│   └── src/
├── python/                  # Python application
│   ├── app.py
│   ├── requirements.txt
│   └── test_app.py
├── docs/                    # Documentation
├── scripts/                 # Helper scripts
├── Jenkinsfile             # CI/CD Pipeline definition
└── README.md               # This file
```

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Git
- Cloudflare Tunnel (for webhook) - [Setup Guide](docs/SETUP.md#cloudflare-tunnel)

### 1. Clone the Repository

```bash
git clone https://github.com/OsamaMansouri/AnsibleJenkinsCICD.git
cd AnsibleJenkinsCICD
```

### 2. Start Test Servers

```bash
cd docker/test-server
docker-compose up -d
```

### 3. Start Jenkins

```bash
docker run -d --name jenkins \
  -p 9090:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v //var/run/docker.sock:/var/run/docker.sock \
  my-jenkins:latest
```

### 4. Start Cloudflare Tunnel (for webhook)

```powershell
# Download cloudflared (one time)
Invoke-WebRequest -Uri "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe" -OutFile "cloudflared.exe"

# Login to Cloudflare (one time)
.\cloudflared.exe tunnel login

# Create tunnel (one time)
.\cloudflared.exe tunnel create jenkins

# Run tunnel
.\cloudflared.exe tunnel --url http://localhost:9090 run jenkins

# Route to your domain
.\cloudflared.exe tunnel route dns jenkins jenkins-subdomain
```

### 5. Configure GitHub Webhook

- Go to your GitHub repo → Settings → Webhooks
- Add webhook URL: `https://jenkins-osama.osamansouri.me/github-webhook/`

### 6. Push and Watch!

```bash
git add .
git commit -m "Test deployment"
git push
```

## 🔧 Manual Ansible Commands

### Test Connection

```bash
docker run --rm --network test-server_ansible-network \
  -v ${PWD}/ansible:/ansible -w /ansible \
  willhallonline/ansible:latest \
  ansible -i inventory/hosts.ini all -m ping
```

### Deploy Application

```bash
docker run --rm --network test-server_ansible-network \
  -v ${PWD}:/app -w /app/ansible \
  willhallonline/ansible:latest \
  ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml
```

## 📚 Documentation

- [Setup Guide](docs/SETUP.md)
- [Ansible Guide](docs/ANSIBLE.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## 🛠️ Technologies Used

| Technology        | Purpose                               |
| ----------------- | ------------------------------------- |
| Jenkins           | CI/CD Orchestration                   |
| Ansible           | Configuration Management & Deployment |
| Docker            | Containerization                      |
| GitHub            | Version Control & Webhooks            |
| Python            | Application & Testing                 |
| Java/Maven        | Application & Build                   |
| Cloudflare Tunnel | Permanent URL for webhooks            |

## 📝 License

MIT License - Feel free to use this for learning!

## 👤 Author

**Osama Mansouri**

- GitHub: [@OsamaMansouri](https://github.com/OsamaMansouri)
