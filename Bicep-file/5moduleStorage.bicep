@description('Specifies the location for resources.')
param location string = 'eastus'

module storageCreator 'modules/storagemodule.bicep' ={
  name: 'storageCreatorService'
  params:{
    location: location
  }
}
output  storageName string = storageCreator.outputs.storageName
output storageLocation string= storageCreator.outputs.storageLocation
