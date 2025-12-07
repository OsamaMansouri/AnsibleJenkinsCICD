# 📚 Setup Guide

Complete setup guide for the AnsibleJenkinsCICD project.

## Prerequisites

### Required Software

- **Docker Desktop** - [Download](https://www.docker.com/products/docker-desktop)
- **Git** - [Download](https://git-scm.com/downloads)
- **ngrok** - [Download](https://ngrok.com/download)

### Optional

- **Visual Studio Code** or any IDE
- **PowerShell** (Windows) or **Terminal** (Mac/Linux)

## Step 1: Clone the Repository

```bash
git clone https://github.com/OsamaMansouri/AnsibleJenkinsCICD.git
cd AnsibleJenkinsCICD
```

## Step 2: Build Custom Jenkins Image

```bash
# Create Jenkins Docker folder
mkdir C:\jenkins-docker
cd C:\jenkins-docker

# Create Dockerfile (see scripts/setup-jenkins.ps1)
# Build the image
docker build -t my-jenkins:latest .
```

## Step 3: Start Jenkins

```bash
docker run -d --name jenkins \
  -p 9090:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v //var/run/docker.sock:/var/run/docker.sock \
  my-jenkins:latest
```

## Step 4: Start Test Servers

```bash
cd AnsibleJenkinsCICD/docker/test-server
docker-compose up -d
```

## Step 5: Connect Networks

```bash
docker network connect test-server_ansible-network jenkins
```

## Step 6: Setup ngrok

```bash
# Start ngrok tunnel to Jenkins
ngrok http 9090
```

## Step 7: Configure GitHub Webhook

1. Go to your GitHub repo → Settings → Webhooks
2. Click "Add webhook"
3. Payload URL: `https://YOUR-NGROK-URL/github-webhook/`
4. Content type: `application/json`
5. Events: "Just the push event"
6. Click "Add webhook"

## Step 8: Create Jenkins Job

1. Open Jenkins: http://localhost:9090
2. New Item → "AnsibleJenkinsCICD" → Pipeline
3. Build Triggers: ✅ GitHub hook trigger for GITScm polling
4. Pipeline: Pipeline script from SCM
5. SCM: Git
6. Repository URL: Your GitHub repo URL
7. Branch: \*/main
8. Script Path: Jenkinsfile
9. Save

## Step 9: Test!

```bash
git add .
git commit -m "Test CI/CD"
git push
```

Watch Jenkins automatically build and deploy!

## Troubleshooting

### Jenkins not starting?

```bash
docker logs jenkins
```

### Webhook not working?

- Check ngrok is running
- Verify webhook URL ends with `/github-webhook/`
- Check GitHub webhook recent deliveries

### Ansible can't reach servers?

```bash
# Make sure test servers are running
docker ps | grep ansible

# Make sure Jenkins is on the network
docker network connect test-server_ansible-network jenkins
```
