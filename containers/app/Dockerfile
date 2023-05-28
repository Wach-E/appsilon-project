# Set base image for application image
FROM python:3.8

# Author of Dockerfile
LABEL maintainer="Wachukwu Emmanuel"

# Working Directory of container image
WORKDIR /app

# Copy requirements file from pwd to container working directory
COPY ./requirements.txt /app/

# Install packages from requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip &&\
    pip3 install --no-cache-dir -r requirements.txt

# Copy source code from pwd to working directory
COPY ./ /app/

# Initialize db    
RUN python3 init_db.py

# Expose container port
EXPOSE 3000

# Set run command
CMD [ "python3", "app.py" ]
