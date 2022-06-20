#!/usr/bin/ruby

require 'influxdb'
require 'date'


cache = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.Active'`.strip 
actualcacheused = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.ActualCacheUsed'`.strip
cacheicloud = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheDetails.iCloud'`.strip
cacheios = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheDetails."iOS Software"'`.strip  
cachemac = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheDetails."Mac Software"'`.strip   
cacheother = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheDetails.Other'`.strip 
cachefree = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheFree'`.strip 
cacheused = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheUsed'`.strip  
cachelimit = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.CacheLimit'`.strip 
lasthour = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.MaxCachePressureLast1Hour'`.strip 
returnedtoclients = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.TotalBytesReturnedToClients'`.strip 
storedfromorgin = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.TotalBytesStoredFromOrigin'`.strip 
bytesimported = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.TotalBytesImported'`.strip 
bytessince = `AssetCacheManagerUtil status -j 2>/dev/null | jq '.result.TotalBytesAreSince'`.strip 

since_date = DateTime.parse(bytessince)
now_date = DateTime.now
days_between = (now_date  - since_date).to_i

# Send To Grafana ----------------------------------------------------------------------------------
database = 'mydatabase'
name = "Caching"
time_precision = 'ms'
time = (Time.now.to_r * 1000).to_i
influxdb = InfluxDB::Client.new(
    database: database,
    host: "10.0.1.9",
    use_ssl: false,
    time_precision: time_precision,
    retry: 4)

data = {
    values: 
    { 
        "cache": "#{cache}".to_s,
        "actualcacheused": "#{actualcacheused}".to_f,
        "cacheicloud": "#{cacheicloud}".to_f,
        "cacheios": "#{cacheios}".to_f,
        "cachemac": "#{cachemac}".to_f,
        "cacheother": "#{cacheother}".to_f,
        "cachefree": "#{cachefree}".to_f,
        "cacheused": "#{cacheused}".to_f,
        "cachelimit": "#{cachelimit}".to_f,
        "lasthour": "#{lasthour}".to_f,
        "returnedtoclients": "#{returnedtoclients}".to_f,
        "storedfromorgin": "#{storedfromorgin}".to_f,
        "bytesimported": "#{bytesimported}".to_f,
        "bytessince": "#{bytessince}".to_s,
        "days_between": "#{days_between}".to_i,
    },
    timestamp: time,
    tags:
    { 
        "computer": "PlexS",
    } 
}

# puts data
influxdb.write_point(name, data)

