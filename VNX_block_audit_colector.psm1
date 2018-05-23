#
# Colector script for VNX Block Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#
#
        

    
   $CSVFile =   "C:\storage_report\DEV\VNX\Audit_script\blocktools\spdevicessysadmin.csv"

  #Date

	$date = Get-Date
	$date = $date.ToString("yyyy-MM-dd")

#create date folder
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
New-Item -ItemType Directory -Path "C:\storage_report\DEV\VNX\Audit_script\outputblock\raw\$((Get-Date).ToString('yyyy-MM-dd'))"

#Root Folder

$destination = "C:\storage_report\DEV\VNX\Audit_script\outputblock\raw\$date"

    #Start network info function
function getnetworkinfoblock {
			
 $devices = Import-Csv $CSVFile 
        foreach ($vnx in $devices) {
            $arrayName = $vnx.System
            $passwd    = $vnx.password -replace {"$","`$"}
            Write-Host "Working with" $arrayName "Network Information"
            
           
            $navissecnetwork =  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0 networkadmin -get          
            $output0 = "Hostname:"
            $output1 =  $arrayName
            $output2 = "Info"  
            $output3 =  $navissecnetwork
            Write-Output $output0 | Out-File $destination\networkblock.txt -Append
            Write-Output $output1 | Out-File $destination\networkblock.txt -Append
            Write-Output $output2 | Out-File $destination\networkblock.txt -Append
            Write-Output $output3 | Out-File $destination\networkblock.txt -Append
    }
}
	#End function

	#Start ntp info function
function getntpinfoblock {
    
$devices = Import-Csv $CSVFile 
      foreach ($vnx in $devices) {
          $arrayName = $vnx.System
          $passwd    = $vnx.password -replace {"$","`$"}
          Write-Host "Working with" $arrayName "NTP Information"
          
         
          $navissecntp =  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0 ntp -list -all          
          $output0 = "Hostname:"
          $output1 =  $arrayName
          $output2 = "Info"  
          $output3 =  $navissecntp
          Write-Output $output0 | Out-File $destination\ntpinfoblock.txt -Append
          Write-Output $output1 | Out-File $destination\ntpinfoblock.txt -Append
          Write-Output $output2 | Out-File $destination\ntpinfoblock.txt -Append
          Write-Output $output3 | Out-File $destination\ntpinfoblock.txt -Append 
      }

    }
	#End function

	#Start security info function
function getsecurityinfo {
      $devices = Import-Csv $CSVFile 
      foreach ($vnx in $devices) {
          $arrayName = $vnx.System
          $passwd    = $vnx.password -replace {"$","`$"}
          Write-Host "Working with" $arrayName "Scurity Ldap Comand"
          
         
          $navissecsecurity =  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0 Security -ldap -listserver        
          $output0 = "Hostname:"
          $output1 =  $arrayName
          $output2 = "Info"  
          $output3 =  $navissecsecurity
          Write-Output $output0 | Out-File $destination\securityinfo.txt -Append
          Write-Output $output1 | Out-File $destination\securityinfo.txt -Append
          Write-Output $output2 | Out-File $destination\securityinfo.txt -Append
          Write-Output $output3 | Out-File $destination\securityinfo.txt -Append
         }
        }
	#End function

	#Start version info function
function getinforevision {
              $devices = Import-Csv $CSVFile 
              foreach ($vnx in $devices) {
                  $arrayName = $vnx.System
                  $passwd    = $vnx.password -replace {"$","`$"}
                  Write-Host "Working with" $arrayName "inforevisionblock"
                  
                 
                  $naviinforevision=  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0  getall -host        
                  $output0 = "Hostname:"
                  $output1 =  $arrayName
                  $output2 = "Info"  
                  $output3 =  $naviinforevision
                  Write-Output $output0 | Out-File $destination\revisioninfo.txt -Append
                  Write-Output $output1 | Out-File $destination\revisioninfo.txt -Append
                  Write-Output $output2 | Out-File $destination\revisioninfo.txt -Append
                  Write-Output $output3 | Out-File $destination\revisioninfo.txt -Append  
              }
            } 
	#End function

	#Start esrs info function
function getesrsconfig {
                  $devices = Import-Csv $CSVFile 
                  foreach ($vnx in $devices) {
                      $arrayName = $vnx.System
                      $passwd    = $vnx.password -replace {"$","`$"}
                      Write-Host "Working with" $arrayName "esrsconfigblock"
                      
                     
                      $naviinfoesrsconfig=  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0  esrsconfig -agentstatus       
                      $output0 = "Hostname:"
                      $output1 =  $arrayName
                      $output2 = "Info"  
                      $output3 =  $naviinfoesrsconfig
                      Write-Output $output0 | Out-File $destination\esrsconfig.txt -Append
                      Write-Output $output1 | Out-File $destination\esrsconfig.txt -Append
                      Write-Output $output2 | Out-File $destination\esrsconfig.txt -Append
                      Write-Output $output3 | Out-File $destination\esrsconfig.txt -Append  
                  }
                }
	#End function

	#Start security info function
function getsecuredatablock {
                      $devices = Import-Csv $CSVFile 
                      foreach ($vnx in $devices) {
                          $arrayName = $vnx.System
                          $passwd    = $vnx.password -replace {"$","`$"}
                          Write-Host "Working with" $arrayName "securedata"
                          
                         
                          $securedatablock=  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0  securedata -feature -info    
                          $output0 = "Hostname:"
                          $output1 =  $arrayName
                          $output2 = "Info"  
                          $output3 =  $securedatablock
                          Write-Output $output0 | Out-File $destination\securedata.txt -Append
                          Write-Output $output1 | Out-File $destination\securedata.txt -Append
                          Write-Output $output2 | Out-File $destination\securedata.txt -Append
                          Write-Output $output3 | Out-File $destination\securedata.txt -Append  
                      }
                    }
	#End function

	#Start environment info function
function getenvironment {
                          $devices = Import-Csv $CSVFile 
                          foreach ($vnx in $devices) {
                              $arrayName = $vnx.System
                              $passwd    = $vnx.password -replace {"$","`$"}
                              Write-Host "Working with" $arrayName "environment"
                              
                             
                              $environment =  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0  environment -list -all    
                              $output0 = "Hostname:"
                              $output1 =  $arrayName
                              $output2 = "Info"  
                              $output3 =  $environment
                              Write-Output $output0 | Out-File $destination\infoenvironment.txt -Append
                              Write-Output $output1 | Out-File $destination\infoenvironment.txt -Append
                              Write-Output $output2 | Out-File $destination\infoenvironment.txt -Append
                              Write-Output $output3 | Out-File $destination\infoenvironment.txt -Append  
                          }
                        }
	#End function

	#Start getcrus info function
function getcrus {
     $devices = Import-Csv $CSVFile 
     foreach ($vnx in $devices) {
     $arrayName = $vnx.System
     $passwd    = $vnx.password -replace {"$","`$"}
     Write-Host "Working with" $arrayName "Crus Command"
     $getcrus =  C:\storage_report\DEV\Navisphere\NaviSECCli.exe -address $vnx.IP -user $vnx.user -password $passwd -scope 0  getcrus -all    
     $output0 = "Hostname:"
     $output1 =  $arrayName
     $output2 = "Info"  
     $output3 =  $getcrus
     Write-Output $output0 | Out-File $destination\getcrus.txt -Append
     Write-Output $output1 | Out-File $destination\getcrus.txt -Append
     Write-Output $output2 | Out-File $destination\getcrus.txt -Append
     Write-Output $output3 | Out-File $destination\getcrus.txt -Append  
     }                        
    }
	#End function
    
	#Start Audit function
function start_block_audit {
    
	getnetworkinfoblock
   	getntpinfoblock
	getsecurityinfo
    getesrsconfig
    getsecuredatablock
    getenvironment
	getcrus
    getinforevision
	}
	#End function

