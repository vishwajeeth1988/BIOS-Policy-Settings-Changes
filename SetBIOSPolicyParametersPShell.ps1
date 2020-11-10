##################################################################################################################
# Program to set the various parameters in BIOS policy of a domain and disable them according to best practices#
##################################################################################################################
##############################################
# Clearing Previous CLI and Importing modules#
##############################################
Clear
Import-Module Cisco.UCSManager

#####################################################
#NEW FUNCTION########################################
#####################################################
 function UpdateBIOS {
    write-host "We are now starting the update" $args[0]
    Foreach ($x in Get-UcsBiosPolicy| Select Name,Dn,Rn,Ucs)
    {
      Write-host "entering for BIOS policy loop"

$Qb =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfQuietBoot)  
$Pep  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfPOSTErrorPause)
$Rpl  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfResumeOnACPowerLoss)
$Fpl =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfFrontPanelLockout)
$Tb  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosTurboBoost)
		if( $Tb.VpIntelTurboBoostTech -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ##########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  enabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$Iss  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosEnhancedIntelSpeedStep)
		if( $Iss.VpEnhancedIntelSpeedStepTech -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  enabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$ht  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosHyperThreading)
		if($ht.VpIntelHyperThreadingTech  -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  enabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$vmp  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfCoreMultiProcessing)		
$edb  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosExecuteDisabledBit)
$vt  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfIntelVirtualizationTechnology)
		if( $vt.VpIntelVirtualizationTechnology -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  enabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$dca  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfDirectCacheAccess)
		if( $dca.VpDirectCacheAccess -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  enabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$pc  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorCState)
		if( $pc.VpProcessorCState -ne 'disabled') #Checking if disbaled or set to other settings#
						{                                                            
												 ##########################
												 #change status to disabled#
												 ###########################

							 #Start-UCstransaction
							 #Set-UcsBiosVFProcessorC1E -  disabled -Biospolicy $x.Name
							 #$Complete-ucstransaction
						}
$pc1e  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC1E)
		if( $pc1e.VpProcessorC1E -ne 'disabled') #Checking if disbaled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to disabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  disabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$pc3r  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC3Report)
		if( $pc3r.VpProcessorC3Report -ne 'disabled') #Checking if disbaled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to disabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  disabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$pc6r  =(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC6Report)
		if( $pc6r.VpProcessorC6Report -ne 'disabled') #Checking if disbaled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to disabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  disabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$pc7r=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfProcessorC7Report)
		if( $pc7r.VpProcessorC7Report -ne 'disabled') #Checking if disbaled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to disabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  disabled -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$cpuper=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfCPUPerformance)
		if( $cpuper.VpCPUPerformance -ne 'platform-default') #Checking if platform-default or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to platform-default#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  platform-default -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$mvmttr=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfMaxVariableMTRRSetting)
$idio=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosIntelDirectedIO)
		if( $idio.VpIntelVTForDirectedIO -ne 'enabled') #Checking if enabled or set to other settings#
                {                                                            
                                         ##########################
                                         #change status to enabled#
                                         ###########################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -   -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
$memras=(Get-UcsBiosPolicy -Name $x.Name | Get-UcsBiosVfSelectMemoryRASConfiguration)
		if( $memras.VpSelectMemoryRASConfiguration -ne ' Maximum Performance') #Checking if Maximum Performance or set to other settings#
                {                                                            
                                         ######################################
                                         #change status to Maximum Performance#
                                         ######################################

                     #Start-UCstransaction
                     #Set-UcsBiosVFProcessorC1E -  Maximum Performance -Biospolicy $x.Name
                     #$Complete-ucstransaction
                }
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

    }

####################
#Connecting to UCSM#
####################

#$ucsvip = read-host "Please enter your UCS IP address:"
$ucsvip = '10.201.27.108'
Connect-ucs $ucsvip

Write-host "Connecting to Ip: $ucsvip"


    #####################
    #Getting BIOS policy#
    #####################

    Get-ucsBiosPolicy|Select Name, Dn, Rn|format-table -autosize        
    $name= Read-host "Enter the name of the policy you would like to edit"
    Write-host "this is the policy you chose"
    Get-ucsBIosPolicy -Name $name|Select Name, Dn, Rn, UCS|format-table -autosize 

    $yn = Read-host "Are you sure you want to continue (y/n)"
    If($yn -eq 'y')
    {
     Write-host "We are now entering the update operation "
     UpdateBIOS $name
    }
    
    Elseif($yn -eq 'n')
    {
    Write-host " you chose not to edit the policy"
    }

###################
#Disconnecting UCS#
###################
 Disconnect-Ucs
 write-host "Job Complete and Disconnecting Ip:" $ucsvip


    <#

    Get list of names:
    Prints list of name
    which policy do you want to update

    then set parameters for that policy
    #>
