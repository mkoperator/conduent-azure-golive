RESOURCEGROUP=rke-native
LOCATION=eastus
CLUSTERNAME="rke-native
PRINCIPALNAME=ServicePrincipal
ASSIGNEE=582ba66a-8316-44f1-9f17-deb669f2221c
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

principal:
	az ad sp create-for-rbac --name $(PRINCIPALNAME)

role:
	az role assignment create --role Contributor --assignee $(ASSIGNEE) --resource-group $(RESOURCEGROUP)