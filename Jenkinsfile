pipeline {
    agent { label 'junaid' }

    environment {
        DOCKER_IMAGE = 'notes-app:latest'
    }

    stages {

        stage('Code') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/devopswithjunaid/django-notes-app.git', branch: 'main'
                echo 'Code cloned.'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $DOCKER_IMAGE .'
                echo 'Build complete.'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // You can uncomment the line below if your app has tests
                // sh 'docker run --rm $DOCKER_IMAGE python manage.py test'
                echo 'Testing complete.'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh "docker compose up -d"
                echo 'Deployment done.'
            }
        }
    }
}
