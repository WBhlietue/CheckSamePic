cd images
if (Test-Path "../export" -PathType Container) {
    Remove-Item -Path "../export" -Recurse -Force
} 
if (Test-Path "../result" -PathType Container) {
    Remove-Item -Path "../result" -Recurse -Force
} 
New-Item -Path "../result" -ItemType Directory | Out-Null
$a = ls | Sort-Object LastWriteTime
$sameValue = 50
$maxValue = 100
$dirIndex = 0
$list = New-Object System.Collections.ArrayList
for ($i = 0; $i -lt $a.length; $i++){
    $list+= $a[$i].name
}
for($i= 0; $i -lt $list.length; $i++){
    $dirName = "../export/$dirIndex"
    Clear-Host
    New-Item -Path $dirName -ItemType Directory | Out-Null
    $curName = $list[$i]
    echo "checking for $curName"
    echo "target folder $dirName"
    $str = "$i / $($list.length) ($([int](($i/$list.length*100) * 100)/100)%))"
    echo $str
    for($j = $i+1; $j -lt $list.length; $j++)
    {
        $value = (python ../main.py $list[$i] $list[$j]).Split(".")[0]
        $value = [int]$value
        if($value -lt $sameValue){
            Copy-Item -Path $list[$j] -Destination $dirName
            $i++;
        }
        if($value -gt $maxValue){
            break;
        }
    }
    
    Copy-Item -Path $curName -Destination $dirName
    Copy-Item -Path $curName -Destination "../result/"
    $dirIndex++
}