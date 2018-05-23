# Parsing script for VNX File Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#

#Date check

$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
Clear-Host
#create date folder 

New-Item -ItemType Directory -Path "C:\storage_report\DEV\VNX\Audit_script\outputfile\parsed\$((Get-Date).ToString('yyyy-MM-dd'))"
# Content information


$infoserverparam = Get-Content C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date\serverparaminfo.txt
$infodns = Get-Content C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date\DNS_info_all.txt
$infomtu = Get-Content C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date\MTU_info_all.txt
$infoip = Get-Content C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date\IP_info_all.txt
$infosmtp = Get-Content C:\storage_report\DEV\VNX\Audit_script\outputfile\raw\$date\smtpinfo.txt
$finalpatch = "C:\storage_report\DEV\VNX\Audit_script\outputfile\parsed\$date"



# Start parse server param function
function parse_server_param {
   
Write-Output "Date,Hostname,version,info Server, data stream default/current/configured, infomaxprotocolversion default/current/configured, infoscsiReserve default/current/configured, infodhsmpassthrough default/current/configured, infoCDBF default/current/configured, infoincludeCKptFs default/current/configured, Infomd5 default/current/configured, infosnaptimeout default/current/configured, infodialect default/current/configured, Infoforcerevursive default/current/configured, infoexcludesvtlfs default/current/configured,infotapesilveringstr default/current/configured,infoportrange default/current/configured,infosnapsure default/current/configured,infov4oldtapecompatible default/current/configured" | Out-File $finalpatch\serverparamparsed.txt -Encoding ASCII

$content = ($infoserverparam -split "`n") 

For($i=0;$i -lt $content.count;$i++)
{
 if($content[$i] -match "Hostname:")
    {
     #Output the previous record
      Write-Host "$infohostname,$infoserver,$infodtastreams,$infomaxProtocolVersion,$infoscsiReserve,$infoDHSMPassthrough,$infoCDBFsinfoBufSizeInKB,$infoincludeCkptFs,$infomd5, $infosnapTimeout, $infodialect,$infoforceRecursiveForNonDAR,$infoexcludeSvtlFs,$infotapeSilveringStr,$infoportRange,$infosnapsure,$infov4OldTapeCompatible"
      #Storage outtheloop   
      Write-Output "$date,$infohostname,$infoserver,$infodtastreams,$infomaxProtocolVersion,$infoscsiReserve,$infoDHSMPassthrough,$infoCDBFsinfoBufSizeInKB,$infoincludeCkptFs,$infomd5, $infosnapTimeout, $infodialect,$infoforceRecursiveForNonDAR,$infoexcludeSvtlFs,$infotapeSilveringStr,$infoportRange,$infosnapsure,$infov4OldTapeCompatible" | Out-File $finalpatch\serverparamparsed.txt -Append  -Encoding ASCII         
      #"Hostname Information"
      $infohostname = $content[$i+1]
    }

 elseif($content[$i] -match "server_")
    {
     #"Hostname Information"
      $infoserver = $content[$i+0]
    }
 elseif($content[$i] -match "concurrentDataStreams")
    {
     #"Hostname Information"
      $infodtastreams = $content[$i+0]
    }
 elseif($content[$i] -match "maxProtocolVersion")
    {
     #"Hostname Information"
      $infomaxProtocolVersion = $content[$i+0]
    }
 elseif($content[$i] -match "scsiReserve")
    {
       #"Hostname Information"
        $infoscsiReserve = $content[$i+0]
    }
 elseif($content[$i] -match "DHSMPassthrough")
    {
     #"Hostname Information"
     $infoDHSMPassthrough = $content[$i+0]
    }
 elseif($content[$i] -match "CDBFsinfoBufSizeInKB")
    {
        #"Hostname Information"
        $infoCDBFsinfoBufSizeInKB = $content[$i+0]
    }
 elseif($content[$i] -match "includeCkptFs")
    {
        #"Hostname Information"
        $infoincludeCkptFs = $content[$i+0]
    }
 elseif($content[$i] -match "md5")
    {
        #"Hostname Information"
        $infomd5 = $content[$i+0]
    }
 elseif($content[$i] -match "snapTimeout")
    {
        #"Hostname Information"
        $infosnapTimeout = $content[$i+0]
    }
 elseif($content[$i] -match "dialect")
    {
        #"Hostname Information"
        $infodialect = $content[$i+0]
    }
 elseif($content[$i] -match "forceRecursiveForNonDAR")
    {
        #"Hostname Information"
        $infoforceRecursiveForNonDAR = $content[$i+0]
    }
 elseif($content[$i] -match "excludeSvtlFs")
    {
        #"Hostname Information"
        $infoexcludeSvtlFs = $content[$i+0]
    } 
 elseif($content[$i] -match "tapeSilveringStr")
    {
        #"Hostname Information"
        $infotapeSilveringStr = $content[$i+0]
    }
 elseif($content[$i] -match "portRange")
    {
        #"Hostname Information"
        $infoportRange = $content[$i+0]
    }
 elseif($content[$i] -match "snapsure")
    {
        #"Hostname Information"
        $infosnapsure = $content[$i+0]
    }
 elseif($content[$i] -match "v4OldTapeCompatible")
    {
        #"Hostname Information"
        $infov4OldTapeCompatible = $content[$i+0]
    }
}

}
#End Function

#Start Parse DNS Function
function parse_dns_info {

Write-Output "Date,Hostname,Version,Status DNS, DNS Info," | Out-File $finalpatch\dnsinfoparsed.txt -Encoding ASCII
$content = ($infodns -split "`n") 

For($i=0;$i -lt $content.count;$i++)
{
    if($content[$i] -match "Hostname:")
    {
        #Output the previous record
        Write-Host "$infohost,$statusdns,$infoiface" 
        #Storage outtheloop   
        Write-Output "$date,$infohost,$statusdns,$infoiface"  | Out-File $finalpatch\dnsinfoparsed.txt -Append  -Encoding ASCII         
        #"Hostname Information"
        $infohost = $content[$i+1]
    }

    elseif($content[$i] -match "running")
    {
        #"DNS Alive ?"
        $statusdns = ($content[$i]  -split "=")[0]
    }

    elseif($content[$i] -match "net")
    {
        #"Iface Net "
        $infoiface = ($content[$i] -split "=")[0]
    }
    
    }
	
}
# End Function
 
#Start parse MTU function
function parse_MTU_info {

Write-Output "Date,Hostname,Version,Status iface, Macaddr,MTU conf,Lan" | Out-File $finalpatch\outputmtu.txt -Encoding ASCII

$i = 0
$content = ($infomtu -split "`n") 

For($i=0;$i -lt $content.count;$i++)
{

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
        Write-Host "$infohostname,$status,$macadd,$mtu"
        #Storage outtheloop   
        Write-Output "$date,$infohostname,$status,$macadd,$mtu" | Out-File $finalpatch\outputmtu.txt -Append  -Encoding ASCII         
        #"Hostname Information"
        $infohostname = $content[$i+1]
    } 
elseif($content[$i] -match "UP")
    {
    $status = ($content[$i] -split ",")[0]
    }  
if($content[$i] -match "MTU")
    {
    $macadd = ($content[$i] -split "=")[3]
    }
if($content[$i] -match "MTU")
    {
    $mtu = ($content[$i] -split "=")[1]
    }
   }
}
# End Function

#Start Parse IP Function
function parse_IP_info {

Clear-Host




Write-Output "Date, Hostname,version, IP Info, Netmask, Gateway, DNS 1,DNS2,DNS3 " | Out-File $finalpatch\outputip.txt -Encoding ASCII

    # "Network Information VNX"
$content = ($infoip -split "`n") 

For($i=0;$i -lt $content.count;$i++){

    if($content[$i] -match "Hostname:")
    {
		Write-Host "$infohostname,$infoipv4,$infonetmask,$gatewayinfo,$dnsinfo,$date"
		Write-Output "$date,$infohostname,$infoipv4,$infonetmask,$gatewayinfo,$dnsinfo" | Out-File $finalpatch\outputip.txt -Append  -Encoding ASCII
        #"Hostname Information"
        $infohostname = $content[$i+1]
    }
  
    elseif($content[$i] -match "IPv4 Address")
    {
        #"Ipv4 Address"
        $infoipv4 = ($content[$i]  -split "=")[1]
    }
    elseif($content[$i] -match "IPv4 Netmask")
    {
        #"Netmask Information"
        $infonetmask = ($content[$i] -split "=")[1]
    }
    elseif($content[$i] -match "IPv4 Gateway")
    {
        #"Gateway Information"
        $gatewayinfo = ($content[$i] -split "=")[1]
    }
    elseif($content[$i] -match "DNS Servers")
    {
       # "DNS Servers Information"
        $dnsinfo = ($content[$i] -split "=")[1]
    }
     
    
}


}
# End Function

#Start Prase SMTP Function

function parse_smtp {

	Write-Output "Date,Hostname,version,Email Server,Email IP Protocol,Service Enabled,Subject Prefix,Sender Address,Recipient Address 1, Recipient Address 2,Recipient Address 3,Recipient Address 4"| Out-File $finalpatch\outputsmtp.txt -Encoding ASCII

    # "Network Information VNX"
$content = ($infosmtp -split "`n") 

For($i=0;$i -lt $content.count;$i++){

    if($content[$i] -match "Hostname:")
    {
		Write-Host "$date,$infohostname,$infoipserver,$infoemailprotocol,$infoserviceenabled,$infosender,$inforecipient,$prefix"
		Write-Output "$date,$infohostname,$infoipserver,$infoemailprotocol,$infoserviceenabled,$prefix,$infosender,$inforecipient" | Out-File $finalpatch\outputsmtp.txt -Append  -Encoding ASCII
        #"Hostname Information"
        $infohostname = $content[$i+1]
    }
  
    elseif($content[$i] -match "Sender Address")
    {
        #"Ipv4 Address"
        $infosender = ($content[$i]  -split "=")[1]
    }

     elseif($content[$i] -match "Recipient Address")
    {
        #"Ipv4 Address"
        $inforecipient = ($content[$i]  -split "=")[1]
    }

      elseif($content[$i] -match "Email Server")
    {
        #"Ipv4 Address"
        $infoipserver= ($content[$i]  -split "=")[1]
    }

	   elseif($content[$i] -match "Email IP Protocol")
    {
        #"Ipv4 Address"
        $infoemailprotocol= ($content[$i]  -split "=")[1]
    }

	   elseif($content[$i] -match "Service Enabled")
    {
        #"Ipv4 Address"
        $infoserviceenabled= ($content[$i]  -split "=")[1]
    }
 elseif($content[$i] -match "Subject Prefix")
    {
        #"Ipv4 Address"
        $prefix= ($content[$i]  -split "=")[1]
    }	   

}
	}

function start_parse {

parse_server_param
parse_MTU_info
parse_dns_info
parse_IP_info
parse_smtp
	}

start_parse