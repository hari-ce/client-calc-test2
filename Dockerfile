# Use the official ROCm PyTorch base image
FROM python:3.14-rc-slim-bookworm

# Set up environment variables for ROCm and PyTorch
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PATH="/opt/conda/bin:$PATH"

# Optional: Update and install additional tools or dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    git \
    wget \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# (Optional) Create a working directory
WORKDIR /workspace

# Install any additional Python dependencies you might need
RUN pip install --upgrade pip && \
    pip install numpy pandas matplotlib

# Optional: Add a non-root user to avoid running as root
RUN useradd -m -s /bin/bash docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker

# Set the default command to launch an interactive shell
ENTRYPOINT ["/bin/bash"]
