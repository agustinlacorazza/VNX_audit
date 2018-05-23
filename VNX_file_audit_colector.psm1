# Colector script for VNX File Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#

Import-Module C:\storage_report\DEV\VNX\Audit_script\Main_Script\RepTools.psm1 -Force


function Main_process_audit{

    Param (
        [string]$CredentialsFile
    )

	#Date

	$date = Get-Date
	$date = $date.ToString("yyyy-MM-dd")

#create date folder

New-Item -ItemType Directory -Path "C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$((Get-Date).ToString('yyyy-MM-dd'))"


    #Start bash scraping
    $Ipinfoscript = "C:\storage_report\DEV\VNX\Audit_script\Main_Script\bashscript\ipinfoscript.sh"
    $dnsinfoscript = "C:\storage_report\DEV\VNX\Audit_script\Main_Script\bashscript\dnsinformation.sh"
    $mtuinformation = "C:\storage_report\DEV\VNX\Audit_script\Main_Script\bashscript\mtuinformation.sh"
    $serverparaminformation = "C:\storage_report\DEV\VNX\Audit_script\Main_Script\bashscript\serverparaminformation.sh"
    $smtpinformation = "C:\storage_report\DEV\VNX\Audit_script\Main_Script\bashscript\smtpinformation.sh"
    #End bash scraping
    $Output  = @()
    $Systems = Import-Csv $CredentialsFile
    $rootfolder = "C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date"
    
    


 #Obtain the Ip information

  foreach ($vnx in $Systems) {

        Write-Host "Getting info from" $vnx.System
	      $passwd = $vnx.password -replace {"$","`$"}
        $ssh1  = Invoke-Plink -ipa $vnx.IP -usr $vnx.user -pw $passwd -m $Ipinfoscript
        Write-Host " Dumping Network Basic Information"
        $Output1 += $ssh1
        $temp = $rootfolder + "\IP_info_all.txt"
        Write-Output $Output1 | Out-File $temp
        }

	


    #Obtain the DNS  information
    foreach ($vnx in $Systems) 
    {
        Write-Host "Getting info from" $vnx.System
         $passwd = $vnx.password -replace {"$","`$"}
           $ssh2  = Invoke-Plink -ipa $vnx.IP -usr $vnx.user -pw $passwd -m $dnsinfoscript
         Write-Host " Dumping Full DNS Information"
         $Output2 += $ssh2
         $temp = $rootfolder + "\DNS_info_all.txt"
         Write-Output $Output2 | Out-File $temp
     }


        #Obtain the MTU  information
     foreach ($vnx in $Systems) {

            Write-Host "Getting info from" $vnx.System
            $passwd = $vnx.password -replace {"$","`$"}
            $ssh3 = Invoke-Plink -ipa $vnx.IP -usr $vnx.user -pw $passwd -m $mtuinformation
            Write-Host " Dumping MTU Information"
            $Output3 += $ssh3
            $temp = $rootfolder + "\MTU_info_all.txt"
            Write-Output $Output3 | Out-File $temp
            }
		

        # Obtain the server param  information
     foreach ($vnx in $Systems) {

                 Write-Host "Getting info from" $vnx.System
                 $passwd = $vnx.password -replace {"$","`$"}
                 $ssh4 = Invoke-Plink -ipa $vnx.IP -usr $vnx.user -pw $passwd -m $serverparaminformation
                 Write-Host " Dumping Server param Information"
                 $Output4 += $ssh4
                 $temp = $rootfolder + "\serverparaminfo.txt"
                 Write-Output $Output4 | Out-File $temp
                 }

                 

	#Obtain SMTP Information
     foreach ($vnx in $Systems) {

        Write-Host "Getting info from" $vnx.System
        $passwd = $vnx.password -replace {"$","`$"}
        $ssh5 = Invoke-Plink -ipa $vnx.IP -usr $vnx.user -pw $passwd -m $smtpinformation    
        Write-Host " Dumping SMTP"
        $Output5 += $ssh5
        $temp = $rootfolder + "\smtpinfo.txt"
        Write-Output $Output5 | Out-File $temp
        }
	
	
}


function start_file_audit {
Clear-Host
$OutPut = Main_process_audit -CredentialsFile "C:\storage_report\DEV\VNX\Audit_script\Main_Script\devices\nasdevs2.txt"
	Write-Host $OutPut

}


