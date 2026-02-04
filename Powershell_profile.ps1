function Get-BytesAtOffset {
    <#
    .SYNOPSIS
    Show bytes at a specific offset in a binary file.

    .PARAMETER Path
    Path to the executable/binary file.

    .PARAMETER Offset
    Offset to examine. Supports hex (0x1234) or decimal.

    .PARAMETER Context
    Number of bytes to show before and after the offset. Default: 64

    .EXAMPLE
    Get-BytesAtOffset -Path .\malware.exe -Offset 0x1A3F
    gbo .\malware.exe 0x1A3F
    #>
    [CmdletBinding()]
    [Alias("gbo")]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Path,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$Offset,

        [Parameter(Position=2)]
        [int]$Context = 64
    )

    # Parse offset - handle hex (0x) or decimal
    if ($Offset -match '^0x') {
        $offsetInt = [Convert]::ToInt64($Offset, 16)
    } else {
        $offsetInt = [int64]$Offset
    }

    $fullPath = Resolve-Path $Path -ErrorAction Stop
    $bytes = [System.IO.File]::ReadAllBytes($fullPath)
    $fileSize = $bytes.Length

    # Calculate range
    [int64]$start = [Math]::Max(0, $offsetInt - $Context)
    [int64]$end = [Math]::Min($fileSize - 1, $offsetInt + $Context)

    Write-Host "`n[*] File: $fullPath" -ForegroundColor Cyan
    Write-Host "[*] File size: $fileSize bytes (0x$($fileSize.ToString('X')))" -ForegroundColor Cyan
    Write-Host "[*] Target offset: $offsetInt (0x$($offsetInt.ToString('X')))" -ForegroundColor Yellow
    Write-Host "[*] Showing range: 0x$($start.ToString('X')) - 0x$($end.ToString('X'))`n" -ForegroundColor Cyan

    # Print hex dump with ASCII
    $lineWidth = 16
    [int64]$currentLine = [Math]::Floor($start / $lineWidth) * $lineWidth

    while ($currentLine -le $end) {
        $hexPart = ""
        $asciiPart = ""

        for ($i = 0; $i -lt $lineWidth; $i++) {
            $pos = $currentLine + $i

            if ($pos -ge $start -and $pos -le $end -and $pos -lt $fileSize) {
                $byte = $bytes[$pos]

                # Highlight the target offset
                if ($pos -eq $offsetInt) {
                    $hexPart += "[" + $byte.ToString("X2") + "]"
                } else {
                    $hexPart += $byte.ToString("X2") + " "
                }

                # ASCII representation
                if ($byte -ge 32 -and $byte -le 126) {
                    $asciiPart += [char]$byte
                } else {
                    $asciiPart += "."
                }
            } else {
                $hexPart += "   "
                $asciiPart += " "
            }

            if ($i -eq 7) { $hexPart += " " }
        }

        $offsetLabel = "0x" + $currentLine.ToString("X8")

        # Color the line containing target offset
        if ($currentLine -le $offsetInt -and ($currentLine + $lineWidth) -gt $offsetInt) {
            Write-Host "$offsetLabel  $hexPart |$asciiPart|" -ForegroundColor Yellow
        } else {
            Write-Host "$offsetLabel  $hexPart |$asciiPart|"
        }

        $currentLine += $lineWidth
    }

    # Extract and show nearby strings
    Write-Host "`n[*] Strings near offset:" -ForegroundColor Green
    [int64]$strStart = [Math]::Max(0, $offsetInt - 128)
    [int64]$strEnd = [Math]::Min($fileSize, $offsetInt + 128)
    $region = $bytes[$strStart..$strEnd]

    $currentString = ""
    $stringStart = 0

    for ($i = 0; $i -lt $region.Length; $i++) {
        $byte = $region[$i]
        if ($byte -ge 32 -and $byte -le 126) {
            if ($currentString -eq "") { $stringStart = $i }
            $currentString += [char]$byte
        } else {
            if ($currentString.Length -ge 4) {
                [int64]$absOffset = $strStart + $stringStart
                $marker = if ($absOffset -le $offsetInt -and ($absOffset + $currentString.Length) -ge $offsetInt) { " <-- TARGET" } else { "" }
                Write-Host "  0x$($absOffset.ToString('X8')): $currentString$marker" -ForegroundColor $(if ($marker) { "Yellow" } else { "White" })
            }
            $currentString = ""
        }
    }

    Write-Host ""
}

function Encode-Command {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Command,

        [Parameter(Mandatory = $false)]
        [switch]$ForHidden,

        [Parameter(Mandatory = $false)]
        [switch]$ForFullPath
    )

    # Join all remaining arguments into a single command string
    $commandString = $Command -join ' '

    if ([string]::IsNullOrWhiteSpace($commandString)) {
        Write-Error "No command string provided."
        return
    }

    # Convert to UTF-16LE and base64 encode (exactly how PowerShell -EncodedCommand expects it)
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commandString)
    $base64 = [Convert]::ToBase64String($bytes)

    # Build output based on flags
    if ($ForHidden) {
        # Short form: powershell -w hidden -enc ...
        "powershell -w hidden -enc $base64"
    }
    elseif ($ForFullPath) {
        # Full path form: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -EncodedCommand ...
        "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -w hidden -enc $base64"
    }
    else {
        # Just the base64 string
        $base64
    }
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
