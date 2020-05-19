RESOURCEGROUP="rancher-import8"
LOCATION="eastus"
CLUSTERNAME="rancher-import8"
KUBERNETESVERSION="1.16.7"
NETWORKPLUGIN="azure"
NODECOUNT=3
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

cluster:
	az aks create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --node-count $(NODECOUNT) --kubernetes-version $(KUBERNETESVERSION) --generate-ssh-keys	

credentials:
	az aks get-credentials --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)
