#!/bin/zsh


# https://developer.apple.com/documentation/devicemanagement/contentcachinginformationresponse/statusresponse?changes=latest_minor

AssetCacheManagerUtil status -j &>/dev/null | jq '.result.Active'  
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.ActualCacheUsed'  
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheDetails.iCloud' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheDetails."iOS Software"'  
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheDetails."Mac Software"'   
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheDetails.Other' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheFree' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheUsed'  
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.CacheLimit' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.MaxCachePressureLast1Hour' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.TotalBytesReturnedToClients' 
AssetCacheManagerUtil status -j &>/dev/null | jq '.result.TotalBytesStoredFromOrigin' 

