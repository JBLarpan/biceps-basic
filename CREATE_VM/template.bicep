clear param location string
param networkInterfaceName1 string
param enableAcceleratedNetworking bool
param networkSecurityGroupName string
param networkSecurityGroupRules array
param subnetName string
param virtualNetworkName string
param addressPrefixes array
param subnets array
param publicIpAddressName1 string
param publicIpAddressType string
param publicIpAddressSku string
param pipDeleteOption string
param virtualMachineName string
param virtualMachineName1 string
param virtualMachineComputerName1 string
param virtualMachineRG string
param osDiskType string
param osDiskDeleteOption string
param virtualMachineSize string
param nicDeleteOption string
param hibernationEnabled bool
param adminUsername string
param patchMode string
param rebootSetting string
param securityType string
param secureBoot bool
param vTPM bool
param virtualMachine1Zone string

var nsgId = resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', networkSecurityGroupName)
var vnetName = virtualNetworkName
var vnetId = resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', virtualNetworkName)
var subnetRef = '${vnetId}/subnets/${subnetName}'

resource networkInterface1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', publicIpAddressName1)
            properties: {
              deleteOption: pipDeleteOption
            }
          }
        }
      }
    ]
    enableAcceleratedNetworking: enableAcceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    networkSecurityGroup
    virtualNetwork
    publicIpAddress1
  ]
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2020-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: networkSecurityGroupRules
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: subnets
  }
}

resource publicIpAddress1 'Microsoft.Network/publicIpAddresses@2020-08-01' = {
  name: publicIpAddressName1
  location: location
  properties: {
    publicIPAllocationMethod: publicIpAddressType
  }
  sku: {
    name: publicIpAddressSku
  }
  zones: [
    virtualMachine1Zone
  ]
}

resource virtualMachine1 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: virtualMachineName1
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'fromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: osDiskDeleteOption
      }
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface1.id
          properties: {
            deleteOption: nicDeleteOption
          }
        }
      ]
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    osProfile: {
      computerName: virtualMachineComputerName1
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        patchSettings: {
          patchMode: patchMode
          automaticByPlatformSettings: {
            rebootSetting: rebootSetting
          }
        }
      }
    }
    securityProfile: {
      securityType: securityType
      uefiSettings: {
        secureBootEnabled: secureBoot
        vTpmEnabled: vTPM
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
  zones: [
    virtualMachine1Zone
  ]
}

output adminUsername string = adminUsername
