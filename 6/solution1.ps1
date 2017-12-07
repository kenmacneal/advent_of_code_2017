function loop-control ($i, $count) {
    if ($i -ge $($count - 1))
    {$i = 0}
    
    else {$i++}

    return $i
}


$inputs = get-content .\input.txt

$clean = $inputs -split "<TAB>"

$index = 0

$mem_banks = new-object System.Collections.ArrayList

foreach ($item in $clean) {
    $properties = [ordered]@{
        'Blocks' = [Convert]::ToInt32($item)
        'Index'  = $index
    }

    $obj = New-Object -TypeName psobject -Property $properties

    $null = $mem_banks.Add($obj)
    $index++
}



$known_states = New-Object System.Collections.ArrayList


$copier = $($mem_banks.Blocks) -join "<TAB>"

$null = $known_states.add($copier)

$copier = $null

$counter = 0

$is_present = $false

do {

    #$start = $($mem_banks | sort -Property Blocks -Descending | select -First 1).Index

    $max = $($mem_banks.Blocks | measure -Maximum).Maximum

    $blocks = @()
    
    
    $mem_banks | where -Property Blocks -eq $max | % {$blocks += $_}

    if ($blocks.Count -eq 1) {
        $start = $($mem_banks | sort -Property Blocks -Descending | select -First 1).Index
    }
    else {
        $start = $($blocks | sort -Property Index | select -First 1).Index
    }

    
    $redistribute = $mem_banks[$start].Blocks
    
    $mem_banks[$start].Blocks = 0
    
    if($start -eq $($mem_banks.Count - 1))
    {
        $i = 0
    }
    else {
        $i = $($start + 1)
    }
    for ($i; $i -lt $mem_banks.Count; $i = loop-control -i $i -count $($mem_banks.Count - 1) ) {

        if ($redistribute -gt 0) {
            $mem_banks[$i].Blocks = $mem_banks[$i].Blocks + 1
        }
        
    
        $redistribute--
        
        if ($redistribute -le 0) {
            break
        }


    }
    foreach ($item in $known_states) {
        $known = $item

        $current = $($mem_banks.Blocks) -join "<TAB>"
        

        if ($known -eq $current) {
            $current
            $null = $known_states.add($current)
            $is_present = $true
            break
        }

        
    }
    if ($is_present -eq $false) {
        $copier = $($mem_banks.Blocks) -join "<TAB>"
        
        $null = $known_states.add($copier)
        
        $copier = $null
    
    }
    
    $counter++
    
} until ($is_present -eq $true)

$known_states | %{$_.Tostring().Replace("<TAB>","`t")} | Out-File .\out.txt

