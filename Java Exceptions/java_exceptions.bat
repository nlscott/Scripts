
@echo off

SET site_path="C:\Users\%USERNAME%\AppData\LocalLow\Sun\Java\Deployment\security\exception.sites"


SET /P site=Enter what site you want to exempt:


echo %site% >> %site_path%


