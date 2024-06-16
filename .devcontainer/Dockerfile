# Use continuumio/miniconda3 as the base image
FROM continuumio/miniconda3

LABEL maintainer="khiron <https://github.com/khiron>"

RUN conda update --all 

# Install required packages
RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        git \
        zsh \
        wget \
        curl \
        sudo \
        openssh-client \
        time \
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

# Create a new conda environment with Python 3.11
RUN source /opt/conda/etc/profile.d/conda.sh && \
    /opt/conda/bin/conda create -n c311 python=3.11 -y && \
    conda activate c311

# Initialize conda for zsh shell
RUN echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "conda activate c311" >> ~/.zshrc

# Clone the repositories using SSH
WORKDIR /home/user/repos
RUN git clone --branch develop https://github.com/cogent3/cogent3.git /home/user/repos/cogent3 && \
    git clone --branch master https://github.com/cogent3/EnsemblLite.git /home/user/repos/EnsemblLite

# Install flit in the conda environment
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c311 && \
    conda install -c conda-forge flit -y

# Install the repositories using flit --deps production to avoid dev dependencies that conflict (black/isort/click)
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c311 && \
    cd /home/user/repos/cogent3 && \
    flit install --deps production -s && \
    cd /home/user/repos/EnsemblLite && \
    flit install --deps production -s

# Start in the home directory
WORKDIR /home/user

# Set zsh as the default shell for the container
CMD [ "zsh" ]
