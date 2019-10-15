# nvchecker

Dockerfile for the excellent [nvchecker](https://github.com/lilydjwg/nvchecker) Python module.

## How To Use

This container is compliant with the official image specification and runs nvchecker as it's default entrypoint. To have nvchecker run against a project with an `ini` file in the current working directory, you can:

`docker run -it --rm --mount type=bind,source=${PWD},target=/data/ -w /data snw35/nvchecker:latest nvchecker nvchecker.ini`

Where `nvchecker.ini` is the name of the nvchecker configuration file.

## Automating Container Updates

I use this as part of a workflow to automatically update my container images. It runs in tandem with [dfupdate](https://github.com/snw35/dfupdate) (Dockerfile Updater) to automatically detect when new versions of software packaged in a Dockerfile are available, and to write and commit the changes directly, triggering a new build.

And yes, this nvchecker image updates itself :)

## Releases

Releases are tagged with all version numbers of software installed in the Dockerfile followed by the version of the base image:

 * version1-version2-version3-...-base-image-version

Container images are tagged with the primary software version. The `lastest` tag always points to the last image built, which is **NOT** guaranteed to be the latest release, but in most cases should be.
