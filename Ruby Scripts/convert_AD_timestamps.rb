#!/usr/bin/ruby



def convert_ad_time(ad_timestamp)
	ad_timestamp_to_epoch=(ad_timestamp/10000000)-11644473600
	epoch_to_date=Time.at(ad_timestamp_to_epoch).strftime("%m.%d.%Y")
	return epoch_to_date
end


# example
# puts convert_ad_time(130888075497943613)
# output: 10.08.2015