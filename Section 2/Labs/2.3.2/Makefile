RESOURCEGROUP="rancher-client"
LOCATION="eastus"
SERVICEACCOUNT="rancher-client"
PID=25d5b6d4-9c0c-40cd-9c7b-929c7659242b
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

principal:
	az ad sp create-for-rbac --name rancher-client

role: 
	az role assignment create --assignee $(PID) --role Contributor