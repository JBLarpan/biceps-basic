param rgName string
param location string

resource rg 'Microsoft.Resources/subscription@2021-04-01' = {
  name: rgName
  location: location
}
