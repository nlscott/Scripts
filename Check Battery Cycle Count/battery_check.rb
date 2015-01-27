#!/usr/bin/ruby


#VARIABLES 
current_cycle_count=`ioreg -w0 -l | grep -w CycleCount | awk '{print $5}' | awk 'NR==1'`
max_cycle_count=`ioreg -w0 -l | grep -w DesignCycleCount9C | awk '{print $5}' | awk 'NR==1'`
cycle_check=`ioreg -w0 -l | grep -w CycleCount | awk '{print $3}' | awk 'NR==1' | cut -d '"' -f 2`


current=current_cycle_count.chop.to_i
max=max_cycle_count.chop.to_i
cycles_left=max-current

puts "Current Battery Cycles: " + current.to_s
puts "Maximum Battery Cycles: " + max.to_s



if cycle_check.chop == "CycleCount"
	if max - current > 0
	puts "\nBattery Status: Good"
	puts "You still have " + cycles_left.to_s + " cycles left"


	elsif max - current < 0
	puts "\nBattery Status: Needs Replaced"
	puts "You are " + cycles_left.to_s + " cycles over"

	else
	puts "oops! something went wrong and the battery status could not be checked"
		
	end
else
	puts "Error: an internal battery could not be found."
end

