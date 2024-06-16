# Use continuumio/miniconda3 as the base image
FROM continuumio/miniconda3

LABEL maintainer="khiron <https://github.com/khiron>"

# Install required packages
RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        git \
        zsh \
        wget \
        curl \
        sudo \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up a non-root user with sudo access
RUN useradd -m user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user
USER user
WORKDIR /home/user 

# Set up zsh as the default shell
SHELL ["/bin/zsh", "-c"]

# Install Oh My Zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Install zsh autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh syntax highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configure zsh
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Create a new conda environment with Python 3.12
RUN source /opt/conda/etc/profile.d/conda.sh && \
    /opt/conda/bin/conda create -n c312 python=3.12 -y && \
    conda activate c312

# Initialize conda for zsh shell
RUN echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "conda activate c312" >> ~/.zshrc

# Clone the repositories using SSH
WORKDIR /home/user/repos
RUN git clone --branch develop https://github.com/cogent3/cogent3.git /home/user/repos/cogent3 && \
    git clone --branch master https://github.com/cogent3/EnsemblLite.git /home/user/repos/EnsemblLite

# Install flit in the conda environment
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    conda install -c conda-forge flit -y

# Install the repositories using flit
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    cd /home/user/repos/cogent3 && \
    flit install -s && \
    cd /home/user/repos/EnsemblLite && \
    flit install -s

# Start in the home directory
WORKDIR /home/user

# Set zsh as the default shell for the container
CMD [ "zsh" ]