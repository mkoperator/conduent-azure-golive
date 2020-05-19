RESOURCEGROUP="aks-native2"
LOCATION="eastus"
SERVICEACCOUNT="aks-native2"
APPID=cba9f24c-f63c-439d-98e8-6df87c646da1
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

principal:
	az ad sp create-for-rbac --name aks-native2

role: 
	az role assignment create --assignee $(APPID) --role Contributor 
	# -g $(RESOURCEGROUP)