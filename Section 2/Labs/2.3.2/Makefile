RESOURCEGROUP="aks-native"
LOCATION="eastus"
SERVICEACCOUNT="aks-native"
APPID=1d338d0e-8de8-4ad5-a10f-a34b01dd2e47
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

principal:
	az ad sp create-for-rbac --name aks-native

role: 
	az role assignment create --assignee $(APPID) --role Contributor -g $(RESOURCEGROUP)