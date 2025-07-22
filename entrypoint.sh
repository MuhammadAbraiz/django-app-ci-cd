#!/bin/sh

# Wait for the database to be ready
while ! nc -z db_cont 3306; do
  echo "Waiting for the MySQL database..."
  sleep 1
done

echo "MySQL started"

# Run database migrations
python manage.py migrate --noinput

# Start the Gunicorn server
exec gunicorn notesapp.wsgi --bind 0.0.0.0:8000
