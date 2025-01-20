# 
params(
    [String]$Path,
    [String]$CSV,
    [Switch]$Check
)

$Users = Import-CSV -Path "$Path\$CSV"
foreach ($User in $Users) {
    $UserName = $User.'SAM'
    $Attribute = Get-ADUser -Identity $UserName -Properties * | Select-Object attribute
    if($Check){
        if($Attribute.attribute -ne $true){
            Write-Host "attribute is not set on user: $($UserName)"
        } else {
            Write-Host "attribute is set on user: $($UserName)"
        }
    } else {
        if($Attribute.attribute -ne $true){
            Write-Host "Setting attribute on user: $($UserName)"
            Set-ADUser -Identity $UserName -Replace @{attribute=$true}
        }
    }
}