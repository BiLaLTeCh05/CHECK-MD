TEST
# Multi-stage build ka istemal karke credentials ko secure rakhein

# Stage 1: Builder
FROM ubuntu:latest AS builder

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client

# SSH keys ko copy karein
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

# Permissions set karein
RUN chmod 600 /root/.ssh/id_rsa

# Known hosts configure karein
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Private repo clone karein
RUN git clone git@github.com:BilalTech05/BILAL-MD.git /app

# Stage 2: Final image
FROM ubuntu:latest

# App ko copy karein from builder stage
COPY --from=builder /app /app

# Working directory set karein
WORKDIR /app
