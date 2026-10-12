param(
    [Parameter(Mandatory = $true)][string]$SubscriptionId,
    [string]$ResourceGroup = 'rg-identity-monitoring-lab'
)
# Run inside the Azure Windows VM whose identity has Reader access.
# Do not print or publish the token response.
$ErrorActionPreference = 'Stop'
$token = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' -Headers @{Metadata='true'}
$uri = "https://management.azure.com/subscriptions/$SubscriptionId/resourcegroups/${ResourceGroup}?api-version=2021-04-01"
$result = Invoke-RestMethod -Uri $uri -Headers @{Authorization="Bearer $($token.access_token)"}
$result | Select-Object name, location
Remove-Variable token
