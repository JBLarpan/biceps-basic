@description('Specifies the location for resources.')
param location string = 'centralus'

resource moduleStrorage 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name:  'exmplemodulestorage'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

output storageName string = moduleStrorage.name
output storageLocation string= moduleStrorage.location
