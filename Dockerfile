# Dockerfile

# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy files
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /app

USER appuser

# Expose Flask port
EXPOSE 5000

# Run the app
CMD ["python", "main.py"]

