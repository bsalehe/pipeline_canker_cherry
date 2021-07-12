#!/usr/bin/env Rscript

# Load the package
library(deepredeff)

## Collect arguments
args <- commandArgs(trailingOnly = TRUE)

## Parse arguments (we expect the form --arg=value)
#parseArgs <- function(x) strsplit(sub("^--", "", x), "=")
#argsL <- as.list(as.character(as.data.frame(do.call("rbind", parseArgs(args)))$V2))
#names(argsL) <- as.data.frame(do.call("rbind", parseArgs(args)))$V1
#args <- argsL
#rm(argsL)
#
## Give some value to options if not provided
#if(is.null(args$opt_arg1)) {args$opt_arg1="default_option1"}
#if(is.null(args$opt_arg2)) {args$opt_arg2="default_option1"} else {args$opt_arg2=as.numeric(args$opt_arg2)}

## Default setting when no all arguments passed or help needed
#if("--help" %in% args | is.null(args$arg1) | is.null(args$arg2)) {
#if("--help" %in% args) {
#  cat("
#      The R Script arguments_section.R
#
#      Mandatory arguments:
#      --arg1=string           - Directory where the fasta file is located
#      --arg2=string           - The name of the fasta file itself
#      --help                - print this text

      #Optionnal arguments:
      #--opt_arg1=String          - example:an absolute path, default:default_option1
      #--opt_arg2=Value           - example:a threshold, default:10

      #WARNING : here put all the things the user has to know

      #Example:
      #./arguments_section.R --arg1=~/FastaDir/ --arg2=nameOFfastafile
  #q(save="no")
#}

######################################################################################################################################################################################
#
# Define the fasta path from the sample data. Essentially, the fasta file and its dir are two arguments passed from the deepredeff.sh, which is part of the  pipeline workflow
#
#cat(args, sep = "\n")
#directory_fasta_file=args[2]
#print(args[1])
#bacteria_fasta_path <- system.file( directory_fasta_file, fasta_file, package = "deepredeff")

# Predict the effector candidate using bacteria model
predict_effector(input = args[1], taxon = "bacteria")

##########################################################################################################################################################################################
