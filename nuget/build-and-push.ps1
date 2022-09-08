# 定义参数
Param(
    # Nuget APIKey
    [string] $apikey
)

if ($apikey -eq $null -or $apikey -eq "")
{
    Write-Error "必须指定apiKey";
    return;
}

rm -r ../src/Ocelot/bin/Release
dotnet build -c Release ../Ocelot.sln
$files = Get-ChildItem -Path ../src/Ocelot/bin/Release -Filter *-ns*.nupkg
foreach($file in $files)
{
    dotnet nuget push $file.fullName --skip-duplicate --api-key $apikey --source https://api.nuget.org/v3/index.json
}
$files = Get-ChildItem -Path ../src/Ocelot/bin/Release -Filter *-ns*.snupkg
foreach($file in $files)
{
    dotnet nuget push $file.fullName --skip-duplicate --api-key $apikey --source https://api.nuget.org/v3/index.json
}