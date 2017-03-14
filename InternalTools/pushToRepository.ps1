param
(
	[string]
	$nupkgPath,
	[string]
	$serverUrl,
	[string]
	$apiKey,
	[string]
	$nugetExePath
)

if(!(Test-Path $nupkgPath))
{
	Write-Error "ERROR: Provided path for nupkg file leads to nothing '$nupkgPath'"

	return -1
}

if(!(Test-Path $nupkgPath))
{
	Write-Error "ERROR: Missing nuget.exe at path '$nugetExePath'"

	return -1
}

if([System.String]::IsNullOrEmpty($serverUrl))
{
	Write-Error "ERROR: Missing server url, provided url was '$serverUrl'"

	return -1
}

if([System.String]::IsNullOrEmpty($apiKey))
{
	if([System.String]::IsNullOrEmpty($env:NuGetGalleryApiKey))
	{
		Write-Error "ERROR: You have to provide api key for pushing package to NuGet server!"

		return -1
	}

	$apiKey = $env:NuGetGalleryApiKey;
}

Write-Host "Pushing package to server"
&"$nugetExePath" push "$nupkgPath" $apiKey -Source $serverUrl
