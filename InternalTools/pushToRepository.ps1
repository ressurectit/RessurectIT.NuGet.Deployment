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

if(!(Test-Path $nugetExePath))
{
	Write-Error "ERROR: Missing nuget.exe at path '$nugetExePath'"

	return -1
}

if([System.String]::IsNullOrEmpty($serverUrl))
{
	if([System.String]::IsNullOrEmpty($env:NuGetGalleryServerUrl))
	{
		Write-Warning "WARNING: Missing server url, provided url was '$serverUrl'!"
	}
	else 
	{
		$serverUrl = $env:NuGetGalleryServerUrl;
		Write-Host "Using server url value from ENVIRONMENT VARIABLE '$serverUrl'"
	}
}

if([System.String]::IsNullOrEmpty($apiKey))
{
	if([System.String]::IsNullOrEmpty($env:NuGetGalleryApiKey))
	{
		Write-Error "ERROR: You have to provide api key for pushing package to NuGet server!"

		return -1
	}

	$apiKey = $env:NuGetGalleryApiKey;
	Write-Host "Using API key value from ENVIRONMENT VARIABLE"
}

Write-Host "Pushing package to server"

if([System.String]::IsNullOrEmpty($serverUrl))
{
	&"$nugetExePath" push "$nupkgPath" $apiKey
}
else 
{
	&"$nugetExePath" push "$nupkgPath" $apiKey -Source $serverUrl
}
