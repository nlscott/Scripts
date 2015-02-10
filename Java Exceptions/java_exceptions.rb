#!/usr/bin/ruby


#define colored text
class String
	def green; "\033[32m#{self}\033[0m" end
	def cyan; "\033[36m#{self}\033[0m" end
end



#variables
current_user=`echo $USER`.chop
read_exceptions=`cat /Users/#{current_user}/Library/Application\\ Support/Oracle/Java/Deployment/security/exception.sites`


puts "\n  What site do you want to exempt? ".cyan
site=gets.chomp.strip


add_exception=`echo #{site} >> "/Users/#{current_user}/Library/Application Support/Oracle/Java/Deployment/security/exception.sites"`

add_exception
puts "\n  Adding site ....".cyan
sleep 1
puts "  Successful".green
