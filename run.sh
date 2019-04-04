#! /bin/bash

#create a water box
gmx solvate -cs tip5p.gro -o box.gro -box 2 3 4 