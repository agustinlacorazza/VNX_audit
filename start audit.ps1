# Start Audit script for VNX File Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#
Clear-Host

$custommodulesblock = "C:\scripts\VNX\Audit\Block"
$custommodulesfile =  "C:\scripts\VNX\Audit\File"

Import-Module -Name  $custommodulesblock\VNX_block_audit_colector.psm1 -Force -Verbose
Import-Module -Name  $custommodulesblock\VNX_block_audit_parse.psm1 -Force -Verbose
Import-Module -Name  $custommodulesfile\VNX_file_audit_colector.psm1 -Force -Verbose
Import-Module -Name  $custommodulesfile\VNX_file_audit_parse.psm1 -Force  -Verbose



function start_raw {
start_block_audit
start_file_audit
}

function start_parse {

start_parsing_block
start_parsing_file

}


start_raw
start_parse
