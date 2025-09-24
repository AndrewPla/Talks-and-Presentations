---
marp: true
theme: default
paginate: true
class: lead
---

# PowerShell Wednesday  
## Mastering `Where-Object`

---

# Why `Where-Object`?

- Core cmdlet for **filtering objects**  
- Lets you express logic on **properties** and **values**  
- Works in any pipeline  
- Once fluent, you can query almost anything

---

# The Basics

Syntax (long form):

```powershell
Where-Object -Property Status -EQ 'Running'
```

Syntax (script block form):

```powershell
Where-Object { $_.Status -eq 'Running' }
```

💡 $_ = the current object in the pipeline

---

# Example: Services
Show only running services
```powershell
Get-Service | Where-Object Status -eq 'Running'
```

Same with script block
```powershell
Get-Service | Where-Object { $_.Status -eq 'Running' }
```
---

# Comparison Operators

### Equality: `-eq`, `-ne`
```powershell
5 -eq 5    # True
5 -ne 10   # True
```

Comparison: `-gt`, `-lt`, `-ge`, `-le`
```powershell
5 -gt 3    # True
2 -le 2    # True
```

---

# Comparison Operators... cont.

`-like` → Wildcard comparison (*, ?)

`-notlike` → Wildcard mismatch

`-match` → Regex match

`-notmatch` → Regex mismatch

`-replace` → Regex replacement, it will replace things

```powershell
"hello.txt" -like "*.txt"     # True
"hello" -match "^h.*o$"       # True
"hello" -replace "h","j"      # "jello"
```

Containment: `-in`, `-notin`, `-contains`, `-notcontains`

Type: `-is`, `-isnot`

```powershell
Get-Process | Where-Object CPU -gt 100
```

---

# Logical Operators

Combine conditions using there

-and → both true

-or → either true

-not → negation

Processes with high CPU or memory
```powershell
Get-Process |
  Where-Object { $_.CPU -gt 200 -or $_.WS -gt 500MB }
```
---

# Shortcuts and Aliases

`Where`
`?`

`$_` is implied in property syntax

Shorter
```powershell
Get-Service | ? Status -eq 'Stopped'
```

---

# Filtering vs Formatting

❌ Wrong: format too early

```powershell
Get-Service | Format-Table Name, Status |
  Where-Object { $_.Status -eq 'Running' }
```


✔️ Right: filter first

```powershell
Get-Service |
  Where-Object Status -eq 'Running' |
  Format-Table Name, Status
```
---

# Advanced: Filtering by Date
Files modified in last 7 days
```powershell
Get-ChildItem C:\Logs -File |
  Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) }
```


💡 Combine with Select-Object for peak PowerShell

---

# Advanced: Filtering by Array Contents
Show processes matching a list of names
```powershell
$names = "pwsh","notepad","code"
Get-Process | Where-Object { $_.Name -in $names }
```

Opposite: exclude names
```powershell
Get-Process | Where-Object { $_.Name -notin $names }
```
---

# Advanced: Negation Patterns
All services NOT running
```powershell
Get-Service | Where-Object Status -ne 'Running'
```

Files NOT ending with .log
```powershell
Get-ChildItem | Where-Object Name -notlike '*.log'
```

---

# Real-World Example
Find failed logon events in Security log

```powershell
Get-WinEvent -LogName Security |
  Where-Object Id -eq 4625 |
  Select-Object TimeCreated, Id, Message
```
---

# Wrap-Up

✅ Use Where-Object to filter objects in pipelines
✅ Know the operators: -eq, -like, -match, -in, etc.
✅ Use logic: -and, -or, -not
✅ Remember Filter Left, Format Right
✅ Explore cmdlet filtering, it can be more efficient