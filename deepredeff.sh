#!/bin/bash

#FASTADIR="$1"
FASTAFILE="$1"
#
#
Rscript deepredeff.r $FASTAFILE --slave > deepredeff_output
