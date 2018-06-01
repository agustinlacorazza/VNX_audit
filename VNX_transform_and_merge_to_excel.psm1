#
# Transform CSV and Merge Excel for VNX FILE/Block Audit 2018 
# for Technical issues, please contact Agustin Lacorazza | agustin.lacorazza@ar.ey.com
# Using PsExcel Module: https://github.com/dfinke/ImportExcel 
#
Import-Module PSExcel -force


function convert_to_xlsx_Table {

$csv1 = Import-Csv xxx\xxx.txt -delimiter ","  | Export-XLSX -Path xxx.xlsx -Table -Autofit -Force  -WorkSheetname Services
$csv2 = Import-Csv xxx\xxx.txt -delimiter "," | Export-XLSX -Path Cxxx.xlsx  -Table -Autofit -Force  -WorkSheetname IP 

}


Function merge_xlsx {

$ExcelObject=New-Object -ComObject excel.application
$ExcelObject.visible=$true
$ExcelFiles=Get-ChildItem -Path xxx\xlsx

$Workbook=$ExcelObject.Workbooks.add()
$Worksheet=$Workbook.Sheets.Item("Sheet1")

foreach($ExcelFile in $ExcelFiles){
 
$Everyexcel=$ExcelObject.Workbooks.Open($ExcelFile.FullName)
$Everysheet=$Everyexcel.sheets.item(1)
$Everysheet.Copy($Worksheet)
$Everyexcel.Close()
 
}

$workbook.worksheets.item("Sheet1").Delete()
$workbook.worksheets.item("Sheet2").Delete()
$workbook.worksheets.item("Sheet3").Delete()
$workbook.worksheets.item("Sheet4").Delete()
$workbook.worksheets.item("Sheet5").Delete()
$Workbook.SaveAs("C:\storage_report\DEV\VNX\Audit_script\LAB\merge1.xlsx")
$ExcelObject.Quit()
}

merge_xlsx