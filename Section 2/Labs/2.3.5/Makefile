RESOURCEGROUP="rancher-import6"
LOCATION="eastus"
CLUSTERNAME="rancher-import6"
KUBERNETESVERSION="1.16.7"
NETWORKPLUGIN="azure"
NODECOUNT=3
RANCHERURL=https://mikhail.simpleblocks.net/v3
RANCHERTOKEN=token-qvv8v:pv7fbgr6qwmh2s6ctnxv2g7574fw87bmbr9z7jlz42h8565rbxbmqd
RANCHERID=c-sr7bl

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

rlist:
	rancher cluster list

rimportcluster:
	rancher cluster import $(RANCHERID) $(CLUSTERNAME)

	