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
git push → GitHub → Webhook → Jenkins
                                 │
                                 ├── 🐍 Python Tests
                                 ├── ☕ Java Build & Test
                                 └── 🔧 Ansible Deployment
                                         │
                                         ├── dev-server
                                         ├── staging-server
                                         └── prod-server
```

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
- ngrok (for webhook)

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

### 4. Start ngrok (for webhook)

```bash
ngrok http 9090
```

### 5. Configure GitHub Webhook

- Go to your GitHub repo → Settings → Webhooks
- Add webhook URL: `https://YOUR-NGROK-URL/github-webhook/`

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

| Technology | Purpose                               |
| ---------- | ------------------------------------- |
| Jenkins    | CI/CD Orchestration                   |
| Ansible    | Configuration Management & Deployment |
| Docker     | Containerization                      |
| GitHub     | Version Control & Webhooks            |
| Python     | Application & Testing                 |
| Java/Maven | Application & Build                   |
| ngrok      | Local tunnel for webhooks             |

## 📝 License

MIT License - Feel free to use this for learning!

## 👤 Author

**Osama Mansouri**

- GitHub: [@OsamaMansouri](https://github.com/OsamaMansouri)
