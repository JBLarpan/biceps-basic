
//installation of logical sql server ...............

module logicalSqlServer 'modules/logicalSQLServer.bicep' = {
  name: 'logicalSQLServerDeployment'
  params:{
    administratorLogin: 'arpan'
    administratorLoginPassword: 'Pa$word#34'
    enableSqlDefender: false
    
  }
}

output serverName string = logicalSqlServer.outputs.serverAddress

// data base creation ...................

module dataBaseCreation 'modules/sqldatabase.bicep' ={
  name:'DataBaseDeployment'
  params:{
    administratorLogin: 'arpan'
    administratorLoginPassword: 'Pa$word#34'
    sqlDBName: 'arpanDB'
  }
}
