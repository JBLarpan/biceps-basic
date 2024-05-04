@description('Specifies the location for resources.')
param location string = 'eastus'
targetScope = 'resourceGroup'
/* This is a practice file from 
below link 
https://learn.microsoft.com/en-in/training/modules/build-first-bicep-template/4-exercise-define-resources-bicep-template?pivots=cli*/

//Create a Bicep template that contains a storage account

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
name: 'arpantoylaunchstorage'
location: location
sku: {
  name: 'Standard_LRS'
}
kind: 'StorageV2'
properties:{
  accessTier: 'Hot'
}
}


//az deployment group create --template-file main.bicep --resource-group newRG
