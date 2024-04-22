param apimName string
param zones array
param location string
param tier string
param capacity string
param adminEmail string
param organizationName string
param virtualNetworkType string
param tagsByResource object
param vnet object
param customProperties object
param identity object
param appInsightsObject object
param privateEndpoint object
param privateDnsDeploymentName string
param subnetDeploymentName string

var apimNsgName = 'apimnsg${uniqueString(resourceGroup().id)}${apimName}'

resource apim 'Microsoft.ApiManagement/service@2022-09-01-preview' = {
  name: apimName
  location: location
  sku: {
    name: tier
    capacity: capacity
  }
  zones: zones
  identity: identity
  tags: tagsByResource
  properties: {
    publisherEmail: adminEmail
    publisherName: organizationName
    customProperties: customProperties
  }
  dependsOn: []
}
