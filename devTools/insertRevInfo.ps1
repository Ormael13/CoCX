# This is one of several utility scripts used by Fake-Name's automated build setup
# to automatically create compiled versions of the CoC codebase
#
# This script modifies the main CoC.as file and inserts a notification that this is an
# alpha-release, as well as embeds the current time of compilation

# Revert any local changes to CoC.as file
git checkout -- ./classes/classes/CoC.as

# Get the short git revision
$gitRev = (git rev-parse --short HEAD)



# Modify the version and ver strings in CoC.as
(Get-Content -Path ./classes/classes/CoC.as) -replace '(ver\s*=)\s*("[^"]+")' , ('$1 $2 + "' + $gitRev + '_"') | Set-Content -Path ./classes/classes/CoC.as

# Display modified version strings
Write-Host "`nFile modified. Current version strings:"
Get-Content -Path ./classes/classes/CoC.as | Select-String -Pattern "ver\s?="
Write-Host "Done. Splicing in release info"