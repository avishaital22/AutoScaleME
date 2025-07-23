FROM python:3.11-slim

WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

RUN groupadd -r appuser && useradd -r -g appuser appuser

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

CMD ["python", "main.py"]

