RESOURCEGROUP="rancher-import2"
LOCATION="eastus"
CLUSTERNAME="rancher-import2"
KUBERNETESVERSION="1.16.7"
NETWORKPLUGIN="azure"
NODECOUNT=1
RANCHERURL=https://mikhail.simpleblocks.net/v3
RANCHERTOKEN=token-9pv87:99mwh68jrzdr28bmn6w472lf9l6jx2z67lwk95lvnxz6wjsjhbrpm8
RANCHERID=c-k26hr
rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

cluster:
	az aks create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --node-count $(NODECOUNT) --kubernetes-version $(KUBERNETESVERSION) --generate-ssh-keys	

credentials:
	az aks get-credentials --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)

rlogin:
	rancher login $(RANCHERURL) --token $(RANCHERTOKEN)

raddcluster:
	rancher cluster create --import $(CLUSTERNAME)

rimportcluster:
	rancher cluster import c-k26hr $(CLUSTERNAME)

	