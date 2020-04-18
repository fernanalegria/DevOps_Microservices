FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY . app.py /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

## Step 4:
# Expose port 8000
EXPOSE 8000

## Step 5:
# Run app.py at container launch
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8000", "--worker-tmp-dir", \
    "/dev/shm", "--workers=2", "--threads=4", "--worker-class=gthread", \
    "--log-file=-", "--access-logfile=-", "--log-level=info"]
