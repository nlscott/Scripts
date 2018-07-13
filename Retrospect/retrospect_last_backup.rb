#!/usr/bin/ruby

$retrologfile="/var/log/retroclient.log"
$history_file="/var/log/retroclient.history"


def clientVersion
	$retrospect_log_file=File.readlines("#{$retrologfile}")
	if File.readlines("#{$retrologfile}")
		for x in $retrospect_log_file
			if x.match("Client version")
				return x.split.last
			end
		end
	end
end

def clientHistory
	$retrospect_history_file=File.readlines("#{$history_file}")
	results=[]
	if File.readlines("#{$history_file}")
		for x in $retrospect_history_file
			results.push(x.split("/n"))
		end
	end
	return results[-2]
end


if !File.file?($retrologfile) && !File.file?($history_file)
	puts "Logs files do not exist"
elsif !File.file?($retrologfile) && File.file?($history_file)
	puts clientHistory
elsif File.file?($retrologfile) && !File.file?($history_file)
	puts "version: #{clientVersion}"
elsif clientVersion.empty? && clientHistory.empty?
	puts "Retrospect is not setup"
else
	puts "version: #{clientVersion}"
	puts clientHistory
end