#!/usr/bin/env python

from __future__ import division
import os, sys
sys.argv

import re

def read_rewrite_blastpout(blastpout_txt_file, blastpout_hits_fasta_seq_file, seq_from_deepredeff_fasta_file):
        # The function to compare sequence ID from Deepredeff and those identifed from blastp hits
        # based on the similarity of their sequence IDs.
        # Essentially it compare hits obtaianed from blastp and thier corresponding sequences from Deepredeff outputs
        # to determine the most likely T3 effectors and further reducing  potential false positives.
        #
        global header1, header 
        fh = open(blastpout_txt_file,'r') #file handle for blastp results
        fhout = open(blastpout_hits_fasta_seq_file,'w') #output file for identified potential T3 effector blastp hits
        fdeep_seq = open(seq_from_deepredeff_fasta_file,'r') # file handle to compare sequemces from Deepredeff and the identified hits based on sequence ID similarity
        hit_found = False
        seq = ''
        for line in fh:
                line = line.strip()
                if line[0:5] == "Query":
                        header1 = line[7:]
                elif line[0:9] == "Sequences":
                        hit_found = True
                elif hit_found == True:
                        header = '>' + header1
                        fhout.write(header + "\n")
                        flag_header = False
                        for line1 in fdeep_seq:
                                line1 = line1.strip()
                                if line1 == header and seq == '':
                                        flag_header = True
                                elif line1[0] != '>' and flag_header == True:
                                        seq = seq + line1
                                        fhout.write(seq + "\n")
                                        seq = ''
                                        break
                        hit_found = False
        fdeep_seq.close()
        fhout.close()
        fh.close()

if __name__ == '__main__':
        infile1 = str(sys.argv[1])
        infile2 = str(sys.argv[2])
        infile3 = str(sys.argv[3])
        read_rewrite_blastpout(infile1,infile2, infile3)
