FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    time libfl2 tcsh python3 pip git vim bc gcc gfortran libnetcdf-dev libnetcdff-dev netcdf-bin \
    && rm -rf /var/lib/apt/lists/*
# The last line cleans up cache to reduce container size
# No need to run `apt-get clean` as it is done automatically in official ubuntu image
# See more at https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run

# GEOS-Chem environment variables
ENV USER=docker
ENV HOST=docker
ENV CC=gcc CXX=g++ FC=gfortran
ENV F90=$FC F9X=$FC F77=$FC
ENV F90FLAGS = -cpp -g -O0 -Wall -ffree-line-length-none -fno-range-check -fbacktrace -fbounds-check -fdump-core -fimplicit-none -fall-intrinsics -fallow-invalid-boz -Wno-unused-variable -frecursive -Wno-unused-dummy-argument -Wno-conversion
ENV NETCDF_HOME=/usr NETCDF_FORTRAN_HOME=/usr
ENV GC_BIN=$NETCDF_HOME/bin \
    NETCDF_INCLUDE=$NETCDF_HOME/include \
    NETCDF_LIB=$NETCDF_HOME/lib/x86_64-linux-gnu \
    GC_F_BIN=$NETCDF_FORTRAN_HOME/bin \
    GC_F_INCLUDE=$NETCDF_FORTRAN_HOME/include \
    GC_F_LIB=$NETCDF_FORTRAN_HOME/lib

WORKDIR /caaba

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install the required packages
RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT [ "/usr/bin/python3" ]

#CMD ["/usr/bin/python3", "python_script.py"]