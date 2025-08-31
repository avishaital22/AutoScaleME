# Dockerfile
FROM python:3.11-slim

RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app
RUN mkdir -p /app && chown -R appuser:appuser /app

USER appuser

COPY --chown=appuser:appuser app/requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

COPY --chown=appuser:appuser app/ .

EXPOSE 5000

CMD ["python", "main.py"]

