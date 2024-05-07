@description('Specifies the location for resources.')
param location string = 'eastus'

@description('put the list of allowed enviornment ....')

@allowed(['dev', 'prod', 'test'])
param enviornmentType string = 'test'

@description('decide number of storgae account to create based on enviornment type ....')
param numberOfStorage int = (enviornmentType =='dev'? 1: enviornmentType == 'prod'? 4: enviornmentType =='test'?2:0)

output number int = numberOfStorage

@description('create storage account prefix...')
param stroragePrefix string = (enviornmentType =='dev'? 'dev': enviornmentType == 'prod'? 'prod': enviornmentType =='test'?'test':'invalid')

output prefix string= stroragePrefix


/*resource moduleStrorage 'Microsoft.Storage/storageAccounts@2023-01-01'=[for i in range(1,numberOfStorage):{
  name:  '${stroragePrefix}arpanstoragedirect${i}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}] */


module storageCreator 'modules/storagemodule.bicep' = [for i in range(1,numberOfStorage):{
  name:  'deployment${i}'
  params:{
  storageName: '${stroragePrefix}arpanstoragemodule${i}'
  location: location
}
  
}]

