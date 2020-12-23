# N64

## Makefile

This file builds the images by default the dependant images are deleted at the end of the build, do not use make all if you wish to keep them.

## Makefile.sample

See Makefile.sample for an example of how to setup your project to use this image for building.

_NOTE_: all paths are in the docker container NOT the local machine. So any INCLUDE / LIB paths *must* be in the same dir as the Makefile

## Build Notes

Originally this did use a multistage build to generate the n64:latest image however this was changed to seperate images
due to the build cache becoming very large and persisting when only updating the main image.
E.g. When updating only the last image it was noticed that extra storage vanished at approx 3gb per rebuild.
By splitting the builds out into seperate images the buildcache for the temp images is better utilised and allows any image to be independantly updated for testing purposes.

- Dockerfile_mips
  
    This builds the gcc mips toolchain for the n64 and places it in /opt/n64/

- Docker_spicy
  
    This builds a fork of [spicy](https://github.com/depp/spicy) and is also used to extract the n64sdk so that 7zip doesnt need to be installed elsewhere.

- Dockerfile

    This is the main image, it copies in /opt from the MIPS image, spicy and the headers/libs from n64sdk from the spicy image. Any command can be run from this image as the entry point is simply '$@', its purpose is simply to setup the path to include /opt/n64/bin/
