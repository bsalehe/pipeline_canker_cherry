#!/usr/bin/env python

from __future__ import division
import os, sys
sys.argv

import re
#line = "LOCUS       NODE_1_length_6583_cov_3.6601616583 bp   DNA linear     03-OCT-2021"
#new_line = re.sub("_length_", " ", line)
#new_line = re.sub("_cov_3.6601616583", " ", new_line)
#print(new_line)

#with open("/data/scratch/bsalehe/backup_prokka_out/HT1_S1/PROKKA_10032021.gbk") as fh:
#     for line in fh:
#             if line[0:5]=="LOCUS":
#                     line = re.sub("_length_", " ", line)
#                     for item in line.split(' '):
#                             if "cov" in item:
#                                     txt=item.replace("_cov_", " ")
#                                     txt=txt.split(' ')
#                                     nline=re.sub(txt[1], "", line)
#				      nline=re.sub("_cov_", "", nline)
#                     print(nline)
#             else:
#                     print(line)


def read_rewrite_genbank(gb_file):
	global nline
	new_file_content=""
	with open(gb_file,'r') as fh:
		#fh.seek(0)
		#line=fh.readline()
		#new_file_content=""
		for line in fh:
			#line=line.strip()
			if line[0:5]=="LOCUS":
				line = re.sub("_length_", " ", line)
				for item in line.split(' '):
					if "cov" in item:
						txt=item.replace("_cov_", " ")
						txt=txt.split(' ')
						nline=re.sub(txt[1], "", line)
						nline=re.sub("_cov_", "", nline)
				new_file_content += nline +"\n"
			else:
				new_file_content += line +"\n"
		#fh.close()
	with open(gb_file,'w') as fhout:
		fhout.write(new_file_content)
						#print(nline)
				#fh.write(nline)
				#fh.truncate()
			#else:
				#fh.write(line)
	#fh.close()
	#return(nline)

#def write_genbank(gb_file):
#	newline=read_genbank(gb_file)
	
#	with open(gb_file, 'r+') as fh:
		#line=readline(fh)
#		for line in fh:
#			if line[0:5]=='LOCUS':
#				line=line.replace(line, newline)
#			fh.write(line)
#			next(line)
#	fh.close()


if __name__ == '__main__':
	infile1 = str(sys.argv[1])
	read_rewrite_genbank(infile1)
