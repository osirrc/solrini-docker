FROM openjdk:8-alpine

# Install bash
RUN apk add bash git jq maven python3

# Copy scripts into place
COPY index /
COPY init /
COPY interact /
COPY search /

EXPOSE 8983

# Set working directory
WORKDIR /work