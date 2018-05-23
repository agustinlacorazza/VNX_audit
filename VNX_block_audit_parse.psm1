# Parsing script for VNX Block Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#
#
#
#
#Date check
#
$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
Clear-Host
#create date folder 
#
New-Item -ItemType Directory -Path "C:\storage_report\DEV\VNX\Audit_script\outputblock\parsed\$((Get-Date).ToString('yyyy-MM-dd'))"
#
#
#_Content information:
#__Directories information:
#___Dinamic Information | ¡! Only change this: 
#
$rawdirectory = "C:\storage_report\DEV\VNX\Audit_script\outputblock\raw"    # -> Input
$parseddirectory = "C:\storage_report\DEV\VNX\Audit_script\outputblock\parsed" # -> Output


#Static Information below | ¡! Don't need to change
$networkblock = Get-Content $rawdirectory\$date\networkblock.txt
$getcrus = Get-Content $rawdirectory\$date\getcrus.txt
$ntpinfoblock = Get-Content $rawdirectory\$date\ntpinfoblock.txt
$revisioninfo = Get-Content $rawdirectory\$date\revisioninfo.txt
$securityinfo = Get-Content $rawdirectory\$date\securityinfo.txt
$securedata = Get-Content $rawdirectory\$date\securedata.txt
$finalpatch = "$parseddirectory\$date"


# Start parse network block function
function parse_network_block{
   
	
Write-Output "Date,Hostname,Storage Procesor,Network Name,IP Addres,Subnet Mask,Gateway Address" | Out-File $finalpatch\networkparsed.txt -Encoding ASCII

$content = ($networkblock -split "`n") 

For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
       Write-Host $date , $infohostname ,$storageps,$network,$ipaddress,$subnet,$gateway
        #Storage outtheloop   
       Write-Output "$date,$infohostname,$storageps,$network,$ipaddress,$subnet,$gateway" | Out-File $finalpatch\networkparsed.txt -Append  -Encoding ASCII         

        #"Hostname Information"
        $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "SP") 
    {
        #"Ipv4 Address"
        $storageps = ($content[$i]  -split ":")[1] 
    }
elseif($content[$i] -match "Name")
    {
        #"Netmask Information"
        $network = ($content[$i] -split ":")[1]
    }
elseif($content[$i] -match "IP Address")
    {
        #"Gateway Information"
        $ipaddress = ($content[$i] -split ":")[1]
    }
elseif($content[$i] -match "Subnet Mask")
    {
       # "DNS Servers Information"
        $subnet = ($content[$i] -split ":")[1] 
    }
elseif($content[$i] -match "Gateway Address")
    {
       # "DNS Servers Information"
        $gateway = ($content[$i] -split ":")[1] 
    }

    
    }










}
#End Function

# Start parse Get Crus function
function parse_get_crus {

Write-Output "Date,Hostname,LCC A State,LCC B State" | Out-File $finalpatch\getcrusinfoparsed.txt -Encoding ASCII

$content = ($getcrus -split "`n")  

For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
      Write-Host $infohostname $12 $busb
      Write-Output "$date,$infohostname,$12,$busb" | Out-File $finalpatch\getcrusinfoparsed.txt -Append  -Encoding ASCII  
   
       $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "LCC A State:")
    {
        #"Ipv4 Address"
        $12 = ($content[$i+1]  -split ":")[1]
    }

elseif($content[$i] -match "LCC B State:")
    {
        #"Ipv4 Address"
        $busb = ($content[$i]  -split ":")[1]
    }


    }
}
# End Get Crus function

# Start parse NTP Info function
function parse_ntpinfoblock { 
		
Write-Output "Date,Hostname,Network Time Servers" | Out-File $finalpatch\ntpblockparsed.txt -Encoding ASCII

$content = ($ntpinfoblock -split "`n") 


For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
       Write-Host $infohostname,$address1,$addres2
        
       Write-Output "$date,$infohostname,$address1,$addres2" | Out-File $finalpatch\ntpblockparsed.txt -Append  -Encoding ASCII         
       
        #"Hostname Information"
        $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "address")
    {
        #"Ipv4 Address"
        $address1 = ($content[$i]  -split ":")[1]
    }
elseif($content[$i] -match "address")
    {
        #"Netmask Information"
        $address2 = ($content[$i] -split ":")[2]
    }
    
    }




}
# End NTP function

# Start Parse revision
function parse_revision_info {

Write-Output "Date,Hostname,Agent Rev,Node Information,Revision,Name of the software package,Revision of the software package,Commit Required,Revert Possible,Active State " | Out-File $finalpatch\revisioninfoparsed.txt -Encoding ASCII


$content = ($revisioninfo -split "`n")  

For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
      Write-Host $infohostname,$rev, $node, $revision,$namepackage,$revisionpackage,$revert,$commit,$activestate
        
      Write-Output "$date,$infohostname,$rev, $node, $revision,$namepackage,$revisionpackage,$revert,$commit,$activestate" | Out-File $finalpatch\revisioninfoparsed.txt -Append  -Encoding ASCII         
       
        #"Hostname Information"
       $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "Agent Rev:")
    {
        #"Ipv4 Address"
        $rev = ($content[$i]  -split ":")[1,2]
    }
elseif($content[$i] -match "Node:")
    {
        #"Netmask Information"
        $node = ($content[$i] -split ":")[1]
    }
        
elseif($content[$i] -match "Revision:")
    {
        #"Netmask Information"
        $revision = ($content[$i] -split ":")[1]
    }

elseif($content[$i] -match "-FASTCache")
    {
        #"Netmask Information"
        $namepackage = ($content[$i] -split ":")[1]

    }
elseif($content[$i] -match "Revision of the software package:")
    {
        #"Netmask Information"
        $revisionpackage = ($content[$i] -split ":")[1]

    }
elseif($content[$i] -match "Revert Possible:")
    {
        #"Netmask Information"
        $revert = ($content[$i] -split ":")[1]

    }

elseif($content[$i] -match "Commit Required:")
    {
        #"Netmask Information"
        $commit = ($content[$i] -split ":")[1]

    }
elseif($content[$i] -match "Active State:")
    {
        #"Netmask Information"
        $activestate = ($content[$i] -split ":")[1]

    }


    }


}
# End parse revision

#Start parse secure data
function parse_secure_data {

Write-Output "Date,Hostname,Encryption Mode,Encryption Status,Percent Encrypted" | Out-File $finalpatch\securedata.txt -Encoding ASCII


$content = ($securedata -split "`n")  

For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
      Write-Host $infohostname,$encriptionm, $encriptions, $percent
        
      Write-Output "$date,$infohostname,$encriptionm, $encriptions, $percent" | Out-File $finalpatch\securedata.txt -Append  -Encoding ASCII         
       
        #"Hostname Information"
       $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "Encryption Mode:")
    {
        #"Ipv4 Address"
        $encriptionm = ($content[$i]  -split ":")[1,2]
    }
elseif($content[$i] -match "Encryption Status:")
    {
        #"Netmask Information"
        $encriptions = ($content[$i] -split ":")[1]
    }
        
elseif($content[$i] -match "Percent Encrypted:")
    {
        #"Netmask Information"
        $percent = ($content[$i] -split ":")[1]
    }

    
    }







}
# End Secure Data

#Start parse  security info (ldap chains)
function parse_security_info {

Write-Output "Date,Hostname,Alternate Server Name,Alternate Server Protocol,UserSearchPath,GroupSearchPath " | Out-File $finalpatch\securityinfo.txt -Encoding ASCII


$content = ($securityinfo -split "`n")  

For($i=0;$i -lt $content.count;$i++){

if($content[$i] -match "Hostname:")
    {
        #Output the previous record
      Write-Host $infohostname,$address1, $protocol, $UserSearchPath, $GroupSearchPath
        
      Write-Output "$date,$infohostname,$address1, $protocol, $UserSearchPath, $GroupSearchPath" | Out-File $finalpatch\securityinfo.txt -Append  -Encoding ASCII         
       
        #"Hostname Information"
       $infohostname = $content[$i+1]
    }

elseif($content[$i] -match "Name of the software package")
    {
        #"Ipv4 Address"
        $address1 = ($content[$i]  -split ":")[1,2]
    }
elseif($content[$i] -match "Protocol:")
    {
        #"Netmask Information"
        $protocol = ($content[$i] -split ":")[1]
    }
        
elseif($content[$i] -match "UserSearchPath:")
    {
        #"Netmask Information"
        $UserSearchPath = ($content[$i] -split ":")[1]
    }

elseif($content[$i] -match "GroupSearchPath:")
    {
        #"Netmask Information"
        $GroupSearchPath = ($content[$i] -split ":")[1]
    }
    












}

}

# Start process | Call this function to start all the script.
function start_parsing_block {

parse_network_block
parse_get_crus
parse_ntpinfoblock
parse_revision_info
parse_secure_data

parse_security_info

Write-Host "Parse Block Finished"

	}



