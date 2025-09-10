Next Month: Bring your problem
Split into groups and work together, no presentation (or maybe a 15 minute one depending on time)

https://powershellsaturdaync.com



# Open the repo
Start-Process "https://github.com/vexx32/PSKoan"

# Get that bad boi installed
# Install-PSResource PSKoans -Scope CurrentUser
Install-Module PSKoans -Scope CurrentUser

# Open the entire project in vs Code
code "$(get-module -ListAvailable | Where-Object Name -eq 'pskoans' | Select-Object -expandproperty  ModuleBase)" 

# Get Started
Show-Karma

# Open the next koan in VS Code
Show-Karma -Meditate

# Show all topics
Show-Karma -List

# Show a specific topic
Show-Karma -Topic AboutArrays -Meditate


# Scoreched Earth: Delete it all
Remove-Item -Path "~/.config/PSKoans" -Recurse

# To remove your koan files (THIS WILL COMPLETELY DELETE YOUR PROGRESS)
Get-PSKoanLocation | Remove-Item -Recurse