# Start Audit script for VNX File Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
#


$custommodules = C:\Users\agustin.lacorazza\source\repos\VNX_audit_main


Import-Module -Name $custommodules\VNX_block_audit_colector.psm1 -Force -Verbose
Import-Module -Name  $custommodules\VNX_block_audit_parse.psm1 -Force -Verbose
Import-Module -Name  $custommodules\VNX_file_colector.psm1 -Force -Verbose
Import-Module -Name  $custommodules\VNX_file_audit_parse.psm1 -Force  -Verbose




start_block_audit
start_file_audit
start_parsing_block
start_parsing_file



