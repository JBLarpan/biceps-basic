param location string = resourceGroup().location
@minLength(3)
@maxLength(24)
@description('storage account must not be having any uppercase letter and minimum to maximum length is 3 to 24, must be unique accross azure space')
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'bicep-quickstart-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource examplestorage 'Microsoft.Storage/storageAccounts@' = {
  name: 'bicepquickstartvnet'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
