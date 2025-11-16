# -----------------------------
# 1) Base Image
# -----------------------------
FROM python:3.7-slim

# Prevents Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# -----------------------------
# 2) Set Workdir
# -----------------------------
WORKDIR /app

# -----------------------------
# 3) Install system dependencies
# -----------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# 4) Install Python dependencies
# -----------------------------
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# -----------------------------
# 5) Copy project files
# -----------------------------
COPY . /app/

# -----------------------------
# 6) Expose port
# -----------------------------
EXPOSE 8000

# -----------------------------
# 7) Run the Django server
# -----------------------------
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
