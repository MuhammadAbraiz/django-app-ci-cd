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
                bat 'docker build --no-cache -t %DOCKER_IMAGE% .'
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
                echo 'Stopping containers (quiet) & cleaning previous deployment...'
                bat '''
@echo off
rem Iterate through critical ports and quietly stop any matching containers
for %%P in (8000 80 3306) do (
  for /f "tokens=1 delims= " %%I in ('docker ps --format "{{.ID}} {{.Ports}}" ^| findstr "%%P->"') do (
    echo Stopping container %%I bound to port %%P
    docker stop -t 5 %%I >nul
    docker rm   %%I >nul
  )
)
rem Bring entire stack down (ignore orphans) and continue
docker-compose down --remove-orphans
'''

                echo 'Deploying fresh containers...'
                bat 'docker-compose up -d --build'

                echo 'Deployment done.'
            }
        }
    }
}
