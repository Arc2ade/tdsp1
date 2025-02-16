# Use the official lightweight Python image
FROM python:3.12-slim-bookworm

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Install `uv` using pipx (cleaner than using a script)
RUN pip install --no-cache-dir pipx && pipx install uv

# Set up the application directory
WORKDIR /app

# Copy application files
COPY app.py /app

# Run FastAPI app with `uv`
CMD ["uv", "run", "app.py"]
