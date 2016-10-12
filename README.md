# Manchester Accelerator Physics - BDSIM Docker Image
Dockerfile for our BDSIM image, based on our Geant4 image. 

This repository contains a Dockerfile which is used to build a docker image containing the BDSIM program, and a shell script used to run BDSIM in a container while mounting the current working directory.

BDSIM is used to track particles and produce radiation showers and loss maps. It is developed by a team at RHUL, and much more information can be found [here](https://twiki.ph.rhul.ac.uk/twiki/bin/view/PP/JAI/BdSim)

The docker image has its entrypoint set to the BDSIM executable, and the working directory (within the image) set to /workspace. This means that by mounting the current working directory in a docker command, you can simulate using files there and get results written back there. These commands look something like this:

    docker run -v \`pwd\`:/workspace manacc/bdsim:0.9 \<your arguments here\>

Note that there are some limitations to this: you can only access subdirectories of the current working directory from within the image for example (don't try to call files that are in a different directory).

A docker command to run BDSIM while mounting the current directory is provided in the small shell script `dockerBDSIM`, also in this repository.
