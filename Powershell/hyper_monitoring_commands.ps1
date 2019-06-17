# list all vms on host and status
Get-VM 

# Enable-VMResourceMetering: Collects resource utilization data for a virtual machine or resource pool
Get-VM -Name vmname | Enable-VMResourceMetering




#list if vms are enabled
Get-VM | Format-Table Name, State, ResourceMeteringEnabled




#CPU
(get-counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue
(get-counter '\Processor(_Total)\% Privileged Time').CounterSamples[0].CookedValue


#DISK
(get-counter '\PhysicalDisk(0 C:)\Disk Read Bytes/sec').CounterSamples[0].CookedValue
(get-counter '\PhysicalDisk(0 C:)\Disk Write Bytes/sec').CounterSamples[0].CookedValue



# get available Memory
(get-counter '\Memory\Available Mbytes').CounterSamples[0].CookedValue

# for vms
(get-counter '\Hyper-V Dynamic Memory VM(XPHV)\Average Pressure').CounterSamples[0].CookedValue


# This command below will gauge the number of VMs that are currently running or turned off.
(get-counter '\Hyper-V Virtual Machine Summary\Running').CounterSamples[0].CookedValue
(get-counter '\Hyper-V Virtual Machine Summary\Turned Off').CounterSamples[0].CookedValue
