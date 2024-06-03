# Cogent3 workshop Development container for cogent3 and EnsemblLite

This folder contains a Docker configuration file for setting up the workshop environment for working with `cogent3` and `EnsemblLite` in a docker container, and a `devcontainer.json` configuration so that VS Code can manage the container.  The container installs the develop branch of `cogent3`, and the master branch of `EnsemblLite`.  It also pre-populates VS code extensions for jupiter notebooks and for working with python.

For instructions for building this docker image into a container to run the workshop, see the [Computer setup instructions](https://github.com/cogent3/Cogent3Workshop/wiki/Computer-Setup).

## Container description

This development container is designed to provide a consistent and reproducible development environment for working with the    `cogent3` and `EnsemblLite` Python packages. It is based on a slim Debian image and includes a variety of tools and configurations to facilitate development.

- Base Image: The base image is debian:bookworm-slim, a slim version of the latest Debian release.
- Python: Python 3.12 is installed and set as the default Python version.
- Non-root User: A non-root user named user is created for running the container. This is a good security practice.
- Repositories: The cogent3 and EnsemblLite repositories are cloned into the /home/user/repos directory.
- Miniforge: Miniforge is installed to manage Python environments and packages. The base environment is not auto-activated.
- Conda Environment: A new conda environment named c312 is created with Python 3.12. This environment is activated when a new shell is started.
- Packages: Several packages are installed in the c312 environment using mamba, including flit, jupyter, ipykernel, unsync, and click.
- `cogent3` and `EnsemblLite`: The `cogent3` and `EnsemblLite` packages are installed from the cloned repositories in the c312 environment using flit.
- Zsh and Oh My Zsh: The Zsh shell is installed and set as the default shell. Oh My Zsh is installed for additional shell features and configurations. Several plugins are enabled, including git, zsh-autosuggestions, zsh-syntax-highlighting, and autojump.

## Using the Container

To use the container, you can load your clone of the workshop repository in VS-Code and you will be asked if you want to run in a devcontainer.  When you select yes, VS-Code will rebuild the container, start it, remote connect into the container, and open a new VS-Code window in the container.  You can then open a terminal in the container and you should automatically be in the zsh shell, in the mamba c312 environment, logged in as the user `User`, and in the directory /workspaces/$workshopname$ with the workshop files.  You can navigate to the the /home/user/repos directory to access the cogent3 and EnsemblLite repositories.

## Configuring Resource Allocation

You can configure the resource used for the development container by modifying the `devcontainer.json` file. This file allows you to specify the number of CPUs and the amount of RAM the container can use.

Steps

- Open the devcontainer.json file in your editor.
- Look for the runArgs property. by default it is set to `    "runArgs": ["--cpus", "1", "-m", "4g"],`, which is 1 cpu and 4GB of RAM.
- To limit the number of CPUs the container can use, add "--cpus" and "2" (or your desired number of CPUs) to the runArgs array.
- To limit the amount of RAM the container can use, add "-m" and "4g" (or your desired amount of RAM) to the runArgs array.

Please note that these settings will only limit the maximum resources a container can use. The container will use less resources if it doesn't need the maximum amount.  Also, please make sure that your Docker host has enough resources to allocate to the container. If the host doesn't have enough resources, the container may not start.