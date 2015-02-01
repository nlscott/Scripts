#!/usr/bin/env python

import os

#Define Formated Text Colors
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'



#Get file to check from user
print bcolors.OKBLUE + "\nWhat's the original SHA1? " + bcolors.ENDC
sha1_to_check=raw_input()

print bcolors.OKBLUE + "\nWhat file do you want to check? " + bcolors.ENDC
print bcolors.WARNING + "* Drag file to terminal" + bcolors.ENDC
print bcolors.WARNING + "* Make sure there are no spaces in the file name\n" + bcolors.ENDC
filepath=raw_input()

downloaded_sha1 = (os.popen("/usr/bin/openssl sha1 %s | awk '{print $2}'" % filepath)).read().rstrip()


#sanity check
print bcolors.HEADER + "\n  Original SHA1: " + sha1_to_check + bcolors.ENDC
print bcolors.HEADER + "  Current  SHA1: " + downloaded_sha1 + "\n" + bcolors.ENDC

if downloaded_sha1 == sha1_to_check:
	print bcolors.OKGREEN + "  File's SHA1 Match\n" + bcolors.ENDC
elif downloaded_sha1 != sha1_to_check:
	print bcolors.FAIL + "  SHA1's DO NOT MATCH\n" + bcolors.ENDC
else:
	print bcolors.WARNING + "  Error: SHA1's could not be compared\n"
