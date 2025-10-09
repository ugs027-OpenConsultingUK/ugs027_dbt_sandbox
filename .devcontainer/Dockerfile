FROM python:3.9-slim

# Create a non-root user
RUN useradd -ms /bin/bash -u 1018 devuser

# Set up virtual environment variables
ENV VIRTUAL_ENV=/workspace/venv
ENV PATH="$VIRTUAL_ENV/bin:$HOME/.local/bin:$PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    jq \
    openssh-client \
    uuid-runtime \
 && rm -rf /var/lib/apt/lists/*

# Set working directory and file permissions
WORKDIR /workspace
RUN chown -R 1018:1018 /workspace

# Switch to non-root user
USER 1018

# Install dbt using requirements.txt
COPY --chown=devuser:devuser requirements.txt .
RUN pip install --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

# Optional: make sure dbt scripts are executable (if you have them)
RUN chmod +x /workspace/dbt-run-selection /workspace/dbt-build || true

# Add ~/.local/bin to PATH globally for the user
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc