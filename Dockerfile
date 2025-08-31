FROM python:3.11-slim

WORKDIR /app

COPY --chown=appuser:appuser app/requirements.txt .

# Temporarily switch to root to install dependencies
USER root
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser app/ .

# Switch back to non-root user
USER appuser

RUN touch /app/__init__.py

# Run tests
RUN pytest || (echo "Tests failed!" && exit 1)

EXPOSE 5000

CMD ["python", "main.py"]

