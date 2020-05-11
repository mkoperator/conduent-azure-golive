RESOURCEGROUP="rancher-import"
LOCATION="eastus"
CLUSTERNAME="rancher-import"
KUBERNETESVERSION="1.16.7"
NETWORKPLUGIN="azure"
NODECOUNT=3
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

cluster:
	az aks create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --node-count $(NODECOUNT) --network-plugin $(NETWORKPLUGIN) --generate-ssh-keys	

credentials:
	az aks get-credentials --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)
