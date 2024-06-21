# Use the NVIDIA CUDA base image
FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Set environment variables for NVIDIA drivers and CUDA
ENV NVIDIA_DRIVER_VERSION=545
ENV CUDA_VERSION=12.1.0
ENV DEBIAN_FRONTEND=noninteractive

# Install nvidia driver (replace 545 with the specific version you need)
RUN apt-get update
RUN apt-get install --yes --quiet --no-install-recommends nvidia-driver-545
RUN apt-get install --yes --quiet --no-install-recommends \
    software-properties-common \
    build-essential apt-utils \
    wget curl vim git ca-certificates kmod 
RUN rm -rf /var/lib/apt/lists/*

# Install python 3.10 and pip
RUN apt-get update
RUN apt-get install -y python3.10 pip

# Install Miniconda
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN ~/miniconda3/bin/conda init bash

# Set environment variables (optional, adjust as needed)
ENV PATH="/opt/miniconda3/bin:$PATH"
ENV PYTHONPATH="/opt/miniconda3/lib/python3.10/site-packages:$PYTHONPATH"

# Work directory
WORKDIR /home

