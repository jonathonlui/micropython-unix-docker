# micropython-unix-docker

Run [MicroPython](http://micropython.org) in a Docker conatiner.

## How to Build the Docker image

You'll need [Docker](https://www.docker.com) and some way to run the `Makefile` (like `make`). Alternatively, the Makefile is super simple so you can execute the steps manually, or run them a bash script.

Build the image by running: **`make`**.

The `Makefile` builds the ['Unix' version of MicroPython](<https://github.com/micropython/micropython/wiki/Getting-Started>) using Docker. The `Makefile` starts by creating an initial Docker image (see `Dockerfile.build-binary`) that:

1. Installs build dependencies
2. Downloads the micropython source from Github
3. Makes a small modification to the micropython Makefile to ignore a compile warning
4. Builds the micropython binary.

The initial Docker image ends up being about 330MB.

To create a smaller image, the next step in the `Makefile` will copy out the `micropython` binary from the first image on to the host

Then another Docker image (see `Dockerfile`) is created that installs a dependency (libffi) and adds the `micropython` binary from the host to the image. This final image is about 5.4 MB.

## How to Run

Once the final Docker image is build you can start running using MicroPython. You can get a MicroPython prompt by running:

`docker run -it --rm jonathonlui/micropython`

If you want run files on your local directory, one way to run is to mount the local directory into the container and specify the Python script to run. 

For example, if your Python files are in the current directory and the main script is `app.py` you could run it like this:

`docker run -it --rm -v $PWD:/usr/src/app jonathonlui/micropython app.py`

A simple helper shell script `micropython.sh` is include. Run is like this:

`./micropython.sh app.py`

There's a `helloworld.py` script included. Try it by running: `./micropython.sh helloworld.py` and you should see `Hello, World!` as ouput.