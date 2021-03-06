# Use the official lightweight python image
FROM python:3.9-slim

# Allow statement and logs to appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies
RUN pip install Flask gunicorn

# Run the web service on container startup using gunicorn
# webserver, with one worker process and 8 threads
# For environments with multiple CPUs, increase the number of workers
# to be equal to the number of cores available
# Timeout is set to 0 to disable the timeouts of the workers
# to allow Cloud Run to handle instance scaling
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
