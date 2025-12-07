# =====================================================
# START ALL SERVICES
# PowerShell script to start the complete CI/CD environment
# =====================================================

Write-Host "🚀 Starting AnsibleJenkinsCICD Environment" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

# 1. Start Test Servers
Write-Host "`n📦 Starting test servers..." -ForegroundColor Yellow
Set-Location -Path "$PSScriptRoot\..\docker\test-server"
docker-compose up -d

# 2. Start Jenkins (if not running)
Write-Host "`n🔧 Checking Jenkins..." -ForegroundColor Yellow
$jenkinsRunning = docker ps --filter "name=jenkins" --format "{{.Names}}"
if ($jenkinsRunning -eq "jenkins") {
    Write-Host "   Jenkins is already running ✅" -ForegroundColor Green
} else {
    Write-Host "   Starting Jenkins..." -ForegroundColor Yellow
    docker start jenkins 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "   Jenkins container not found. Please create it first." -ForegroundColor Red
        Write-Host "   Run: docker run -d --name jenkins ..." -ForegroundColor Yellow
    } else {
        Write-Host "   Jenkins started ✅" -ForegroundColor Green
    }
}

# 3. Connect networks
Write-Host "`n🌐 Connecting networks..." -ForegroundColor Yellow
docker network connect test-server_ansible-network jenkins 2>$null
Write-Host "   Networks connected ✅" -ForegroundColor Green

# 4. Show status
Write-Host "`n📊 Current Status:" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | Select-String -Pattern "jenkins|ansible"

Write-Host "`n✅ Environment ready!" -ForegroundColor Green
Write-Host "   Jenkins: http://localhost:9090" -ForegroundColor White
Write-Host "   Don't forget to start ngrok: ngrok http 9090" -ForegroundColor Yellow

Set-Location -Path "$PSScriptRoot\.."

