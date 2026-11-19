
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'spring-app:1.0'
        K8S_DEPLOYMENT = 'spring-app'
    }

    stages {

        stage('Check Environment') {
            steps {
                echo 'Checking environment...'

                bat 'whoami'
                bat 'echo USERPROFILE=%USERPROFILE%'
                bat 'where minikube'
                bat 'minikube profile list'

                bat 'java -version'
                bat 'docker --version'
                bat 'kubectl version --client'
                bat 'minikube status'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Java application...'

                bat '.\\gradlew.bat clean build'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'

                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                echo 'Loading Docker image into Minikube...'

                bat 'minikube image load %IMAGE_NAME%'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying application...'

                bat 'kubectl apply -f k8s.yaml'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Checking deployment status...'

                bat 'kubectl rollout status deployment/%K8S_DEPLOYMENT% --timeout=120s'

                bat 'kubectl get pods'
                bat 'kubectl get services'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed! Check Jenkins console output.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}

