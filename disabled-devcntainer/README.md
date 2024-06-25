# Cogent3 Workshop Development Container for cogent3 and EnsemblLite

This folder contains Docker configuration files for setting up the workshop environment for working with `cogent3` and `EnsemblLite` in a Docker container, 
and a `devcontainer.json` configuration so that VS Code can manage the container. The container installs the develop branch of `cogent3`, 
and the master branch of `EnsemblLite`. 
It also pre-populates VS Code extensions for Jupyter notebooks and for working with Python.

For instructions on building this Docker image into a container to run the workshop, see the [Computer Setup Instructions](https://github.com/cogent3/Cogent3Workshop/wiki/Computer-Setup).

## Choosing the Container Version

You can choose whether to have the data pre-populated in the `~/data` folder by selecting the appropriate container from the GitHub Container Registry (GHCR).

- **Default Container**: This container does not include prepopulated data. Use the default `devcontainer.json` file with the image set to `ghcr.io/khiron/cogent3-workshop:latest`.
- **Container prepopulated with apes_112**: This container includes the data prepopulated in the `~/data` folder. Change the image in the `devcontainer.json` file to `ghcr.io/khiron/cogent3-workshop:apes_112`.

### Steps to Switch Containers

1. Open the `devcontainer.json` file in your editor.
2. To use the default container, ensure the image is set to:
   ``"image": "ghcr.io/khiron/cogent3-workshop:latest"``
3. To use the prepopulated data container, change the image to:
   ``"image": "ghcr.io/khiron/cogent3-workshop:apes_112"``

4. Add the following `updateContentCommand` to ensure the latest image is pulled:
   ``"updateContentCommand": "docker pull ghcr.io/khiron/cogent3-workshop:latest"``
   or
   ``"updateContentCommand": "docker pull ghcr.io/khiron/cogent3-workshop:apes_112"`` if you are pre-populating the container with data 


## Configuring Resource Allocation

You can configure the resources used for the development container by modifying the `devcontainer.json` file. This file allows you to specify the number of CPUs and the amount of RAM the container can use.

### Steps

- Open the `devcontainer.json` file in your editor.
- Look for the `runArgs` property. By default, it is set to ``"runArgs": ["--cpus", "2", "-m", "4g"],``, which allocates 2 CPUs and 4GB of RAM.
- To limit the number of CPUs the container can use, add ``"--cpus"`` and your desired number of CPUs to the `runArgs` array.
- To limit the amount of RAM the container can use, add ``"-m"`` and your desired amount of RAM (e.g., ``"4g"``) to the `runArgs` array.

Please note that these settings will only limit the maximum resources a container can use. 
The container will use fewer resources if it doesn't need the maximum amount. 
Also, please ensure that your Docker host has enough resources to allocate to the container. 
If the host doesn't have enough resources, the container may not start.

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

To use the container, you can load your clone of the workshop repository in VS Code and you will be asked if you want to run in a devcontainer. When you select "yes", VS Code will rebuild the container, start it, remote connect into the container, and open a new VS Code window in the container. You can then open a terminal in the container and you should automatically be in the Zsh shell, in the mamba `c312` environment, logged in as the user `user`, and in the directory `/workspaces/$workshopname$` with the workshop files. You can navigate to the `/home/user/repos` directory to access the `cogent3` and `EnsemblLite` repositories.
