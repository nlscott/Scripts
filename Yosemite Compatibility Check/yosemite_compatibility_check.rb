#!/usr/bin/ruby


#VARIABLES 
board_id=`ioreg -l | grep "board-id" | cut -d \\" -f 4`.chop
total_ram=`system_profiler SPHardwareDataType | grep Memory | awk '{print $2}'`.to_i
free_space=`diskutil info // | grep "Free Space" | awk '{print $4}'`.to_i

#define colored text
class String
	def red;		"\033[31m#{self}\033[0m" end
	def green;		"\033[32m#{self}\033[0m" end
	def brown;		"\033[33m#{self}\033[0m" end
	def blue;		"\033[34m#{self}\033[0m" end
	def magenta;	"\033[35m#{self}\033[0m" end
	def cyan;		"\033[36m#{self}\033[0m" end
	def gray;		"\033[37m#{self}\033[0m" end
	def yellow;		"\033[93m#{self}\033[0m" end

end

#list of yosemite compatible Mac Models
mac_models = {
	"Mac-F4238CC8" => "iMac7,1",
	"Mac-F42386C8" => "iMac7,1",
	"Mac-F227BEC8" => "iMac8,1",
	"Mac-F226BEC8" => "iMac8,1",
	"Mac-F2218EC8" => "iMac9,1",
	"Mac-F2218EA9" => "iMac9,1",
	"Mac-F2218FC8" => "iMac9,1",
	"Mac-F2218FA9" => "iMac9,1",
	"Mac-F2268DC8" => "iMac10,1",
	"Mac-F2268CC8" => "iMac10,1",
	"Mac-F2268DAE" => "iMac11,1",
	"Mac-F2238AC8" => "iMac11,2",
	"Mac-F2238BAE" => "iMac11,3",
	"Mac-F221DCC8" => "iMac12,1",
	"Mac-942B5BF58194151B" => "iMac12,1",
	"Mac-942B59F58194171B" => "iMac12,2",
	"Mac-00BE6ED71E35EB86" => "iMac13,1",
	"Mac-FC02E91DDD3FA6A4" => "iMac13,2",
	"Mac-031B6874CF7F642A" => "iMac14,1",
	"Mac-27ADBB7B4CEE8E61" => "iMac14,2",
	"Mac-77EB7D7DAF985301" => "iMac14,3",
	"Mac-81E3E92DD6088272" => "iMac15,1",
	"Mac-FA842E06C61E91C5" => "iMac15,x",
	"Mac-42FD25EABCABB274" => "iMac15,x",
	"Mac-F42D89C8" => "MacBook5,1",
	"Mac-F42D89A9" => "MacBook5,1",
	"Mac-F22788AA" => "MacBook5,2",
	"Mac-F22C8AC8" => "MacBook6,1",
	"Mac-F22C89C8" => "MacBook7,1",
	"Mac-F42D88C8" => "MacBookAir2,1",
	"Mac-942452F5819B1C1B" => "MacBookAir3,1",
	"Mac-942C5DF58193131B" => "MacBookAir3,2",
	"Mac-C08A6BB70A942AC2" => "MacBookAir4,1",
	"Mac-742912EFDBEE19B3" => "MacBookAir4,2",
	"Mac-66F35F19FE2A0D05" => "MacBookAir5,1",
	"Mac-2E6FAB96566FE58C" => "MacBookAir5,2",
	"Mac-35C1E88140C3E6CF" => "MacBookAir6,1",
	"Mac-7DF21CB3ED6977E5" => "MacBookAir6,2",
	"Mac-C3EC7CD22292981F" => "MacBookPro10,1",
	"Mac-AFD8A9D944EA4843" => "MacBookPro10,2",
	"Mac-189A3D4F975D5FFC" => "MacBookPro11,1",
	"Mac-3CBD00234E554E41" => "MacBookPro11,2",
	"Mac-2BD1B31983FE1663" => "MacBookPro11,3",
	"Mac-F42388C8" => "MacBookPro3,1",
	"Mac-F4238BC8" => "MacBookPro3,1",
	"Mac-F42C86C8" => "MacBookPro4,1",
	"Mac-F42C89C8" => "MacBookPro4,1",
	"Mac-F42D86A9" => "MacBookPro5,1",
	"Mac-F42D86C8" => "MacBookPro5,1",
	"Mac-F2268EC8" => "MacBookPro5,2",
	"Mac-F22587C8" => "MacBookPro5,3",
	"Mac-F22587A1" => "MacBookPro5,4",
	"Mac-F2268AC8" => "MacBookPro5,5",
	"Mac-F22589C8" => "MacBookPro6,1",
	"Mac-F22586C8" => "MacBookPro6,2",
	"Mac-F222BEC8" => "MacBookPro7,1",
	"Mac-94245B3640C91C81" => "MacBookPro8,1",
	"Mac-94245A3940C91C80" => "MacBookPro8,2",
	"Mac-942459F5819B171B" => "MacBookPro8,3",
	"Mac-4B7AC7E43945597E" => "MacBookPro9,1",
	"Mac-7DF2A3B5E5D671ED" => "MacBookPro9,2",
	"Mac-6F01561E16C75D06" => "MacBookPro9,2",
	"Mac-F22C86C8" => "MacMini3,1",
	"Mac-F2208EC8" => "MacMini4,1",
	"Mac-8ED6AF5B48C039E1" => "MacMini5,1",
	"Mac-4BC72D62AD45599E" => "MacMini5,2",
	"Mac-7BA5B2794B2CDB12" => "MacMini5,3",
	"Mac-031AEE4D24BFF0B1" => "MacMini6,1",
	"Mac-F65AE981FFA204ED" => "MacMini6,2",
	"Mac-F42C88C8" => "MacPro3,1",
	"Mac-F221BEC8" => "MacPro4,1",
	"Mac-F60DEB81FF30ACF6" => "MacPro6,1",
	"Mac-F223BEC8" => "Xserve3,1",
	"Mac-50619A408DB004DA" => "unkown",
	"Mac-35C5E08120C7EEAF" => "unknown"
}

result = mac_models.has_key? (board_id)


#check RAM
if total_ram >= 2
	puts "  RAM Installed = ".cyan + total_ram.to_s.cyan + "GB : ".cyan + "PASS".green
elsif total_ram < 2
	puts "  RAM Installed = ".cyan + total_ram.to_s.cyan + "GB : ".cyan + "FAIL".red
else
	puts "  RAM Status = Error!".yellow
	puts "  The RAM could not be checked on this machine!".yellow
end


#check Free Space
if free_space >= 8
	puts "  Free HD Space = ".cyan + free_space.to_s.cyan + "GB : ".cyan + "PASS".green
elsif free_space < 8
	puts "  Free HD Space = ".cyan + free_space.to_s.cyan + "GB : ".cyan + "FAIL".red
else
	puts "  Free HD Space = Error!".yellow
	puts "  THis machine does not have enough free space to install Yosemite!!".yellow
end


#board id check
if result == true
	puts "  Model ID = ".cyan + mac_models[board_id].cyan + " : ".cyan + "PASS".green
elsif result == false
	puts "  Model ID = ".cyan + mac_models[board_id].cyan + " : ".cyan + "FAIL".red
else
	puts "  Model ID = Error!".yellow
	puts "  The Model of this machine could not be checked".yellow
end


#Yosemite compatible check
if result == true and total_ram >= 2 and free_space >= 8
	puts "  - - - - - - - - -".yellow
	puts "  Yosemite Compatible: ".cyan + "PASS".green
	puts "  This machine can be upgraded to Yosemite".green

elsif result != true or total_ram < 2 or free_space < 8
	puts "  - - - - - - - - -".yellow
	puts "  Yosemite Compatible: ".cyan + "FAIL".red
	puts "  This machine can not be upgraded to Yosemite".red

else
	puts "  - - - - - - - - -".yellow
	puts "  Yosemite Compatible: ERROR".yellow
	puts "  The status of this machine could not be checked".yellow
end



