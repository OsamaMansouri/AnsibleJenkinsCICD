# =====================================================
# STOP ALL SERVICES
# PowerShell script to stop the CI/CD environment
# =====================================================

Write-Host "🛑 Stopping AnsibleJenkinsCICD Environment" -ForegroundColor Red
Write-Host "==========================================" -ForegroundColor Red

# 1. Stop Test Servers
Write-Host "`n📦 Stopping test servers..." -ForegroundColor Yellow
Set-Location -Path "$PSScriptRoot\..\docker\test-server"
docker-compose down

# 2. Stop Jenkins (optional - keep data)
Write-Host "`n🔧 Stopping Jenkins..." -ForegroundColor Yellow
docker stop jenkins 2>$null
Write-Host "   Jenkins stopped ✅" -ForegroundColor Green

Write-Host "`n✅ All services stopped!" -ForegroundColor Green
Write-Host "   Note: Jenkins data is preserved in the volume." -ForegroundColor White

Set-Location -Path "$PSScriptRoot\.."

