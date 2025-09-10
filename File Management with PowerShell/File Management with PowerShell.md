---
marp: true
theme: default
paginate: true
class: lead
---

# PowerShell Wednesday  
## File Management Basics

---

# Why File Management with PowerShell?

---

# Core Cmdlets

- `Get-ChildItem` → list files & folders  
- `Set-Location` → navigate  
- `New-Item` → create  
- `Copy-Item` → copy  
- `Move-Item` → move  
- `Rename-Item` → rename  
- `Remove-Item` → delete  
- `Test-Path` → check existence
- 💎 `Invoke-Item` → open file using default program

---

# Why no Get-File?

🖐️ "Mr. Andrew, I have a question. Why do all the commands that deal with files use "Item" instead of "File" or "Folder"

Great question, Grasshopper. It's because these commands work with things other than files and folders!

`Get-ChildItem -Path HKLM:\HARDWARE`

---

# Navigation & Listing

```powershell
# Where am I?
Get-Location

# Navigate
Set-Location C:\Logs

# List files (alias: ls / dir)
Get-ChildItem

# Filter by extension
Get-ChildItem -Filter *.txt

```

---

# Creating Files & Folders

```powershell
# Create folder
New-Item -Path "C:\Reports" -ItemType Directory

# Create file
New-Item -Path "C:\Reports\report1.txt" -ItemType File

# Check before creating
if (-not (Test-Path "C:\Reports\report2.txt")) {
    New-Item "C:\Reports\report2.txt"
}
```

---

# Copying and Moving

```powershell
# Copy a file
Copy-Item "C:\Reports\report1.txt" "C:\Archive\"

# Copy folder recursively
Copy-Item "C:\Reports" "D:\Backup" -Recurse

# Move file
Move-Item "C:\Reports\report1.txt" "C:\Archive\report1.txt"

```

---

# Renaming Files

```powershell
# Rename single file
Rename-Item "C:\Archive\report1.txt" "report-final.txt"

# Batch rename (add .bak extension)
Get-ChildItem "C:\Archive\*.txt" |
    Rename-Item -NewName { $_.Name + ".bak" }

```

---

# Deleting & Cleaning Up

```powershell
# Delete a file
Remove-Item "C:\Archive\report-final.txt"

# Delete folder recursively
Remove-Item "C:\Archive" -Recurse -Force

# Delete files older than 30 days
Get-ChildItem "C:\Logs" -File |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
    Remove-Item -Force

```

--- 

# Archiving Logs

```powershell
$src  = "C:\Logs"
# Use a substring to get the current date
$dest = "C:\Logs\Archive\$((Get-Date -Format 'yyyyMMdd'))"

# Ensure archive folder exists
if (-not (Test-Path $dest)) {
    New-Item -Path $dest -ItemType Directory
}

# Copy logs
Get-ChildItem -Path $src -Filter '*.log' |
    Copy-Item -Destination $dest -Force

# Clean up old logs
Get-ChildItem -Path $src -Filter '*.log' |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } |
    Remove-Item -Force

```

---

# Bonus Tip: Type Accelerators

PowerShell has **shortcuts** for .NET classes, called **type accelerators**.  
For files and folders, the most useful are:

- `[System.IO.FileInfo]` → represents a file  
- `[System.IO.DirectoryInfo]` → represents a folder  
- `[System.IO.File]` → static file operations (Exists, ReadAllText, etc.)  
- `[System.IO.Directory]` → static directory operations  

```powershell
# File example
$file = [IO.FileInfo]"C:\Temp\example.txt"
$file.Length   # file size

# Directory example
$dir = [IO.DirectoryInfo]"C:\Temp"
$dir.GetFiles()