#############################################################################################
#
# Program to create a new BIOS policy on a domain and apply them according to best practices to all service profiles#
#############################################################################################
#.NOTES
#	Author: Vishwajeeth Mandalika
#	Email: vmadalik@cisco.com
#	Company: Cisco Systems, Inc.
#	Disclaimer: Code provided as-is.  No warranty implied or included.  This code is for example use only and not for production until tested and approved by customer. 
#
#############################################################################################
# Clearing Previous CLI and Importing modules#
Clear
Import-Module Cisco.UCSManager

# Connecting to UCS IP
Write-host "Connecting to Ip:"
$ucsip = read-host "enter the UCSM IP"
Connect-Ucs $ucsip

#Creating a BIOS POlicy for servers
Start-UcsTransaction
         $mo = Get-UcsOrg -Level root  | Add-UcsBiosPolicy -ModifyPresent  -Descr "BIOS POLICY FOR BLADES" -Name "ESXi_BIOS_2023" -PolicyOwner "local" -RebootOnUpdate "no" ##check naming convention.
         $mo_10 = $mo | Set-UcsBiosVfCoreMultiProcessing -VpCoreMultiProcessing "all"
         $mo_11 = $mo | Set-UcsBiosVfCPUHardwarePowerManagement -VpCPUHardwarePowerManagement "platform-default"  #platform default is recommended
         $mo_12 = $mo | Set-UcsBiosVfCPUPerformance -VpCPUPerformance "enterprise" #enterprise is recommended
         $mo_14 = $mo | Set-UcsBiosVfDirectCacheAccess -VpDirectCacheAccess "enabled" #enabled is recommended.
         $mo_15 = $mo | Set-UcsBiosVfDRAMClockThrottling -VpDRAMClockThrottling "performance" #performance is recommended
         $mo_18 = $mo | Set-UcsBiosEnhancedIntelSpeedStep -VpEnhancedIntelSpeedStepTech "enabled" #enabled is recommended
         $mo_21 = $mo | Set-UcsBiosVfFrequencyFloorOverride -VpFrequencyFloorOverride "enabled" #enabled is recommended
         $mo_26 = $mo | Set-UcsBiosHyperThreading -VpIntelHyperThreadingTech "enabled" #enabled is recommended
         $mo_28 = $mo | Set-UcsBiosTurboBoost -VpIntelTurboBoostTech "enabled" #enabled is recommended
         $mo_29 = $mo | Set-UcsBiosVfIntelVirtualizationTechnology -VpIntelVirtualizationTechnology "enabled" #enabled is recommended
         $mo_30 = $mo | Set-UcsBiosIntelDirectedIO -VpIntelVTDATSSupport "platform-default" -VpIntelVTDCoherencySupport "platform-default" -VpIntelVTDInterruptRemapping "platform-default" -VpIntelVTDPassThroughDMASupport "platform-default" -VpIntelVTForDirectedIO "enabled" #this is the correct combination.
         $mo_38 = $mo | Set-UcsBiosLvDdrMode -VpLvDDRMode "performance-mode" #performance mode is recommended
         $mo_43 = $mo | Set-UcsBiosNUMA -VpNUMAOptimized "enabled" #Enabled is recommended
         $mo_50 = $mo | Set-UcsBiosVfPackageCStateLimit -VpPackageCStateLimit "platform-default" #platform-default is recommended. But disable C-states. 
         $mo_56 = $mo | Set-UcsBiosVfProcessorC1E -VpProcessorC1E "disabled" #disabled in recommended
         $mo_57 = $mo | Set-UcsBiosVfProcessorC3Report -VpProcessorC3Report "disabled" #disabled is recommended
         $mo_58 = $mo | Set-UcsBiosVfProcessorC6Report -VpProcessorC6Report "disabled"  #disabled is recommended
         $mo_59 = $mo | Set-UcsBiosVfProcessorC7Report -VpProcessorC7Report "disabled" #disabled is recommended
         $mo_60 = $mo | Set-UcsBiosVfProcessorCMCI -VpProcessorCMCI "disabled" 
         $mo_61 = $mo | Set-UcsBiosVfProcessorCState -VpProcessorCState "disabled" #disabled in recommended
         $mo_62 = $mo | Set-UcsBiosVfProcessorEnergyConfiguration -VpEnergyPerformance "performance" -VpPowerTechnology "performance" #performance is recommended
         $mo_63 = $mo | Set-UcsBiosVfProcessorPrefetchConfig -VpAdjacentCacheLinePrefetcher "enabled" -VpDCUIPPrefetcher "enabled" -VpDCUStreamerPrefetch "enabled" -VpHardwarePrefetcher "enabled"  #enabled is recommended
         $mo_65 = $mo | Set-UcsBiosVfQPILinkFrequencySelect -VpQPILinkFrequencySelect "platform-default" 
         $mo_67 = $mo | Set-UcsBiosVfQuietBoot -VpQuietBoot "disabled" 
         $mo_69 = $mo | Set-UcsBiosVfResumeOnACPowerLoss -VpResumeOnACPowerLoss "last-state"
         $mo_73 = $mo | Set-UcsBiosVfSelectMemoryRASConfiguration -VpSelectMemoryRASConfiguration "maximum-performance"  #maximum performance is recommended
         $mo_74 = $mo | Set-UcsBiosVfSerialPortAEnable -VpSerialPortAEnable "disabled" 
         $mo_83 = $mo | Set-UcsBiosVfUSBPortConfiguration -VpPort6064Emulation "platform-default" -VpUSBPortFront "disabled" -VpUSBPortInternal "platform-default" -VpUSBPortKVM "platform-default" -VpUSBPortRear "disabled" -VpUSBPortSDCard "disabled" -VpUSBPortVMedia "platform-default"
Complete-UcsTransaction  -force #| Out-File $LogFile -Append -Encoding ASCII

Start-UcsTransaction
Set-UcsBiosPolicy -BiosPolicy $mo.Name -RebootOnUpdate yes
Complete-UcsTransaction -force


foreach ($x in Get-UcsServer |select model, AssignedToDn,Association,Dn |Where-Object Association -eq associated)
{
$y=Get-ucsserviceprofile -Dn $x.AssignedtoDn
write-host $y.Name
#changing the BIOS policy.
Start-UCstransaction
Set-Ucsserviceprofile -ServiceProfile $y.Name -BIOSProfileName ESXi_BIOS_2021
Complete-ucstransaction -force
}

#Disconnecting UCS.
Disconnect-Ucs                 