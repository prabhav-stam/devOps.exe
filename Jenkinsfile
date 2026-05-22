pipeline {
    agent any

    environment {
        // We will configure these credentials in Jenkins later
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        
        // Replace 'yourdockerhubusername' with your actual Docker Hub username later
        DOCKERHUB_USERNAME = 'prabhav018'
        
        BACKEND_IMAGE = "${DOCKERHUB_USERNAME}/cleanindia-backend:latest"
        FRONTEND_IMAGE = "${DOCKERHUB_USERNAME}/cleanindia-frontend:latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the Clean India repository...'
                // Jenkins automatically checks out your code if you connect it to GitHub
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                echo 'Building Backend Image...'
                sh 'docker build -t $BACKEND_IMAGE ./backend'
                
                echo 'Building Frontend Image...'
                sh 'docker build -t $FRONTEND_IMAGE ./frontend'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub...'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                
                echo 'Pushing Images...'
                sh 'docker push $BACKEND_IMAGE'
                sh 'docker push $FRONTEND_IMAGE'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo 'Deploying containers on Jenkins Server...'
                // Stop any running containers
                sh 'docker-compose down || true'
                // Pull the fresh images we just pushed
                sh 'docker-compose pull'
                // Start the new containers
                sh 'docker-compose up -d'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution finished.'
            // Clean up old images to save disk space on EC2
            sh 'docker system prune -f'
        }
    }
}
