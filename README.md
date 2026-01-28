# nvchecker

- ![Build Status](https://github.com/snw35/nvchecker/actions/workflows/update.yml/badge.svg)
- [Dockerhub: snw35/nvchecker](https://hub.docker.com/r/snw35/nvchecker)

Dockerfile for the excellent [nvchecker](https://github.com/lilydjwg/nvchecker) Python module.

This container works with [dfupdate](https://github.com/snw35/dfupdate) to check itself for updates every week, and new versions are built and pushed automatically.

## How To Use

This container is compliant with the official image specification and runs nvchecker as it's default entrypoint. To have nvchecker run against a project with an `toml` file in the current working directory, you can run:

`docker run -it --rm --mount type=bind,source=${PWD},target=/data/ -w /data snw35/nvchecker:latest nvchecker -c nvchecker.toml`

Where `nvchecker.toml` is the name of the nvchecker configuration file. The nvchecker documentation at https://nvchecker.readthedocs.io shows how to write an nvchecker.toml file for your application.

## Automating Container Updates

I use this as part of a workflow to automatically update my container images. It runs in tandem with [dfupdate](https://github.com/snw35/dfupdate) (Dockerfile Updater) to automatically detect when new versions of software packaged in a Dockerfile are available, and to write and commit the changes directly, triggering a new build and container push to Dockerhub. The base image is also updated automatically.

So yes, this nvchecker image updates itself :)
