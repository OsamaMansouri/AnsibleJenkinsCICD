# =====================================================
# TEST ANSIBLE CONNECTION
# PowerShell script to test Ansible connectivity
# =====================================================

param(
    [string]$Action = "ping"
)

Write-Host "🔧 Testing Ansible Connection" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green

Set-Location -Path "$PSScriptRoot\.."

switch ($Action) {
    "ping" {
        Write-Host "`n🏓 Pinging all servers..." -ForegroundColor Yellow
        docker run --rm --network test-server_ansible-network `
            -v "${PWD}/ansible:/ansible" -w /ansible `
            willhallonline/ansible:latest `
            ansible -i inventory/hosts.ini all -m ping
    }
    "info" {
        Write-Host "`n📊 Getting server info..." -ForegroundColor Yellow
        docker run --rm --network test-server_ansible-network `
            -v "${PWD}/ansible:/ansible" -w /ansible `
            willhallonline/ansible:latest `
            ansible-playbook -i inventory/hosts.ini playbooks/test-connection.yml
    }
    "deploy" {
        Write-Host "`n🚀 Running deployment..." -ForegroundColor Yellow
        docker run --rm --network test-server_ansible-network `
            -v "${PWD}:/app" -w /app/ansible `
            willhallonline/ansible:latest `
            ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml
    }
    default {
        Write-Host "Usage: .\test-ansible.ps1 [-Action <ping|info|deploy>]" -ForegroundColor Yellow
    }
}

Write-Host "`n✅ Done!" -ForegroundColor Green

