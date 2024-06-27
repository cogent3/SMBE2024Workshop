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
        zip \
        unzip \
        pigz \
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
RUN git clone --branch develop https://github.com/cogent3/cogent3.git /home/user/repos/cogent3 && \
    git clone --branch develop https://github.com/cogent3/EnsemblLite.git /home/user/repos/EnsemblLite

# Install flit in the conda environment
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    conda install -c conda-forge flit h5py -y

# Install the repositories using flit --deps production to avoid dev dependencies that conflict (black/isort/click)
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    cd /home/user/repos/cogent3 && \
    flit install --deps production -s && \
    cd /home/user/repos/EnsemblLite && \
    flit install --deps production -s

# download the data - not the ~/workshop directory does not exist until it is mounted in the container by devcontainer.json
RUN wget -P /home/user/data https://www.dropbox.com/scl/fi/60etoj9omxm5579e6z1fy/database.sqlite.zip

# Start in the home directory
WORKDIR /home/user

# set ownership of ~/data to user
RUN sudo chown -R user:user /home/user/

# Set zsh as the default shell for the container
CMD [ "zsh" ]
