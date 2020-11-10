##################################################################################################################
# Program to check the various parameters in BIOS policy of a domain and disable them according to best practices#
##################################################################################################################
##############################################
# Clearing Previous CLI and Importing modules#
##############################################
Clear
Import-Module Cisco.UCSManager

#######################################################################
# Connecting to UCSM from a CSV file                                  #
#CSV file format is VIP (Column1),username(Column2),password (Column3)#
#######################################################################
$csv = Import-csv "C:\Users\vmadalik\Downloads\PowerShell & Python\ucslist.csv"

Foreach($row in $csv) 
{ 
$ucsvip= $row.vip
$user =$row.username
$password = $row.password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($user,$password)

Write-host "Connecting to Ip: $ucsvip"
Connect-Ucs $ucsvip -Credential $cred

    #####################
    #Getting BIOS policy#
    #####################
    Foreach ($x in Get-UcsBiosPolicy| Select Name,Dn,Rn,Ucs)
    {
      Write-host "entering for BIOS policy loop"

$Qb =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfQuietBoot)  
$Pep  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfPOSTErrorPause)
$Rpl  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfResumeOnACPowerLoss)
$Fpl  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfFrontPanelLockout)
$Tb  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosTurboBoost)
$Iss  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosEnhancedIntelSpeedStep)
$ht  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosHyperThreading)
$vmp  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfCoreMultiProcessing)
$edb  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosExecuteDisabledBit)
$vt  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfIntelVirtualizationTechnology)
$dca  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfDirectCacheAccess)
$pc  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorCState)
$pc1e  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC1E)
$pc3r  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC3Report)
$pc6r  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC6Report)
$pc7r=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC7Report)
$cpuper=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfCPUPerformance)
$mvmttr=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfMaxVariableMTRRSetting)
$idio=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosIntelDirectedIO)
$memras=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfSelectMemoryRASConfiguration)
$numa=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosNUMA)
$lvdrm=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosLvDdrMode)
$usbboot=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfUSBBootConfig)
$usbfpal=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfUSBFrontPanelAccessLock)
$usbsipos=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfUSBSystemIdlePowerOptimizingSetting)
$mmb4=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfMaximumMemoryBelow4GB)
$mmioa4=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfMemoryMappedIOAbove4GB)
$bor=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfBootOptionRetry)
$iesaraidm=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfIntelEntrySASRAIDModule)
$osbwdt=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfOSBootWatchdogTimer)
$oswdtt=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfOSBootWatchdogTimerTimeout)
      
                   
   $output = New-Object -TypeName psobject -property @{
                'Name_of_BIOS_Policy' = $x.Name
                'Ucs'  =$x.Ucs
                'QuietBoot' =$Qb.VpQuietBoot  
                'POST ERROR PAUSE'=$Pep.VpPOSTErrorPause
                'ResumeACPowerLoss'=$Rpl.VpResumeOnACPowerLoss
                'FrontPanel Lockout'=$Fpl.VpFrontPanelLockout
                'TurboBoost'=$Tb.VpIntelTurboBoostTech
                'EnhancedIntelSpeedStep' =$Iss.VpEnhancedIntelSpeedStepTech
                'Hyper threading' =$ht.VpIntelHyperThreadingTech
                'Core Multi Processing' =$vmp.VpCoreMultiProcessing
                'Execute disable bit'=$edb.VpExecuteDisableBit
                'Virtualization Technology'=$vt.VpIntelVirtualizationTechnology
                'Direct Cache Access'=$dca.VpDirectCacheAccess
                'Processor C State' =$pc.VpProcessorCState
                'Processor C1E' =$pc1e.VpProcessorC1E
                'Processor C3 report' =$pc3r.VpProcessorC3Report
                'Processor C6 Report'=$pc6r.VpProcessorC6Report
                'Processor C7 Report' = $pc7r.VpProcessorC7Report
                'CPU Performance' = $cpuper.VpCPUPerformance
                'Max Variable MTRR Setting' = $mvmttr.VpProcessorMtrr
                'IntelVTDATSSupport' = $idio.VpIntelVTDATSSupport
                'IntelVTDCoherencySupport'=$idio.VpIntelVTDCoherencySupport
                'VpIntelVTDInterruptRemapping'= $idio.VpIntelVTDInterruptRemapping
                'IntelVTDPassThroughDMASupport'=$idio.VpIntelVTDPassThroughDMASupport
                'IntelVTForDirectedIO'=$idio.VpIntelVTForDirectedIO
                'Select Memory RAS Configuration' = $memras.VpSelectMemoryRASConfiguration
                'NUMA' = $numa.VpNUMAOptimized
                'LvDdr Mode' = $lvdrm.VpLvDDRMode
                'USB legacy Boot' = $usbboot.VpLegacyUSBSupport
                'USB-Make NonBootable' = $usbboot.VpMakeDeviceNonBootable
                'USB Front Panel Access Lock' = $usbfpal.VpFrontPanelLockout
                'USB System Idle Power Optimizing Setting' = $usbsipos.VpUSBIdlePowerOptimizing
                'Maximum Memory Below 4GB' = $mmb4.VpMaximumMemoryBelow4GB
                'Memory Mapped IO Above 4GB' = $mmioa4.VpMemoryMappedIOAbove4GB
                'Boot Option Retry' = $bor.VpBootOptionRetry
                'Intel Entry SAS RAID' = $iesaraidm.VpSASRAID
                'Intel Entry SAS RAID Module'=$iesaraidm.VpSASRAIDModule
                'OS Boot Watchdog Timer' = $osbwt.VpOSBootWatchdogTimer
                'OS Boot Watchdog Timer Timeout Policy' =$oswdtt.VpOSBootWatchdogTimerTimeout

        } 

        ###############################
        #Output Exporting to CSV File#
        ###############################
     
   $output| Export-csv -append -force ".\Temp.csv"        
    }

###################
#Disconnecting UCS#
###################
 Disconnect-Ucs
 write-host "Job Complete and Disconnecting Ip:" $ucsvip
 }


    