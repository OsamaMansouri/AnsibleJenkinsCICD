pipeline {
    agent any
    
    environment {
        APP_NAME = 'my-first-app'
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
        stage('🐍 Python - Install Dependencies') {
            steps {
                echo '=== Installing Python dependencies ==='
                dir('python') {
                    bat 'pip install -r requirements.txt'
                }
            }
        }
        
        stage('🐍 Python - Test') {
            steps {
                echo '=== Running Python tests ==='
                dir('python') {
                    bat 'python test_app.py'
                }
            }
        }
        
        // ==================== JAVA PIPELINE ====================
        stage('☕ Java - Build & Test') {
            steps {
                echo '=== Building and Testing Java application ==='
                dir('java') {
                    bat 'mvn clean test'
                }
            }
        }
        
        stage('☕ Java - Package') {
            steps {
                echo '=== Packaging Java application ==='
                dir('java') {
                    bat 'mvn package -DskipTests'
                }
            }
        }
        
        // ==================== DEPLOY ====================
        stage('🚀 Deploy') {
            steps {
                echo "=== Deploying to ${DEPLOY_ENV} ==="
                bat "echo Deployed ${APP_NAME} v${VERSION} to ${DEPLOY_ENV}!"
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed! Check test results above.'
        }
        always {
            echo "Build URL: ${env.BUILD_URL}"
        }
    }
}
