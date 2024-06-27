# Cogent3 Workshop Development Container for cogent3 and EnsemblLite

This folder contains Docker configuration files for setting up the workshop environment for working with `cogent3` and `EnsemblLite` in a Docker container, 
and a `devcontainer.json` configuration so that VS Code can manage the container. The container installs the develop branch of `cogent3`, 
and the develop branch of `EnsemblLite`. 
It also pre-populates VS Code extensions for Jupyter notebooks and for working with Python, and Jupyter notebooks.

For instructions on building this Docker image into a container to run the workshop, see the [Computer Setup Instructions](https://github.com/cogent3/Cogent3Workshop/wiki/Computer-Setup).

## Container Description

This development container is designed to provide a consistent and reproducible development environment for working with the `cogent3` and `EnsemblLite` Python packages. 
It is based on a slim Debian image and includes a variety of tools and configurations to facilitate development.

- **Base Image**: The base image is `continuumio/miniconda3`, which is based on `debian:bookworm-slim`, a slim version of the latest Debian release.
- **Python**: Python 3.12 is installed and set as the default Python version.
- **Non-root User**: A non-root user with sudo access named `user` is created in the container. 
- **Repositories**: The `cogent3` and `EnsemblLite` repositories are cloned into the `/home/user/repos` directory.
- **Conda Environment**: A new conda environment named `c312` is created with Python 3.12. This environment is activated when a new shell is started.
- **Packages**: Flit is installed in the `c312` environment.
- **`cogent3` and `EnsemblLite`**: The `cogent3` and `EnsemblLite` packages are installed from the cloned repositories in the `c312` environment using flit.
- **Zsh and Oh My Zsh**: The Zsh shell is installed and set as the default shell. Oh My Zsh is installed for additional shell features and configurations. Several plugins are enabled, including `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `autojump`.

## Using the Container

To use the container, you can load your clone of the workshop repository into VS Code, and you will be asked if you want to run in a devcontainer. When you select "yes", VS Code will rebuild the container, start it, remote connect into the container, and open a new VS Code window in the container. You can then open a terminal in the container and you should automatically be in the Zsh shell, in the mamba `c312` environment, logged in as the user `user`, and in the directory `/home/user/workshop` with the workshop files. Any changes made to files here will change the files in your local clone of the repository.

You can navigate to the `/home/user/repos` directory to access the `cogent3` and `EnsemblLite` repositories.
