pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'notes-app:latest'
    }

    stages {

        stage('Code') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/MuhammadAbraiz/django-app-ci-cd.git', branch: 'main'
                echo 'Code cloned.'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image (no cache)...'
                sh 'docker build --no-cache -t $DOCKER_IMAGE .'
                echo 'Build complete.'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Uncomment below if tests are added
                // sh 'docker run --rm $DOCKER_IMAGE python manage.py test'
                echo 'Testing complete.'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Stopping and removing any existing containers...'
                sh 'docker compose down'

                echo 'Deploying fresh containers...'
                sh 'docker compose up -d --build'

                echo 'Deployment done.'
            }
        }
    }
}
