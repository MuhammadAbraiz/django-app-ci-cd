# My Daily Routine - Notes App

A full-stack notes application built with React frontend and Django backend, featuring automated CI/CD deployment with Jenkins and Docker.

## 🚀 Features

- **React Frontend**: Modern, responsive UI for managing daily routine notes
- **Django REST API**: Robust backend with MySQL database
- **Docker Containerization**: Multi-service deployment with Docker Compose
- **Jenkins CI/CD**: Automated build, test, and deployment pipeline
- **Cross-Platform**: Supports both Windows and Linux deployment

## 🛠 Tech Stack

- **Frontend**: React 18, React Router, CSS3
- **Backend**: Django 4.1, Django REST Framework
- **Database**: MySQL 8.0
- **Web Server**: Nginx (reverse proxy)
- **Containerization**: Docker, Docker Compose
- **CI/CD**: Jenkins
- **Languages**: Python 3.9, JavaScript (ES6+), Node.js 18

## 📋 Prerequisites

### For Local Development
- Python 3.9+
- Node.js 18+
- Docker & Docker Compose
- Git

### For Jenkins CI/CD
- Jenkins server (Windows or Linux)
- Docker installed on Jenkins agent
- Git plugin for Jenkins
- Access to GitHub repository

## 🚀 Quick Start

### Method 1: Docker Compose (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/MuhammadAbraiz/django-app-ci-cd.git
   cd django-app-ci-cd
   ```

2. **Start the application**
   ```bash
   docker-compose up -d --build
   ```

3. **Access the application**
   - Frontend: http://localhost
   - Backend API: http://localhost:8000

### Method 2: Manual Docker Build

1. **Build the Docker image**
   ```bash
   docker build -t notes-app:latest .
   ```

2. **Run with Docker Compose**
   ```bash
   docker-compose up -d
   ```

## 🔧 Jenkins CI/CD Setup

### Windows Jenkins Agent

1. **Install Prerequisites**
   - Docker Desktop for Windows
   - Git for Windows
   - PowerShell 5.1+

2. **Create Jenkins Pipeline**
   - Create new Pipeline job in Jenkins
   - Configure SCM: `https://github.com/MuhammadAbraiz/django-app-ci-cd.git`
   - Branch: `main`
   - Script Path: `Jenkinsfile`

3. **Pipeline Stages**
   - **Code**: Clone repository from GitHub
   - **Build**: Build Docker image with React frontend and Django backend
   - **Test**: Run application tests (placeholder for future tests)
   - **Deploy**: Deploy using Docker Compose with automatic container management

### Linux/EC2 Jenkins Agent

1. **Install Prerequisites**
   ```bash
   # Update system
   sudo apt-get update
   
   # Install Docker
   sudo apt-get install -y docker.io docker-compose
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -aG docker jenkins
   
   # Install Git
   sudo apt-get install -y git
   ```

2. **Configure Jenkins Agent**
   ```bash
   # Add Jenkins user to docker group
   sudo usermod -aG docker jenkins
   
   # Restart Jenkins service
   sudo systemctl restart jenkins
   ```

3. **Update Jenkinsfile for Linux**
   - Replace `bat` commands with `sh` commands
   - Update Docker Compose commands:
     ```groovy
     sh 'docker-compose down'
     sh 'docker-compose up -d --build'
     ```

## 🐳 Docker Services

### Services Overview
- **nginx**: Reverse proxy server (Port 80)
- **django_app**: Django backend application (Port 8000)
- **db**: MySQL database (Port 3306)

### Environment Variables
- `MYSQL_DATABASE=notesdb`
- `MYSQL_USER=notesuser`
- `MYSQL_PASSWORD=password`
- `MYSQL_ROOT_PASSWORD=rootpassword`

## 🔍 Troubleshooting

### Common Issues

1. **Port Conflicts**
   ```bash
   # Stop conflicting containers
   docker stop $(docker ps -q --filter "publish=80" --filter "publish=8000" --filter "publish=3306")
   ```

2. **Permission Issues (Linux)**
   ```bash
   # Fix Docker permissions
   sudo chown -R $USER:$USER .
   sudo chmod +x entrypoint.sh
   ```

3. **MySQL Data Persistence**
   - Uses Docker named volume `mysql-data`
   - Data persists across container restarts

4. **React Build Issues**
   - Ensure Node.js 18+ is installed in Docker image
   - Check for syntax errors in React components
   - Verify all dependencies in package.json

### Logs and Debugging

```bash
# View container logs
docker-compose logs -f [service_name]

# Check container status
docker-compose ps

# Access container shell
docker-compose exec django_app bash
```

## 🌐 Production Deployment

### AWS EC2 Deployment

1. **Launch EC2 Instance**
   - Ubuntu 20.04 LTS or newer
   - t2.medium or larger (for Jenkins + Docker)
   - Security Groups: Allow ports 22, 80, 8080 (Jenkins)

2. **Install Dependencies**
   ```bash
   # Install Docker
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker ubuntu
   
   # Install Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   
   # Install Jenkins
   wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
   sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
   sudo apt-get update
   sudo apt-get install -y jenkins
   ```

3. **Configure Security**
   - Set up SSL/TLS certificates
   - Configure firewall rules
   - Use environment variables for sensitive data

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License.

## 🆘 Support

For issues and questions:
- Create an issue on GitHub
- Check the troubleshooting section
- Review Jenkins build logs

---

**Note**: This application has been successfully tested on both Windows and Linux environments with Jenkins CI/CD pipeline.
