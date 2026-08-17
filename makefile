# Makefile to compile HYDRUS-1D on Mac and Linux

SOURCE_DIR = source

# Find the fortran compiler
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	CC = /usr/local/bin/gfortran
endif
ifeq ($(UNAME_S),Linux)
	CC = /usr/bin/gfortran
endif

# Set the files and objects
objects = $(SOURCE_DIR)/HYDRUS.o $(SOURCE_DIR)/INPUT.o $(SOURCE_DIR)/HYSTER.o $(SOURCE_DIR)/MATERIAL.o $(SOURCE_DIR)/OUTPUT.o $(SOURCE_DIR)/SINK.o $(SOURCE_DIR)/SOLUTE.o $(SOURCE_DIR)/TEMPER.o $(SOURCE_DIR)/TIME.o $(SOURCE_DIR)/WATFLOW.o
files = $(SOURCE_DIR)/HYDRUS.FOR $(SOURCE_DIR)/INPUT.FOR $(SOURCE_DIR)/HYSTER.FOR $(SOURCE_DIR)/MATERIAL.FOR $(SOURCE_DIR)/OUTPUT.FOR $(SOURCE_DIR)/SINK.FOR $(SOURCE_DIR)/SOLUTE.FOR $(SOURCE_DIR)/TEMPER.FOR $(SOURCE_DIR)/TIME.FOR $(SOURCE_DIR)/WATFLOW.FOR
FFLAGS = -g -ffpe-summary=none

# Compile to a unix executable
hydrus:
	$(CC) $(FFLAGS) -c $(files)
	$(CC) -o hydrus $(objects)
	rm $(objects)

# Compile to a shared-object file to import in python (WIP)
f2py:
	f2py -c $(files) -m hydrus

# Clean the directory after
clean:
	rm $(objects)
