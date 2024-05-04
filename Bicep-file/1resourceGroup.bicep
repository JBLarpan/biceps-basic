@description('Specifies the location for resources.')
param location string = 'eastus'
targetScope = 'subscription'
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'arpantoyRG'
  location: location
} 

//az deployment sub create  --template-file resourceGroup.bicep  --location eastus
