#!/usr/bin/ruby


#VARIABLES 
current_cycle_count=`ioreg -w0 -l | grep -w CycleCount | awk '{print $5}' | awk 'NR==1'`
max_cycle_count=`ioreg -w0 -l | grep -w DesignCycleCount9C | awk '{print $5}' | awk 'NR==1'`
cycle_check=`ioreg -w0 -l | grep -w CycleCount | awk '{print $3}' | awk 'NR==1' | cut -d '"' -f 2`

#define colored text
class String
	def red; "\033[31m#{self}\033[0m" end
	def green; "\033[32m#{self}\033[0m" end
	def brown; "\033[33m#{self}\033[0m" end
	def blue; "\033[34m#{self}\033[0m" end
	def magenta; "\033[35m#{self}\033[0m" end
	def cyan; "\033[36m#{self}\033[0m" end
	def gray; "\033[37m#{self}\033[0m" end
	def yellow; "\033[93m#{self}\033[0m" end
end


current=current_cycle_count.chop.to_i
max=max_cycle_count.chop.to_i
cycles_left=max-current

puts "Current Battery Cycles: ".cyan + current.to_s.green
puts "Maximum Battery Cycles: ".cyan + max.to_s.green



if cycle_check.chop == "CycleCount"
	if max - current > 0
	puts "- - - - - - - - "
	puts "Battery Status: ".cyan + "Good".green
	puts ("You still have " + cycles_left.to_s + " cycles left").green


	elsif max - current < 0
	puts "- - - - - - - - "
	puts "Battery Status: ".cyan + "Needs Replaced".red
	puts ("You are " + cycles_left.to_s + " cycles over").red

	else
	puts "oops! something went wrong and the battery status could not be checked".yellow
		
	end
else
	puts "Error: an internal battery could not be found.".yellow
end

