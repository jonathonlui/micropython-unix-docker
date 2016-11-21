# micropython-unix-docker

Run [MicroPython](http://micropython.org) in a Docker container. Includes the [micropython-lib core libraries](https://github.com/micropython/micropython-lib)

## How to Build the Docker image

You'll need [Docker](https://www.docker.com) and some way to run the `Makefile` (like `make`). Alternatively, the Makefile is super simple so you can execute the steps manually, or run them a bash script.

Build the image by running: **`make`**.

The `Makefile` builds the ['Unix' version of MicroPython](<https://github.com/micropython/micropython/wiki/Getting-Started>) using Docker. The `Makefile` starts by creating an initial Docker image (see `Dockerfile.build-binary`) that:

1. Installs build dependencies
2. Downloads the micropython source from Github
3. Makes a small modification to the micropython Makefile to ignore a compile warning
4. Builds and installs the micropython binary
5. Downloads the micropython-lib source from GitHub
6. Installs micropython-lib which copies the micropython modules to /root/.micropython

The initial Docker image ends up being about 340MB.

To create a smaller image, the next step in the `Makefile` will copy out the `micropython` binary and core modules from the first image on to the host

Then another Docker image (see `Dockerfile`) is created that installs a dependency (libffi) and adds the `micropython` binary and core modules from the first Docker image to the final Docker image. The final Docker image is about 6.9 MB.

## How to Run

Once the final Docker image is built, you can start using MicroPython.

You can start a MicroPython prompt by running:

`docker run -it --rm jonathonlui/micropython`

If you want to run Python scripts from your local directory, one way to run is to mount the local directory into the container and specify the Python script to run. 

For example, if your Python files are in the current directory and the main script is `app.py` you could run it like this:

`docker run -it --rm -v $PWD:/usr/src/app jonathonlui/micropython app.py`

A simple helper shell script `micropython.sh` is include. Run is like this:

`./micropython.sh app.py`

There's a `helloworld.py` script included. Try it by running: `./micropython.sh helloworld.py` and you should see `Hello, World!` as ouput.

## Core Libraries

The core libraries from [micropython-lib](https://github.com/micropython/micropython-lib) are installed in `/root/.micropython`.

## Known Issues
- Many Python scripts will fail during execution and output 'Illegal instruction'. Running the same code in a prompt is likely to succeed.  ¯\\\_(ツ)_/¯
