FROM python:3.11-slim

WORKDIR /app

# Copy requirements with correct ownership
COPY --chown=appuser:appuser app/requirements.txt .

# Install dependencies as root 
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code with correct ownership
COPY --chown=appuser:appuser app/ .

# Switch back to non-root user
USER appuser

# Ensure __init__.py exists
RUN touch /app/__init__.py

# Run tests
RUN pytest || (echo "Tests failed!" && exit 1)

EXPOSE 5000

CMD ["python", "main.py"]

