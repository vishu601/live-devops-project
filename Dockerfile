FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# System dependencies install karo (Postgres aur images ke liye)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --no-cache-dir --default-timeout=1000 -r requirements.txt

COPY . /app/

# Gunicorn install kar rahe hain production server ke liye
RUN pip install gunicorn
