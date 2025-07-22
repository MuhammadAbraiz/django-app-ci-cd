FROM python:3.9-slim

WORKDIR /app/backend

# Install system dependencies including Node.js
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev pkg-config netcat-openbsd curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Build React frontend
WORKDIR /app/backend/mynotes
RUN npm install && npm run build

# Go back to backend directory
WORKDIR /app/backend

# Ensure entrypoint script has Unix line endings and is executable
RUN sed -i 's/\r$//' entrypoint.sh && chmod +x entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/app/backend/entrypoint.sh"]