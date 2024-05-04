/*parameters are the value which needed at the time of deployments where as varaible is some intermediate value
which is internal to the bicep script

parameters can be override while calling the deployment

ex. -  
parameter use cases: 
- Region or location where resources should be deployed.
- Sizes or configurations of resources (e.g., VM size, SKU).
- Names or labels for resources (e.g., storage account name, virtual network name).
variable use cases: 
- Concatenate strings to form resource names.
- Calculate derived values based on parameters or other variables.
- Define reusable configurations or expressions.

@allowed - is defining se  of values the parameter can accept

if else :  <condition> ? 'value if condition is true' : 'value if condition is false'

*/

param location string = 'eastus'
param storageAccountName string = 'arpantoy${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'arpantoy${uniqueString(resourceGroup().id)}'
var appServicePlanName = 'toy-product-launch-plan-1'

//only accepted environment type is prod and non-prod, other value will thorow an error.
@allowed(
  [
    'non-prod'
    'prod'
  ]
)
param environmentType  string

var storageAccountSku = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSku  = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
  }

  resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' ={
    name: appServicePlanName
    location: location
    sku:{
      name: appServicePlanSku
    }
  } 
  
  resource appServiceApp 'Microsoft.Web/sites@2023-01-01' ={
    name: appServiceAppName
    location: location
    properties: {
      serverFarmId: appServicePlan.id
      httpsOnly: true
    }
  }



  /*az deployment group create 
  --resource-group newRG
  --template-file main.bicep 
  --parameters environmentType=non-prod*/


   //appplan deployment issue - The subscription '2565ff8a-391c-4dbc-b5e6-36303da1943c' is not allowed to create or update the serverfarm.
   //ticket is here:  https://learn.microsoft.com/en-us/answers/questions/1659099/the-subscription-is-not-allowed-to-create-or-updat
