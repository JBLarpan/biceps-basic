@description('Specifies the location for resources.')
param location string = 'eastus'


resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' ={
  name: 'toy-product-launch-plan-starter'
  location: location
  sku:{
    name: 'F1'
  }
} 

resource appServiceApp 'Microsoft.Web/sites@2023-01-01' ={
  name: 'arpan-toy-product-launch-plan-starter'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}


//az deployment group create --template-file main.bicep --resorce-group newRG
