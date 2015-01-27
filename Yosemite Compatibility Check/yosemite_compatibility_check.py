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

#VARIABLES 
board_id_input = os.popen("ioreg -l | grep board-id | cut -d \\\" -f 4")
board_id = board_id_input.read().rstrip()

total_ram_input = os.popen("system_profiler SPHardwareDataType | grep Memory | awk '{print $2}'")
total_ram =  int(total_ram_input.read().rstrip())

free_space_input = os.popen("diskutil info / | grep \"Free Space\" | awk '{print $4}'")
free_space = float(free_space_input.read().rstrip())

mac_models = {
	"Mac-F4238CC8": "iMac7,1",
	"Mac-F42386C8": "iMac7,1",
	"Mac-F227BEC8": "iMac8,1",
	"Mac-F226BEC8": "iMac8,1",
	"Mac-F2218EC8": "iMac9,1",
	"Mac-F2218EA9": "iMac9,1",
	"Mac-F2218FC8": "iMac9,1",
	"Mac-F2218FA9": "iMac9,1",
	"Mac-F2268DC8": "iMac10,1",
	"Mac-F2268CC8": "iMac10,1",
	"Mac-F2268DAE": "iMac11,1",
	"Mac-F2238AC8": "iMac11,2",
	"Mac-F2238BAE": "iMac11,3",
	"Mac-F221DCC8": "iMac12,1",
	"Mac-942B5BF58194151B": "iMac12,1",
	"Mac-942B59F58194171B": "iMac12,2",
	"Mac-00BE6ED71E35EB86": "iMac13,1",
	"Mac-FC02E91DDD3FA6A4": "iMac13,2",
	"Mac-031B6874CF7F642A": "iMac14,1",
	"Mac-27ADBB7B4CEE8E61": "iMac14,2",
	"Mac-77EB7D7DAF985301": "iMac14,3",
	"Mac-81E3E92DD6088272": "iMac15,1",
	"Mac-FA842E06C61E91C5": "iMac15,x",
	"Mac-42FD25EABCABB274": "iMac15,x",
	"Mac-F42D89C8": "MacBook5,1",
	"Mac-F42D89A9": "MacBook5,1",
	"Mac-F22788AA": "MacBook5,2",
	"Mac-F22C8AC8": "MacBook6,1",
	"Mac-F22C89C8": "MacBook7,1",
	"Mac-F42D88C8": "MacBookAir2,1",
	"Mac-942452F5819B1C1B": "MacBookAir3,1",
	"Mac-942C5DF58193131B": "MacBookAir3,2",
	"Mac-C08A6BB70A942AC2": "MacBookAir4,1",
	"Mac-742912EFDBEE19B3": "MacBookAir4,2",
	"Mac-66F35F19FE2A0D05": "MacBookAir5,1",
	"Mac-2E6FAB96566FE58C": "MacBookAir5,2",
	"Mac-35C1E88140C3E6CF": "MacBookAir6,1",
	"Mac-7DF21CB3ED6977E5": "MacBookAir6,2",
	"Mac-C3EC7CD22292981F": "MacBookPro10,1",
	"Mac-AFD8A9D944EA4843": "MacBookPro10,2",
	"Mac-189A3D4F975D5FFC": "MacBookPro11,1",
	"Mac-3CBD00234E554E41": "MacBookPro11,2",
	"Mac-2BD1B31983FE1663": "MacBookPro11,3",
	"Mac-F42388C8": "MacBookPro3,1",
	"Mac-F4238BC8": "MacBookPro3,1",
	"Mac-F42C86C8": "MacBookPro4,1",
	"Mac-F42C89C8": "MacBookPro4,1",
	"Mac-F42D86A9": "MacBookPro5,1",
	"Mac-F42D86C8": "MacBookPro5,1",
	"Mac-F2268EC8": "MacBookPro5,2",
	"Mac-F22587C8": "MacBookPro5,3",
	"Mac-F22587A1": "MacBookPro5,4",
	"Mac-F2268AC8": "MacBookPro5,5",
	"Mac-F22589C8": "MacBookPro6,1",
	"Mac-F22586C8": "MacBookPro6,2",
	"Mac-F222BEC8": "MacBookPro7,1",
	"Mac-94245B3640C91C81": "MacBookPro8,1",
	"Mac-94245A3940C91C80": "MacBookPro8,2",
	"Mac-942459F5819B171B": "MacBookPro8,3",
	"Mac-4B7AC7E43945597E": "MacBookPro9,1",
	"Mac-7DF2A3B5E5D671ED": "MacBookPro9,2",
	"Mac-6F01561E16C75D06": "MacBookPro9,2",
	"Mac-F22C86C8": "MacMini3,1",
	"Mac-F2208EC8": "MacMini4,1",
	"Mac-8ED6AF5B48C039E1": "MacMini5,1",
	"Mac-4BC72D62AD45599E": "MacMini5,2",
	"Mac-7BA5B2794B2CDB12": "MacMini5,3",
	"Mac-031AEE4D24BFF0B1": "MacMini6,1",
	"Mac-F65AE981FFA204ED": "MacMini6,2",
	"Mac-F42C88C8": "MacPro3,1",
	"Mac-F221BEC8": "MacPro4,1",
	"Mac-F60DEB81FF30ACF6": "MacPro6,1",
	"Mac-F223BEC8": "Xserve3,1",
	"Mac-50619A408DB004DA": "unkown",
	"Mac-35C5E08120C7EEAF": "unknown"
}
result = mac_models.has_key(board_id)

#Sanity Check
#print board_id
#print total_ram
#print free_space
#print result


#check RAM
if type(total_ram) is int and total_ram >= 2:
	print bcolors.BOLD + "  RAM Installed = " + str(total_ram) + "GB : " + bcolors.OKGREEN + "PASS" + bcolors.ENDC
elif type(total_ram) is str or total_ram < 2:
	print bcolors.BOLD + "  RAM Installed = " + str(total_ram) + "GB : " + bcolors.FAIL + "FAIL" + bcolors.ENDC
else:
	print bcolors.WARNING +  "  RAM Status = Error!"
	print "  The RAM could not be checked on this machine!" + bcolors.ENDC


#check Free Space
if type(free_space) is float and free_space >= 8:
	print bcolors.BOLD + "  Free HD Space = " + str(free_space) + "GB : " + bcolors.OKGREEN + "PASS" + bcolors.ENDC
elif type(free_space) is str or free_space < 8:
	print bcolors.BOLD + "  Free HD Space = " + str(free_space) + "GB : " + bcolors.FAIL + "FAIL" + bcolors.ENDC
else:
	print bcolors.WARNING +  "  Free HD Space = Error!"
	print "  This machine does not have enough free space to install Yosemite!!" + bcolors.ENDC


#board id check
if result == True:	
	print bcolors.BOLD + "  Model ID = " + mac_models[board_id] + " : " + bcolors.OKGREEN +  "PASS" + bcolors.ENDC
elif result == False:
	print bcolors.BOLD + "  Model ID = " + mac_models[board_id] + " : " + bcolors.FAIL +  "FAIL" + bcolors.ENDC
else:
	print bcolors.WARNING + "  Model ID = Error!"
	print "  The Model of this machine could not be checked" + bcolors.ENDC


#Yosemite compatible check
if result == True and total_ram >= 2 and free_space >= 8:
	print "   - - - - - -"
	print bcolors.HEADER + "  Yosemite Compatible: " + bcolors.OKGREEN + "PASS" + bcolors.ENDC
	print bcolors.HEADER + "  This machine can be upgraded to Yosemite" + bcolors.ENDC
elif result != True or total_ram < 2 or free_space < 8:
	print "   - - - - - -"
	print bcolors.HEADER + "  Yosemite Compatible: " + bcolors.FAIL + "FAIL" + bcolors.ENDC
	print bcolors.FAIL + "  This machine can not be upgraded to Yosemite" + bcolors.ENDC
else:
	print "   - - - - - -"
	print bcolors.WARNING + "  Yosemite Compatible: ERROR"
	print "  The status of this machine could not be checked" + bcolors.ENDC
