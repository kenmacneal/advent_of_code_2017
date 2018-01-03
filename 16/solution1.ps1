class program {
    [string]$name;
    [int]$position;
}

$inputs = (Get-Content .\input.txt) -split ","

[string[]]$programs = @()

$letters = [char[]]([char]'a'..[char]'p')

$programs = New-Object System.Collections.ArrayList

for ($i = 0; $i -lt 16; $i++) {
    $programs += $letters[$i]
}



foreach ($command in $inputs) {
    switch ($command.tostring().substring(0, 1)) {
        "s" { 
            $number = [int]$command.tostring().substring(1, $($command.tostring().length - 1))
            [string[]]$temp_array = , "" * $number
            [string[]]$beg_array = , "" * ($programs.count - $number)
            
            [Array]::Copy($programs, $($programs.Count - $number), $temp_array, 0, $number)


            for ($i = 0; $i -lt $($programs.count - $number); $i++) {
                $beg_array[$i] = $programs[$i]
            }

            $list_temp = New-Object 'System.Collections.Generic.List[string]'
            
            $list_temp.InsertRange(0, $beg_array)
            $list_temp.InsertRange(0, $temp_array)
            
                        
            for ($i = 0; $i -lt $list_temp.Count; $i++) {
                $programs[$i] = $list_temp[$i]
            }
            
        }
        "x" {
            $numbers = ($command.substring(1, $command.tostring().length - 1)) -split "/"
            $temp = $programs[$numbers[0]]
            $programs[$numbers[0]] = $programs[$numbers[1]]
            $programs[$numbers[1]] = $temp

        }
        "p" {
            $prog_swaps = ($command.substring(1, $command.tostring().length - 1)) -split "/"

            $swap_a = $prog_swaps[0].tostring()
            $swap_b = $prog_swaps[1].tostring()
            
            $index_a = $programs.IndexOf($swap_a)
            $index_b = $programs.IndexOf($swap_b)

            $temp = $programs[$index_a]
            $programs[$index_a] = $programs[$index_b]
            $programs[$index_b] = $temp

        }
        Default {}
    }
}

return $programs -join ""

#padheomkgjfnblic
# SIG # Begin signature block
# MIIKywYJKoZIhvcNAQcCoIIKvDCCCrgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUk5dk/8AdOhyaIkgLs4on+EQC
# R6GgggagMIIB/zCCAWigAwIBAgIQRrLr3K6l7ZdPZc3K61xe8zANBgkqhkiG9w0B
# AQUFADAaMRgwFgYDVQQDDA9LZW5uZXRoIE1hY05lYWwwHhcNMTcwMTA2MTUxNjI5
# WhcNMjEwMTA2MDAwMDAwWjAaMRgwFgYDVQQDDA9LZW5uZXRoIE1hY05lYWwwgZ8w
# DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALVfHgCosplTcgqE1tpyjfGWp9YzrtxG
# cDU/oit9XSK5dMGogy/tenwyRQmqwBnTfpKbqW5gN1+cNB8rcNnlavJY03/C6VIh
# 8ka3i8SPPCrpIc1PVxRiju8d3vxC3HRmoUANHS/MmFsNzL0QB5akD4C+8jLUsQO6
# J28VMSEHjf+NAgMBAAGjRjBEMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQW
# BBSLeD/1Ou0WzAiOpCCcAXPHdx3JAjAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcN
# AQEFBQADgYEAA/4vOSNsACbh5UFKLd2Eb0u4gLR+BVf8rYO7foRBM/M60p1rfUgN
# 97ONJtt1ba+JOD8vtmluc9DKMR7R2hapG1RC8g2B/NlWLH0PlInSfYdLe9AM1vzB
# 6jAVb0ALYUuPLvZbc41ZwWNNsEDAEgfqaRcl+BGSjvwib3YaFRdZtjAwggSZMIID
# gaADAgECAg8WiPA5JV5jjmkUOQfmMwswDQYJKoZIhvcNAQEFBQAwgZUxCzAJBgNV
# BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAc
# BgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3
# dy51c2VydHJ1c3QuY29tMR0wGwYDVQQDExRVVE4tVVNFUkZpcnN0LU9iamVjdDAe
# Fw0xNTEyMzEwMDAwMDBaFw0xOTA3MDkxODQwMzZaMIGEMQswCQYDVQQGEwJHQjEb
# MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
# GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEqMCgGA1UEAxMhQ09NT0RPIFNIQS0x
# IFRpbWUgU3RhbXBpbmcgU2lnbmVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEA6ek939c3CMkeOLJSU0JtIvGxxAYEa579gnRQQ33GoLsfTvkCcSax70PY
# g4xI/OcPl3qa65zepqMOOxxEGHWOeKUXaf5JGKTiu1xO/o4qVHpQ8NX2zJHnmXnX
# 3nmU15Yz/g6DviK/YxYso90oG689q+qX0vG/BBDnPUhF/R9oZcF/WZlpwCIxDGJu
# p1xlASGwY8QiGCfu5vzSAD1HLqi4hlZdBNwTFyVuHN9EDxXNt9ulV3ZCbwBogpnS
# 48He8IuUV0zsCJAiIc4iK5gMQuZCk5SYk+/9Btk/vFubVDwgse5q1kd6xauA6TCa
# 3vGkP1VNCgk0inUp0mmtlw9Qv/jKCQIDAQABo4H0MIHxMB8GA1UdIwQYMBaAFNrt
# ZHQUnBQ8q92Zqb1bKE2LPMnYMB0GA1UdDgQWBBSOay0za/Qzp5OzE5ql4Ar3EjVq
# iDAOBgNVHQ8BAf8EBAMCBsAwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggr
# BgEFBQcDCDBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vY3JsLnVzZXJ0cnVzdC5j
# b20vVVROLVVTRVJGaXJzdC1PYmplY3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggr
# BgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQUF
# AAOCAQEAujMkQECMfNtYn7NgmLL1wDH+6x9uUPYK4OTmga0mh6Lf/bPa9HPzAPsp
# G4kbFT7ba1KTK8SsOYHXPGdXmjk24CgImuM5T5uJCX97xWF/WYkyJQpqrho+8KIn
# qLbDuIf3FgRIQT1c2OyfTSAxBNlloe3NaQdTFj3dNgIKiOtA5QYwC7gWS9zvvFUJ
# /8Y+Ei52s9zOQu/5dlfhtwoFQJhYml1xFpNxjGWB6m/ziff7c62057/Zjm+qC08l
# 87jh1d11mGiB+KrA0YDCxMQ5icH2yZ5s13T52Zf4T8KaCs1ej/gZ6eCln8TwkiHm
# LXklySL5w/A6hFetOhb0Y5QQHV3QxjGCA5UwggORAgEBMC4wGjEYMBYGA1UEAwwP
# S2VubmV0aCBNYWNOZWFsAhBGsuvcrqXtl09lzcrrXF7zMAkGBSsOAwIaBQCgeDAY
# BgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3
# AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEW
# BBRiHLLim3KdZASh/c12aiBhs1fQfTANBgkqhkiG9w0BAQEFAASBgK1MSMjlngXS
# bg6U94I/rR5lr0V6vgB/IoAJrnrWlEKE3dvcjm12FbqGHm/Pyjm53VVjGfgxptAN
# UAOGdoOaQLCYz8xzeLepCmfnhq9gVC639rTOaL5sY7Z7WmiRUn9q9ZcSVH7RM68g
# LwY5neAwBDypl5xzaYzGCkGGQIWZvnMEoYICQzCCAj8GCSqGSIb3DQEJBjGCAjAw
# ggIsAgEBMIGpMIGVMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcT
# DlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsx
# ITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTEdMBsGA1UEAxMUVVRO
# LVVTRVJGaXJzdC1PYmplY3QCDxaI8DklXmOOaRQ5B+YzCzAJBgUrDgMCGgUAoF0w
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMTAz
# MTYyMDU4WjAjBgkqhkiG9w0BCQQxFgQUUDeLZJlUFt1te71cY3u4zUkJ5PMwDQYJ
# KoZIhvcNAQEBBQAEggEA1nnvdtVAaHXPnn/2swkiFSYnfXnMUOUterR/VFYHrJ9A
# wHx1F9kPvsaK1WeJN+tZdKhHlB8G4nKtkTNuV+0ElF6HVCowqArwk4bFRiTCQNP8
# zltdsbEM2roNvYC+63OuIzXFpyhOkO/IjU6n+b1juYKavnDfqnbchkHspWEeWxBP
# Mglm2Q/TceeeA0c5/nOWD4yMOtzZ8dDtph6igIp2kEKB929FKeqTGrSmb6c3jAfl
# TxzQvS0oZAOZbyBydRXfqgWy7PKVjXokNu8SmMi15ic55AspeCz2s3u5mUkQe6pq
# 4qgBassAyg7whGwUJPqC8OLb3dceHAyw3OO4nxT89w==
# SIG # End signature block
