FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# System dependencies install karo
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Pura ka pura requirements folder aur main file dono copy karo
COPY requirements/ /app/requirements/
COPY requirements.txt /app/

RUN pip install --no-cache-dir --default-timeout=1000 -r requirements.txt

COPY . /app/

RUN pip install gunicorn
