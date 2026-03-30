<#
.SYNOPSIS

Compares translated file to its previous version. Marks differences that should be reviewed.

.PARAMETER previousTranslationFilePath
.PARAMETER newTranslationFilePath


#>

$previousTranslationFilePath = 'C:\Development\AL\Weibel\weibel-app\Translations\Copilot\Weibel App.Original.da-DK.xlf.txt'
$newTranslationFilePath = 'C:\Development\AL\Weibel\weibel-app\Translations\Weibel App.da-DK.xlf'

# [CmdletBinding()]
# param(
#     [Parameter(Mandatory = $true)]
#     [string]$previousTranslationFilePath,
    
#     [Parameter(Mandatory = $true)]
#     [string]$newTranslationFilePath
   
# )

# read the files
$originalXml = [xml](Get-Content -Path $previousTranslationFilePath -Encoding UTF8)
$transFileXml = [xml](Get-Content -Path $newTranslationFilePath -Encoding UTF8)


Write-Host "Building index of original trans-units..." -ForegroundColor Cyan
$originalUnits = @{}
foreach ($unit in $originalXml.xliff.file.body.group.'trans-unit') {
    $source = ''
    $target = ''
    foreach ($node in $unit.ChildNodes) {
        if ($node.Name -eq 'source') {
            $source = $node.InnerText
        }
        if ($node.Name -eq 'target') {
            $target = $node.InnerText
        }
    }

    $originalUnits[$unit.id] = @{
        source = $source
        target = $target
    }
}
Write-Host "Found $($originalUnits.Count) trans-units in original file" -ForegroundColor Green

Write-Host "Building index of translated trans-units..." -ForegroundColor Cyan
$transUnits = @{}
foreach ($unit in $transFileXml.xliff.file.body.group.'trans-unit') {
    $source = ''
    $target = ''
    foreach ($node in $unit.ChildNodes) {
        if ($node.Name -eq 'source') {
            $source = $node.InnerText
        }
        if ($node.Name -eq 'target') {
            $target = $node.InnerText
        }
    }

    $transUnits[$unit.id] = @{
        source = $source
        target = $target
    }
}


Write-Host "Found $($transUnits.Count) trans-units in translated file" -ForegroundColor Green

# Statistics

$stats = @{
    'new'                      = 0
    'needs-review-translation' = 0
    'translated'               = 0
}

# compare translations and set new status values

Write-Host "Running comparison:" -ForegroundColor Yellow

foreach ($unitKey in $transUnits.Keys) {
        
    if (!$originalUnits.ContainsKey($unitKey)) {
        $transUnits[$unitKey].targetState = 'new'
        $stats.new += 1
    }
    else {
        if ($transUnits[$unitKey].source -eq $originalUnits[$unitKey].source) {
            if ($transUnits[$unitKey].target -eq $originalUnits[$unitKey].target) {
                $transUnits[$unitKey].targetState = 'translated'
                $stats.translated += 1
            }
            else {
                $transUnits[$unitKey].targetState = 'needs-review-translation'
                $stats.'needs-review-translation' += 1
            }
        }
        else {
            # Source changed between versions; mark for review
            $transUnits[$unitKey].targetState = 'needs-review-translation'
            $stats.'needs-review-translation' += 1
        }
    }

    if ($transUnits[$unitKey].targetState -ne 'translated') {
        write-host $unitKey -ForegroundColor Yellow
        write-host "State:" $transUnits[$unitKey].targetState -ForegroundColor Green
        write-host "Sources:"
        write-host `t "Orig.:`t" ($originalUnits[$unitKey].source)
        write-host `t "Tran.:`t" ($transUnits[$unitKey].source)
        write-host "Targets:"
        write-host `t "Orig.:`t" ($originalUnits[$unitKey].target)
        write-host `t "Tran.:`t" ($transUnits[$unitKey].target)
    }
}

# show stats
write-host "Stats:" -ForegroundColor Yellow
Write-Host "New: " $stats.new
Write-Host "Translated: " $stats.translated
Write-Host "For Review: " $stats.'needs-review-translation'

# udate the xml

foreach ($xUnit in $transFileXml.xliff.file.body.group.'trans-unit') {
    #$xUnit.id
    foreach ($node in $xUnit.ChildNodes) {
        if ($node.Name -eq 'target') {
            $stateToSet = $null
            if ($transUnits.ContainsKey($xUnit.id)) {
                $stateToSet = $transUnits[$xUnit.id].targetState
            }
            if (-not $stateToSet) {
                $stateToSet = 'needs-review-translation'
            }
            $node.SetAttribute("state", $stateToSet);
        }
    }
}

Copy-Item -Path $newTranslationFilePath -Destination ($newTranslationFilePath + ".bak") -Force

$transFileXml.Save($newTranslationFilePath)
