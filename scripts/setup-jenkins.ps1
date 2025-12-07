# =====================================================
# SETUP JENKINS WITH DOCKER SUPPORT
# One-time setup script for Jenkins
# =====================================================

Write-Host "🔧 Setting up Jenkins with Docker support" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

$jenkinsDockerPath = "C:\jenkins-docker"

# 1. Create folder
Write-Host "`n📁 Creating Jenkins Docker folder..." -ForegroundColor Yellow
if (!(Test-Path $jenkinsDockerPath)) {
    New-Item -ItemType Directory -Path $jenkinsDockerPath -Force | Out-Null
}

# 2. Create Dockerfile
Write-Host "📝 Creating Dockerfile..." -ForegroundColor Yellow
$dockerfile = @"
FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

# Give jenkins user docker permissions
RUN usermod -aG docker jenkins

USER jenkins
"@

$dockerfile | Out-File -FilePath "$jenkinsDockerPath\Dockerfile" -Encoding ASCII

# 3. Build image
Write-Host "`n🔨 Building Jenkins image..." -ForegroundColor Yellow
Set-Location $jenkinsDockerPath
docker build -t my-jenkins:latest .

# 4. Remove old container if exists
Write-Host "`n🧹 Removing old Jenkins container..." -ForegroundColor Yellow
docker stop jenkins 2>$null
docker rm jenkins 2>$null

# 5. Start new container
Write-Host "`n🚀 Starting Jenkins container..." -ForegroundColor Yellow
docker run -d --name jenkins `
    -p 9090:8080 -p 50000:50000 `
    -v jenkins_home:/var/jenkins_home `
    -v //var/run/docker.sock:/var/run/docker.sock `
    my-jenkins:latest

Write-Host "`n⏳ Waiting for Jenkins to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# 6. Show initial password
Write-Host "`n🔑 Jenkins Initial Admin Password:" -ForegroundColor Cyan
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword 2>$null

Write-Host "`n✅ Jenkins setup complete!" -ForegroundColor Green
Write-Host "   Access Jenkins at: http://localhost:9090" -ForegroundColor White
Write-Host "   Use the password above for initial setup." -ForegroundColor White

