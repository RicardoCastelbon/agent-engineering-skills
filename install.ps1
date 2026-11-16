<#
.SYNOPSIS
  Links every skill in skills/ and third-party/ into ~/.claude/skills using directory junctions.
.PARAMETER Uninstall
  Removes only the junctions that point into this repo. Never touches other folders.
#>
[CmdletBinding()]
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'

$target = Join-Path $HOME '.claude\skills'
New-Item -ItemType Directory -Force -Path $target | Out-Null

$sources = 'skills', 'third-party' |
    ForEach-Object { Join-Path $PSScriptRoot $_ } |
    Where-Object { Test-Path $_ } |
    ForEach-Object { Get-ChildItem -Path $_ -Directory } |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

function Get-LinkTarget($item) {
    if ($item.LinkType -ne 'Junction') { return $null }
    return ([string](@($item.Target)[0])).TrimEnd('\')
}

$seen = @{}
foreach ($skill in $sources) {
    $name = $skill.Name
    if ($seen.ContainsKey($name)) {
        Write-Warning "$name exists in both $($seen[$name]) and $($skill.FullName); skipping the second."
        continue
    }
    $seen[$name] = $skill.FullName

    $link = Join-Path $target $name
    $existing = Get-Item -Path $link -Force -ErrorAction SilentlyContinue
    $pointsHere = $existing -and ((Get-LinkTarget $existing) -eq $skill.FullName.TrimEnd('\'))

    if ($Uninstall) {
        if ($pointsHere) {
            cmd /c rmdir "$link" | Out-Null   # removes the junction only, not the repo folder
            Write-Host "unlinked  $name"
        }
        continue
    }

    if ($pointsHere) {
        Write-Host "ok        $name"
    } elseif ($existing) {
        Write-Warning "$link already exists and isn't linked to this repo; leaving it alone."
    } else {
        New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
        Write-Host "linked    $name"
    }
}

if ($seen.Count -eq 0) { Write-Host 'No skills found (folders need a SKILL.md).' }
