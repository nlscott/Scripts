#!/usr/bin/ruby

#VARIABLES 
sha1_to_check="7a860d9d3f3512a9cdf770ca75c8fd2fdde4e0fc"


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

#Get file to check from user
puts "What file do you want to check? ".cyan
filepath=gets.chomp

downloaded_sha1=`/usr/bin/openssl sha1 #{filepath} | awk '{print $2}'`.chop

puts "  \n  Original SHA1: " + downloaded_sha1.yellow

if downloaded_sha1 == sha1_to_check
	puts "  Status: Files Match\n".green
else
	puts "  Status: Failed .... files do not match\n".red
end

 