FROM python:3.11-slim

WORKDIR /app

# Create a non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy requirements with correct ownership
COPY --chown=appuser:appuser app/requirements.txt .

# Temporarily switch to root to install dependencies
USER root
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code with correct ownership
COPY --chown=appuser:appuser app/ .

# Switch to non-root user
USER appuser

# Ensure __init__.py exists
RUN touch /app/__init__.py

# Run tests
RUN pytest || (echo "Tests failed!" && exit 1)

EXPOSE 5000

CMD ["python", "main.py"]

