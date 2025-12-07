pipeline {
    agent any
    
    environment {
        APP_NAME = 'AnsibleJenkinsCICD'
        VERSION = '1.0.0'
        DEPLOY_ENV = 'staging'
    }
    
    stages {
        stage('📥 Checkout') {
            steps {
                echo '=== Pulling code from GitHub ==='
                echo "Build Number: ${env.BUILD_NUMBER}"
                echo "Workspace: ${env.WORKSPACE}"
            }
        }
        
        // ==================== PYTHON PIPELINE ====================
        stage('🐍 Python - Install & Test') {
            agent {
                docker { 
                    image 'python:3.9-slim'
                    args '-u root'
                }
            }
            steps {
                echo '=== Installing Python dependencies ==='
                dir('python') {
                    sh 'pip install -r requirements.txt'
                    sh 'python test_app.py'
                }
            }
        }
        
        // ==================== JAVA PIPELINE ====================
        stage('☕ Java - Build & Test') {
            agent {
                docker { 
                    image 'maven:3.8-openjdk-11'
                    args '-u root'
                }
            }
            steps {
                echo '=== Building and Testing Java application ==='
                dir('java') {
                    sh 'mvn clean test'
                    sh 'mvn package -DskipTests'
                }
            }
        }
        
        // ==================== ANSIBLE DEPLOYMENT ====================
        stage('🔧 Ansible - Deploy to Servers') {
            agent {
                docker { 
                    image 'willhallonline/ansible:latest'
                    args '-u root --network test-server_ansible-network'
                }
            }
            steps {
                echo "=== Deploying with Ansible to ${DEPLOY_ENV} ==="
                
                // Show Ansible version
                sh 'ansible --version'
                
                // Test connection to all servers
                echo '=== Testing Server Connections ==='
                sh '''
                    cd ansible
                    ansible -i inventory/hosts.ini all -m ping || echo "Some servers may not be reachable"
                '''
                
                // Run deployment playbook
                echo '=== Running Deployment Playbook ==='
                sh '''
                    cd ansible
                    ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml
                '''
                
                echo "✅ Ansible deployment completed for ${APP_NAME} v${VERSION}"
            }
        }
        
        // ==================== FINAL STATUS ====================
        stage('🚀 Deploy Complete') {
            steps {
                echo "=== Deployment Summary ==="
                sh """
                    echo '======================================'
                    echo '🎉 CI/CD PIPELINE COMPLETE!'
                    echo '======================================'
                    echo 'App Name: ${APP_NAME}'
                    echo 'Version: ${VERSION}'
                    echo 'Environment: ${DEPLOY_ENV}'
                    echo 'Build: ${BUILD_NUMBER}'
                    echo '======================================'
                """
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed! Check logs above.'
        }
        always {
            echo "Build URL: ${env.BUILD_URL}"
        }
    }
}
