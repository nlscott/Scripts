#!/usr/bin/env python3

# --------------------------------------------------------------------------------------------------
# Meant to be run on Intel macs, all M1 macs are compatible with Monterey
# Run with Python3
# --------------------------------------------------------------------------------------------------


import os
import plistlib


#VARIABLES -----------------------------------------------------------------------------------------
boardPlist = "/System/Library/CoreServices/PlatformSupport.plist"

def board_id():
	board_id_input = \
	os.popen("ioreg -l | grep board-id | awk '{print $4}' | cut -c 3- |rev | cut -c 3- | rev")
	board_id = board_id_input.read().rstrip()
	return board_id

def total_ram():
	total_ram_input = \
	os.popen("system_profiler SPHardwareDataType | grep Memory | awk '{print $2}'")
	total_ram =  int(total_ram_input.read().rstrip())
	return total_ram

def free_space():
	free_space_input = \
	os.popen("diskutil info / | grep \"Free Space\" | awk '{print $4}'")
	free_space = float(free_space_input.read().rstrip())
	return free_space

def supportedBoardIDs():
	supportedBoardIDs = []
	with open(boardPlist, "rb") as file:
		myPlist = plistlib.load(file)
		for x in myPlist["SupportedBoardIds"]:
			supportedBoardIDs.append(x)
	return supportedBoardIDs

montereySupportedBoardIDs = [
    "Mac-E43C1C25D4880AD6",
    "Mac-35C5E08120C7EEAF",
    "Mac-66E35819EE2D0D05",
    "Mac-CAD6701F7CEA0921",
    "Mac-A5C67F76ED83108C",
    "Mac-551B86E5744E2388",
    "Mac-F60DEB81FF30ACF6",
    "Mac-9AE82516C7C6B903",
    "Mac-FFE5EF870D7BA81A",
    "Mac-DB15BD556843C820",
    "Mac-B809C3757DA9BB8D",
    "Mac-65CE76090165799A",
    "Mac-9F18E312C5C2BF0B",
    "Mac-937CB26E2E02BB01",
    "Mac-A369DDC4E67F1C45",
    "Mac-EE2EBD4B90B839A8",
    "Mac-473D31EABEB93F9B",
    "Mac-B4831CEBD52A0C4C",
    "Mac-827FB448E656EC26",
    "Mac-4B682C642B45593E",
    "Mac-77F17D7DA9285301",
    "Mac-BE088AF8C5EB4FA2",
    "Mac-7BA5B2D9E42DDD94",
    "Mac-AA95B1DDAB278B95",
    "Mac-63001698E7A34814",
    "Mac-226CB3C6A851A671",
    "Mac-827FAC58A8FDFA22",
    "Mac-06F11FD93F0323C5",
    "Mac-06F11F11946D27C5",
    "Mac-E1008331FDC96864",
    "Mac-27AD2F918AE68F61",
    "Mac-7BA5B2DFE22DDD8C",
    "Mac-CFF7D910A743CAAF",
    "Mac-AF89B6D9451A490B",
    "Mac-53FDB3D8DB8CA971",
    "Mac-5F9802EFE386AA28",
    "Mac-A61BADE1FDAD7B05",
    "Mac-E7203C0F68AA0004",
    "Mac-0CFF9C7C2B63DF8D",
    "Mac-937A206F2EE63C01",
    "Mac-1E7E29AD0135F9BC",
    "Mac-112818653D3AABFC",
    "VMM-x86_64"
]


#check RAM -----------------------------------------------------------------------------------------
def check_memory():
    if type(total_ram()) is int and total_ram() >= 4:
        print(f"Memory Installed: {total_ram()} GB (Compatible)")
        return "true"
    else:
        print(f"Memory Installed: {total_ram()} GB (Not Compatible)")
        print("ERROR: ... You don't have enough Memory to install macOS Monterey")
        return "false"


# #check Free Space ----------------------------------------------------------------------------------
def check_free_space():
	if type(free_space()) is float and free_space() >= 26:
		print(f"Free HardDrive Space: {free_space()} GB (Compatible)")
		return "true"
	else:
		print(f"Free HardDrive Space: {free_space()} GB (Not Compatible)")
		print("ERROR: ... You need more free space to install macOS Monterey")
		print("\n")
		return "false"

# # #Check Board ID --------------------------------------------------------------------------------
def check_board_ids():
	if board_id() in montereySupportedBoardIDs:
		print(f"Mac Board ID: {board_id()} (Compatible)")
		return "true"
	else:
		print(f"Mac Board ID: {board_id()} (Not Compatible)")
		return  "false"




check_memory()
check_free_space()
check_board_ids()