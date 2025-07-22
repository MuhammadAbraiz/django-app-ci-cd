FROM python:3.9-slim

WORKDIR /app/backend

# Install system dependencies
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev pkg-config netcat-openbsd

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Ensure entrypoint script has Unix line endings and is executable
RUN sed -i 's/\r$//' entrypoint.sh && chmod +x entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/app/backend/entrypoint.sh"]