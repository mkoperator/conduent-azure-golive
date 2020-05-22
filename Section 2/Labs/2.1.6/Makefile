RESOURCEGROUP=rke-rancher
LOCATION=eastus
CLUSTERNAME=rke-rancher
NODECOUNT=1
STUDENTNAME=rancher
TRAININGDOMAIN=simpleblocks.net
HOSTNAME=$(STUDENTNAME).$(TRAININGDOMAIN)

login:
	az login

rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

genkey:
	ssh-keygen -m PEM -t rsa -b 4096 -f id_rsa -q -N ""

vmss:
	az vmss create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --image UbuntuLTS --instance-count $(NODECOUNT) --upgrade-policy-mode manual  --public-ip-per-vm --admin-username azureuser --ssh-key-values id_rsa.pub --custom-data azureinit.yaml

lb:
	az network lb rule create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)RuleWeb1 --lb-name $(CLUSTERNAME)LB --backend-pool-name $(CLUSTERNAME)LBBEPool --backend-port 80 --frontend-ip-name loadBalancerFrontEnd --frontend-port 80 --protocol tcp
	az network lb rule create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)RuleWeb2 --lb-name $(CLUSTERNAME)LB --backend-pool-name $(CLUSTERNAME)LBBEPool --backend-port 443 --frontend-ip-name loadBalancerFrontEnd --frontend-port 443 --protocol tcp

rke:
	rke up

credentials:
	cp -f kube_config_cluster.yml ~/.kube/config

helm:
	kubectl apply -f helm_rbac.yaml
	helm init --history-max 200 --service-account tiller --node-selectors "beta.kubernetes.io/os=linux"
	kubectl -n kube-system  rollout status deploy/tiller-deploy

cert-manager:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.3/cert-manager.yaml
	helm install \
  	--name cert-manager \
  	--namespace cert-manager \
  	--version v0.14.3 \
  	jetstack/cert-manager


rancher:
	helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
	helm repo update
	#kubectl create ns cattle-system
	kubectl config set-context --current --namespace=cattle-system
	helm install rancher-latest/rancher \
  		--name rancher \
  		--namespace cattle-system \
  		--set hostname=$(STUDENTNAME).$(TRAININGDOMAIN) \
  		--set auditLog.level=1 \
		--set tls=external
	kubectl -n cattle-system rollout status deploy/rancher
