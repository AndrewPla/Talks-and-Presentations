---
marp: true
theme: default
paginate: true
class: lead
---

# PowerShell Wednesday  
## Shedding Light on `Select-Object`

---

# Why `Select-Object`?

- `Select-Object *` is super helpful for viewing all of the properties on an object
- Limiting the output can be helpful
- Beginner friendly

---

# The Big Idea

### **Filter Left, Format Right**

- Do filtering as **early as possible** in the pipeline  
- Do formatting as **late as possible** in the pipeline  
- `Select-Object` sits at the **boundary**:
  - *Filter (which properties/items stay)*
  - *Format (how they are presented)*

---

# Objects Everywhere

- PowerShell doesn’t output plain text — it outputs **objects**  
- Every object has **properties** and **methods**  
- `Select-Object` lets you *pick which properties* flow down the pipeline  

---

# Select Properties

```powershell
# Example: processes
Get-Process | Select-Object Name, Id, CPU
# Show only certain properties
Get-Service | Select-Object Name, Status
# Show top N results
Get-Service | Select-Object -First 5 Name, Status
# Skip some results
Get-Service | Select-Object -Skip 5 -First 5
```

---

# Calculated Properties

Create properties using a hashtable
```powershell
@{Name = 'PropertyName'; Expression = { # run your powershell here}}
```
Inside the pipeline, you can extend objects
```powershell
Get-Process |
Select-Object Name, @{Name="MemoryMB"; Expression={ $_.WS / 1MB -as [int] }}

```

---

# Filter vs. Format

🙈⛔ Bad (formatting too early):

```powershell
Get-Process | Format-Table Name, Id | Select -Last 5

```

😁👍 Good (filter first, format last)

```powershell
Get-Process |
 Where-Object { $_.Id -gt 1000 } |
 Select-Object Name, Id |
 Format-Table
```

---

# Bonus Tip: Objects vs Text

```powershell
# Object-aware and pipeline friendly
Get-Service | Select-Object -Property Name, Status

# Just text (good for reading, bad for coding)
Get-Service | Format-Table Name, Status
```

---

# Musings

Which is easier?

```powershell
$files = Get-ChildItem | Select-Object -First 2
(Get-ChildItem)[0..1]
```

I think Select-Object is readable and great to lean on as you learn and grow with PowerShell