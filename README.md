Why use ARM templates?
There are many benefits to using ARM templates, either JSON or Bicep, for your resource provisioning.
Repeatable results: ARM templates are idempotent, which means that you can repeatedly deploy the same template and get the same result. The template doesn't duplicate resources.
Orchestration: When a template deployment is submitted to the Resource Manager, the resources in the template are deployed in parallel. This process allows deployments to finish faster. Resource Manager orchestrates these deployments in the correct order if one resource depends on another.
Preview: The what-if tool, available in Azure PowerShell and Azure CLI, allows you to preview changes to your environment before template deployment. This tool details any creations, modifications, and deletions that will be made by your template.
Testing and Validation: You can use tools like the Bicep linter to check the quality of your templates before deployment. ARM templates submitted to Resource Manager are validated before the deployment process. This validation alerts you to any errors in your template before resource provisioning.
Modularity: You can break up your templates into smaller components and link them together at deployment.
CI/CD integration: Your ARM templates can be integrated into multiple CI/CD tools, like Azure DevOps and GitHub Actions. You can use these tools to version templates through source control and build release pipelines.
Extensibility: With deployment scripts, you can run Bash or PowerShell scripts from within your ARM templates. These scripts perform tasks, like data plane operations, at deployment. Through extensibility, you can use a single ARM template to deploy a complete solution.

First set the subscription :
az account set --subscription 2565ff8a-391c-4dbc-b5e6-36303da1943c


Download the arm template and then cretae below 
Bicep to create : 
Decompile the json to bicep az bicep decompile --file main.json

then run using:
az deployment sub create  --template-file raw-resource-grp.bicep --parameters param-resource-grp.json --location eastus

create APIM instance 

az deployment group  create --template-file template.bicep --parameter parameters.json --resource-group  Test-resorce-grp --location eastus


install graph ql 

create VM. (Standard B2ats v2 (2 vcpus, 1 GiB memory) )
Open port 4000	
install graphql,node and appolo server from following link 

https://www.apollographql.com/docs/apollo-server/getting-started/
