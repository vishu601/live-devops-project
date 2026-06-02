FROM python:3.10-slim

ENV PYTHOFROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Production ke liye sahi settings module variable initialize kar rahe hain
ENV DJANGO_SETTINGS_MODULE=config.settings.production
ENV DJANGO_SECRET_KEY=dummy_secret_key_for_build_only

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements/ /app/requirements/
COPY requirements.txt /app/

RUN pip install --no-cache-dir --default-timeout=1000 -r requirements.txt

COPY . /app/

RUN pip install gunicorn

# FIX: bootcamp ki jagah config.wsgi use karo
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
