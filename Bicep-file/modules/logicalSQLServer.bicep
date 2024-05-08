@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The administrator username of the SQL logical server:  Your login name must not contain a SQL Identifier or a typical system name (like admin, administrator, sa, root, dbmanager, loginmanager, etc.) or a built-in database user or role (like dbo, guest, public, etc.)')
param administratorLogin string
/*Your password must be at least 8 characters in length.
Your password must be no more than 128 characters in length.
Your password must contain characters from three of the following categories – English uppercase letters, English lowercase letters, numbers (0-9), and non-alphanumeric characters (!, $, #, %, etc.).
Your password cannot contain all or part of the login name. Part of a login name is defined as three or more consecutive alphanumeric characters.*/
@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

@description('Enable Microsoft Defender for SQL, the user deploying the template must have an administrator or owner permissions.')
param enableSqlDefender bool = true

@description('Allow Azure services to access server.')
param allowAzureIPs bool = true

@description('SQL logical server connection type.')
@allowed([
  'Default'
  'Redirect'
  'Proxy'
])
param connectionType string = 'Default'

resource server 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: '12.0'
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = if (allowAzureIPs) {
  parent: server
  name: 'AllowAllWindowsAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

resource protectionSetting 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2022-05-01-preview' = if (enableSqlDefender) {
  parent: server
  name: 'Default'
  properties: {
    state: 'Enabled'
  }
}

resource assessment 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2022-05-01-preview' = if (enableSqlDefender) {
  parent: server
  name: 'Default'
  properties: {
    state: 'Enabled'
  }
}

resource connectionPolicy 'Microsoft.Sql/servers/connectionPolicies@2022-05-01-preview' = {
  parent: server
  name: 'Default'
  properties: {
    connectionType: connectionType
  }
}

output serverAddress string = serverName
