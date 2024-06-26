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

# Create a new conda environment with Python 3.12
RUN source /opt/conda/etc/profile.d/conda.sh && \
    /opt/conda/bin/conda create -n c312 python=3.12 -y && \
    conda activate c312

# Initialize conda for zsh shell
RUN echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc

# Clone the repositories using https, limit depth
WORKDIR /home/user/repos
RUN git clone --single-branch --branch develop --depth 1 https://github.com/cogent3/cogent3.git /home/user/repos/Cogent3 && \
    git clone --single-branch --branch develop --depth 1 https://github.com/cogent3/EnsemblLite.git /home/user/repos/EnsemblLite

# Install flit in the conda environment
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    conda install -c conda-forge flit h5py -y

# We use pip to install so we get plotly etc.. but also install
# other packages required for using jupyter notebooks
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate c312 && \
    pip install ipykernel nbformat && \
    cd /home/user/repos/Cogent3 && \
    pip install -e ".[extra]" && \
    cd /home/user/repos/EnsemblLite && \
    pip install -e .
 
# Start in the home directory
WORKDIR /home/user

# set ownership of ~/data to user
RUN sudo chown -R user:user /home/user/

# Set zsh as the default shell for the container
CMD [ "zsh" ]
