function Save-TweakState {
    $configDir = "$PSScriptRoot\..\config"
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir | Out-Null
    }
    
    $configPath = "$configDir\state.json"
    
    # Helper: recursively convert hashtables (including nested ones) to string-keyed ordered dicts
    function ConvertTo-StringKeys($obj) {
        if ($null -eq $obj) { return $obj }
        if ($obj -is [System.Collections.IDictionary]) {
            $d = [ordered]@{}
            $sortedKeys = $obj.Keys | Sort-Object { 
                if ($_ -match '^\d+$') { [int]$_ } 
                else { $_ } 
            }
            foreach ($k in $sortedKeys) {
                $d["$k"] = ConvertTo-StringKeys $obj[$k]
            }
            return $d
        }
        elseif ($obj -is [System.Collections.IEnumerable] -and $obj -isnot [string]) {
            $arr = @()
            foreach ($item in $obj) {
                $arr += ConvertTo-StringKeys $item
            }
            return $arr
        }
        else {
            return $obj
        }
    }

    # Save unified flat state
    $state = [ordered]@{
        Tweaks = ConvertTo-StringKeys $global:PlatinumAppliedState
    }

    # Custom JSON serialization to preserve order
    function ConvertTo-JsonOrdered($obj, $depth = 4) {
        if ($depth -lt 0) { return $null }
        
        if ($null -eq $obj) { return "null" }
        
        if ($obj -is [bool]) { 
            $val = if ($obj) { "true" } else { "false" }
            return $val
        }
        if ($obj -is [string]) { return "`"$($obj.Replace('\', '\\').Replace('"', '\"'))`"" }
        if ($obj -is [int] -or $obj -is [long] -or $obj -is [double]) { return "$obj" }
        
        if ($obj -is [System.Collections.IDictionary]) {
            $items = @()
            # For ordered hashtables, preserve insertion order for all keys
            # For regular hashtables, sort numeric keys and keep string keys in insertion order
            $isOrdered = $obj -is [System.Collections.Specialized.OrderedDictionary]
            
            if ($isOrdered) {
                # Check if this is the System section and reorder tabs
                $keys = @($obj.Keys)
                if ($keys -contains 'PERFORMANCE' -and $keys -contains 'PRIVACY' -and $keys -contains 'CLEANUP' -and $keys -contains 'ADVANCED') {
                    # This is the System section, use specific tab order
                    $tabOrder = @('PERFORMANCE', 'PRIVACY', 'CLEANUP', 'ADVANCED')
                    foreach ($tab in $tabOrder) {
                        if ($keys -contains $tab) {
                            $v = ConvertTo-JsonOrdered $obj[$tab] ($depth - 1)
                            $items += "    `"$tab`":  $v"
                        }
                    }
                } else {
                    # Preserve exact insertion order
                    foreach ($k in $obj.Keys) {
                        $v = ConvertTo-JsonOrdered $obj[$k] ($depth - 1)
                        $items += "    `"$k`":  $v"
                    }
                }
            } else {
                # Separate numeric and string keys
                $numericKeys = @()
                $stringKeys = @()
                $keyIndex = @{}
                $idx = 0
                foreach ($k in $obj.Keys) {
                    $keyIndex[$k] = $idx++
                    if ($k -match '^\d+$') {
                        $numericKeys += $k
                    } else {
                        $stringKeys += $k
                    }
                }
                # Sort numeric keys ascending, keep string keys in insertion order
                $sortedNumeric = $numericKeys | Sort-Object { [int]$_ }
                $sortedString = $stringKeys | Sort-Object { $keyIndex[$_] }
                $sortedKeys = $sortedNumeric + $sortedString
                
                foreach ($k in $sortedKeys) {
                    $v = ConvertTo-JsonOrdered $obj[$k] ($depth - 1)
                    $items += "    `"$k`":  $v"
                }
            }
            return "{`r`n$($items -join ",`r`n")`r`n}"
        }
        
        if ($obj -is [System.Collections.IEnumerable] -and $obj -isnot [string]) {
            $items = @()
            foreach ($item in $obj) {
                $items += "    $(ConvertTo-JsonOrdered $item ($depth - 1))"
            }
            return "[`r`n$($items -join ",`r`n")`r`n]"
        }
        
        return "null"
    }
    
    ConvertTo-JsonOrdered $state 4 | Out-File -FilePath $configPath -Encoding UTF8 -Force
}

function Test-TweakStateAltered($state) {
    if ($null -eq $state) { return $true }
    
    # Unified flat format validation
    if ($null -ne $state.Tweaks) {
        foreach ($prop in $state.Tweaks.psobject.properties) {
            $val = $prop.Value
            if ($null -eq $val) { return $true }
            if ($val -isnot [bool] -and $val.ToString().ToLower() -notmatch '^(true|false)$') {
                return $true
            }
        }
        return $false
    }
    
    # Expected top-level keys for legacy format
    $expectedKeys = @('Tweaks', 'System', 'CPU', 'GPU', 'RAM', 'Disk', 'Network', 'Input')
    
    # Valid System tab names
    $validSystemTabs = @('PERFORMANCE', 'PRIVACY', 'CLEANUP', 'ADVANCED')
    
    # Valid CPU vendor names
    $validCpuVendors = @('General', 'AMD', 'Intel')
    
    # Valid GPU vendor names
    $validGpuVendors = @('General', 'NVIDIA', 'AMD', 'Intel')
    
    # Check if there are any unexpected top-level keys
    foreach ($prop in $state.psobject.properties) {
        if ($expectedKeys -notcontains $prop.Name) {
            return $true
        }
    }
    
    # Check each section
    foreach ($key in $expectedKeys) {
        $section = $state.$key
        if ($null -eq $section) { continue }
        
        foreach ($prop in $section.psobject.properties) {
            $val = $prop.Value
            if ($null -eq $val) { return $true }
            
            # If the value is a nested object
            if ($val -is [System.Management.Automation.PSCustomObject]) {
                # System can have nested objects (new tab structure)
                if ($key -eq 'System') {
                    # Validate tab name
                    if ($validSystemTabs -notcontains $prop.Name) {
                        # If it's not a valid tab name, it might be old flat structure
                        # Check if the nested object has numeric keys
                        $firstSubProp = ($val.psobject.properties | Select-Object -First 1)
                        if ($null -ne $firstSubProp -and $firstSubProp.Name -match '^\d+$') {
                            # Old flat structure - treat as valid for backward compatibility
                            continue
                        }
                        return $true
                    }
                    # Validate nested tweak values
                    foreach ($subProp in $val.psobject.properties) {
                        $subVal = $subProp.Value
                        if ($null -eq $subVal) { return $true }
                        if ($subVal -isnot [bool] -and $subVal -isnot [int] -and $subVal -isnot [string]) { return $true }
                        if ($subVal -is [bool] -or $subVal.ToString().ToLower() -match '^(true|false)$') {
                            # ok
                        } else {
                            return $true
                        }
                    }
                }
                # CPU and GPU can have nested objects (vendor categories)
                elseif ($key -eq 'CPU' -or $key -eq 'GPU') {
                    $validVendors = if ($key -eq 'CPU') { $validCpuVendors } else { $validGpuVendors }
                    if ($validVendors -notcontains $prop.Name) { return $true }
                    
                    foreach ($subProp in $val.psobject.properties) {
                        $subVal = $subProp.Value
                        if ($null -eq $subVal) { return $true }
                        if ($subVal -isnot [bool] -and $subVal -isnot [int] -and $subVal -isnot [string]) { return $true }
                        if ($subVal -is [bool] -or $subVal.ToString().ToLower() -match '^(true|false)$') {
                            # ok
                        } else {
                            return $true
                        }
                    }
                } else {
                    # Other sections should not have nested objects
                    return $true
                }
            } else {
                # Must be a boolean value (or string representation of it)
                if ($val -is [bool] -or $val.ToString().ToLower() -match '^(true|false)$') {
                    # ok
                } else {
                    return $true
                }
            }
        }
    }
    return $false
}

function Load-TweakStateData($state) {
    if ($null -eq $global:PlatinumAppliedState) { $global:PlatinumAppliedState = @{} }

    # New unified format: state.Tweaks = { "category|index": true/false }
    if ($null -ne $state.Tweaks) {
        foreach ($prop in $state.Tweaks.psobject.properties) {
            $global:PlatinumAppliedState[$prop.Name] = [bool]$prop.Value
        }
    } else {
        # Legacy: load from old per-category fields and migrate to flat state
        # System Tweaks
        if ($null -ne $state.System) {
            $firstProp = ($state.System.psobject.properties | Select-Object -First 1)
            if ($null -ne $firstProp -and $firstProp.Value -is [System.Management.Automation.PSCustomObject]) {
                foreach ($tabProp in $state.System.psobject.properties) {
                    $tabCat = switch ($tabProp.Name) {
                        'PERFORMANCE' { 'system_tweaks/performance' }
                        'KERNEL'      { 'system_tweaks/kernel' }
                        'PRIVACY'     { 'system_tweaks/privacy' }
                        'CLEANUP'     { 'system_tweaks/cleanup' }
                        default       { "system_tweaks/$($tabProp.Name.ToLower())" }
                    }
                    foreach ($tweakProp in $tabProp.Value.psobject.properties) {
                        if ([bool]$tweakProp.Value) {
                            $global:PlatinumAppliedState["$tabCat|$($tweakProp.Name)"] = $true
                        }
                    }
                }
            } else {
                foreach ($prop in $state.System.psobject.properties) {
                    if ([bool]$prop.Value) {
                        $global:PlatinumAppliedState["system_tweaks/performance|$($prop.Name)"] = $true
                    }
                }
            }
        }

        # CPU Tweaks
        if ($null -ne $state.CPU) {
            foreach ($prop in $state.CPU.psobject.properties) {
                if ($prop.Value -is [System.Management.Automation.PSCustomObject]) {
                    $catName = switch ($prop.Name) {
                        'General' { 'cpu_tweaks/general' }
                        'AMD'     { 'cpu_tweaks/amd' }
                        'Intel'   { 'cpu_tweaks/intel' }
                        default   { "cpu_tweaks/$($prop.Name.ToLower())" }
                    }
                    foreach ($subProp in $prop.Value.psobject.properties) {
                        $global:PlatinumAppliedState["$catName|$($subProp.Name)"] = [bool]$subProp.Value
                    }
                } else {
                    $global:PlatinumAppliedState["cpu_tweaks/general|$($prop.Name)"] = [bool]$prop.Value
                }
            }
        }

        # GPU Tweaks
        if ($null -ne $state.GPU) {
            foreach ($prop in $state.GPU.psobject.properties) {
                if ($prop.Value -is [System.Management.Automation.PSCustomObject]) {
                    $catName = switch ($prop.Name) {
                        'General' { 'gpu_tweaks/general' }
                        'NVIDIA'  { 'gpu_tweaks/nvidia' }
                        'AMD'     { 'gpu_tweaks/amd' }
                        'Intel'   { 'gpu_tweaks/intel' }
                        default   { "gpu_tweaks/$($prop.Name.ToLower())" }
                    }
                    foreach ($subProp in $prop.Value.psobject.properties) {
                        $global:PlatinumAppliedState["$catName|$($subProp.Name)"] = [bool]$subProp.Value
                    }
                } else {
                    $global:PlatinumAppliedState["gpu_tweaks/general|$($prop.Name)"] = [bool]$prop.Value
                }
            }
        }

        # RAM, Disk, Network, Input
        foreach ($section in @('RAM','Disk','Network','Input')) {
            $catMap = @{ 'RAM'='ram_tweaks'; 'Disk'='disk_tweaks'; 'Network'='network_tweaks'; 'Input'='input_tweaks' }
            $cat = $catMap[$section]
            $stateSection = $state.$section
            if ($null -ne $stateSection) {
                foreach ($prop in $stateSection.psobject.properties) {
                    $global:PlatinumAppliedState["$cat|$($prop.Name)"] = [bool]$prop.Value
                }
            }
        }
    }

    if (Get-Command Update-AllPlatinumCatalogSections -ErrorAction SilentlyContinue) {
        Update-AllPlatinumCatalogSections
    }
    if (Get-Command Update-DebloatStateUI -ErrorAction SilentlyContinue) {
        Update-DebloatStateUI
    }
}


function Load-TweakState {
    $configPath = "$PSScriptRoot\..\config\state.json"
    if (-not (Test-Path $configPath)) {
        $global:PlatinumAppliedState = @{}
        if (Get-Command Update-AllPlatinumCatalogSections -ErrorAction SilentlyContinue) {
            Update-AllPlatinumCatalogSections
        }
        if (Get-Command Update-DebloatStateUI -ErrorAction SilentlyContinue) {
            Update-DebloatStateUI
        }
        return
    }
    
    # $ui is available via dot-sourcing scope (same as other modules)
    try {
        $json = Get-Content $configPath -Raw -Encoding UTF8
        if ([string]::IsNullOrWhiteSpace($json)) { return }
        
        # Verify JSON validity
        $state = $json | ConvertFrom-Json
        
        if (Test-TweakStateAltered $state) {
            # File is altered!
            $global:ModalContinueAction = {
                Load-TweakStateData $state
            }
            $global:ModalOkAction = {
                Stop-Process -Id $PID -Force
            }
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "The configuration file state.json has been altered or contains invalid sections. Please reset data using the Platinum Shell, or click Continue to load it anyway." "Program Violation" "Error" -ShowContinue
            }
            return
        }

        # Valid state, load it normally
        Load-TweakStateData $state
    } catch {
        # JSON formatting is fully corrupt
        $global:ModalContinueAction = {}
        $global:ModalOkAction = {
            Stop-Process -Id $PID -Force
        }
        if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
            Show-CustomPopup "The configuration file state.json is corrupted and failed to load. Please reset data using the Platinum Shell, or click Continue to load the application." "Program Violation" "Error" -ShowContinue
        }
    }
}
