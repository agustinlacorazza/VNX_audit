# VNX_audit

PowerShell tooling to **audit EMC VNX storage arrays**, both the **File** side (Data Movers / Control Station) and the
**Block** side (storage processors). It gathers configuration data, parses it and exports reports to Excel.

> **Resumen:** módulos de PowerShell para auditar arrays EMC VNX (File y Block): recolectan la configuración, la
> procesan y generan reportes en Excel.

## How it works

The flow has three stages, driven by `start audit.ps1` (also compiled as `start_audit.exe`):

| Stage | Module | What it does |
|---|---|---|
| Collect (Block) | `VNX_block_audit_colector.psm1` | Runs the Navisphere CLI (`NaviSECCli.exe`) against each array: network, NTP, security, revision, ESRS config, CRUs |
| Collect (File) | `VNX_file_audit_colector.psm1` | Connects to each Control Station over SSH with `plink` and runs small shell scripts: IP, DNS, MTU, server parameters, SMTP |
| Parse | `VNX_block_audit_parse.psm1`, `VNX_file_audit_parse.psm1` | Turns the raw output into CSV files, one per topic |
| Report | `VNX_transform_and_merge_to_excel.psm1` | Converts the CSVs to tables and merges them into one `.xlsx` |

`Start Audit File and Block.ps1` is the parsing script that runs both sides together.

Raw output and parsed files are written to a dated folder (`yyyy-MM-dd`), so you can keep one audit per day.

## Requirements

- Windows with PowerShell.
- EMC **Navisphere CLI** (`NaviSECCli.exe`). It is the vendor's tool and is **not** included here.
- [PuTTY `plink.exe`](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for the File side.
- A CSV with the arrays to audit, with the columns `System`, `IP`, `user`, `password`.
- Microsoft Excel (or a compatible COM server) for the Excel export.

## Setup

The scripts use fixed folders (`C:\scripts\VNX\Audit\...` and `C:\storage_report\DEV\VNX\Audit_script\...`).
Change them at the top of each script to match your layout, and put the Navisphere CLI where the scripts expect it.

## Security

- Keep the CSV with the array credentials **out of Git**. Use an account with read-only access on the arrays.
- The audit only reads configuration. Review the commands in the collector modules before you run them.

Written in 2018. It is kept here for reference and is not actively maintained.
