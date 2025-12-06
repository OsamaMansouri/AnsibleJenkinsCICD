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
        stage('🐍 Python - Install Dependencies') {
            steps {
                echo '=== Installing Python dependencies ==='
                dir('python') {
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        
        stage('🐍 Python - Test') {
            steps {
                echo '=== Running Python tests ==='
                dir('python') {
                    sh 'python test_app.py'
                }
            }
        }
        
        // ==================== JAVA PIPELINE ====================
        stage('☕ Java - Build & Test') {
            steps {
                echo '=== Building and Testing Java application ==='
                dir('java') {
                    sh 'mvn clean test'
                }
            }
        }
        
        stage('☕ Java - Package') {
            steps {
                echo '=== Packaging Java application ==='
                dir('java') {
                    sh 'mvn package -DskipTests'
                }
            }
        }
        
        // ==================== DEPLOY ====================
        stage('🚀 Deploy') {
            steps {
                echo "=== Deploying to ${DEPLOY_ENV} ==="
                sh "echo Deployed ${APP_NAME} v${VERSION} to ${DEPLOY_ENV}!"
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
