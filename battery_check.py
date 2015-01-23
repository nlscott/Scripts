#!/usr/bin/env python 

import os
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

#VARIABLES #############################################################################################################
current_cycle_count=os.popen("ioreg -w0 -l | grep -w CycleCount | awk '{print $5}' | awk 'NR==1'")
current_input = current_cycle_count.read().rstrip()

max_cycle_count = os.popen("ioreg -w0 -l | grep -w DesignCycleCount9C | awk '{print $5}' | awk 'NR==1'")
max_input = max_cycle_count.read().rstrip()

cycle_check = os.popen("ioreg -w0 -l | grep -w CycleCount | awk '{print $3}' | awk 'NR==1' | cut -d '\"' -f 2")
cycylecheck = cycle_check.read().rstrip()

def make_int(s):
    s = s.strip()
    return int(s) if s else 0

current =  make_int(current_input)
max_ = make_int(max_input)
cycles_left = max_ - current


# COMMAND ###############################################################################################################
print bcolors.OKBLUE + "  Current Battery Cycles: " + str(current) + bcolors.ENDC
print bcolors.OKBLUE + "  Maximum Battery Cycles: " + str(max_) + bcolors.ENDC

if cycylecheck == "CycleCount":
    if cycles_left > 0:
        print bcolors.OKGREEN + "  Battery Status: Good" + bcolors.ENDC
        print bcolors.OKGREEN + "  Cycles Left: " + str(cycles_left) + bcolors.ENDC

    elif cycles_left < 0:
	   print bcolors.FAIL + "  Battery Status: Needs Replaced" + bcolors.ENDC
	   print bcolors.FAIL + "  Cycles Over: " + str(cycles_left) + bcolors.ENDC

    else:
        print bcolors.WARNING + ("  oops! something went wrong and the battery status could not be checked") + bcolors.ENDC
else:
    print bcolors.WARNING + ("  Error: an internal battery could not be found.") + bcolors.ENDC
