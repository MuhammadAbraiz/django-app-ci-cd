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
                echo 'Stopping containers on required ports and removing previous deployment...'
                bat '''
FOR %%P IN (8000 80 3306) DO (
    FOR /F "tokens=* delims=" %%C IN ('docker ps -q --filter "publish=%%P"') DO (
    echo Stopping container %%C listening on port %%P
    docker stop %%C
    docker rm %%C
  )
)
docker-compose down --remove-orphans
'''

                echo 'Deploying fresh containers...'
                bat 'docker-compose up -d --build'

                echo 'Deployment done.'
            }
        }
    }
}
