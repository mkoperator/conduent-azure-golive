RESOURCEGROUP="rpso-rancher1"
LOCATION="eastus"
CLUSTERNAME="rpso-rancher"
KUBERNETESVERSION="1.16.7"
NODECOUNT=1
STUDENTNAME=mikhail
TRAININGDOMAIN=simpleblocks.net
HOSTNAME=$(STUDENTNAME).$(TRAININGDOMAIN)

login:
	az login

rgroup:
	az group create --name $(RESOURCEGROUP) --location $(LOCATION)

cluster:
	az aks create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --kubernetes-version $(KUBERNETESVERSION) --node-count $(NODECOUNT) --generate-ssh-keys	

credentials:
	az aks get-credentials --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)

helm:
	kubectl apply -f helm_rbac.yaml
	helm init --history-max 200 --service-account tiller --node-selectors "beta.kubernetes.io/os=linux"
	kubectl -n kube-system  rollout status deploy/tiller-deploy

cert-manager:
	kubectl create namespace cert-manager
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm install \
  	--name cert-manager \
  	--namespace cert-manager \
  	--version v0.14.2 \
  	jetstack/cert-manager \
  	--set installCRDs=true

nginx:
	helm repo add nginx-stable https://helm.nginx.com/stable
	helm repo update
	kubectl create ns ingress-nginx
	kubectl config set-context --current --namespace=ingress-nginx
	helm install --name ingress-controller nginx-stable/nginx-ingress --set enable-proxy-pass=true
	kubectl get all

rancher:
	helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
	helm repo update
	kubectl create ns cattle-system
	kubectl config set-context --current --namespace=cattle-system
	helm install rancher-latest/rancher \
  		--name rancher \
  		--namespace cattle-system \
  		--set hostname=$(STUDENTNAME).$(TRAININGDOMAIN) \
  		--set auditLog.level=1 
	kubectl -n cattle-system rollout status deploy/rancher

ingress:
	sed 's/HOSTNAME/$(HOSTNAME)/g' ingress_template.yaml > ingress.yaml
	kubectl apply -f ingress.yaml