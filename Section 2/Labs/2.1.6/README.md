# 2.1.6 LAB: Setup RKE Rancher on Cluster
Due to socket issues with AKS Rancher without complicated networking setup. We will redo the installation as a single node RKE VM.

Remove previous cluster stuff.

## Part 1 : Azure Resource Creation
We must create a new vm on which the cluster will sit.

### Step 1.1: Create a resource group. (make rgroup)
`az group create --name rpso-rke --location eastus`

### Step 1.2: Create Local SSH Key (make genkey)

### Step 1.3: Create a single node vm. (make vmss)
az vmss create --resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME) --image UbuntuLTS --instance-count $(NODECOUNT) --upgrade-policy-mode manual  --public-ip-per-vm --admin-username azureuser --ssh-key-values id_rsa.pub --custom-data azureinit.yaml

### Step 1.4: Add Load Balancer Rules (make lb)
az network lb rule create--resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)RuleWeb1 --lb-name $(CLUSTERNAME)LB --backend-pool-name $(CLUSTERNAME)LBBEPool --backend-port 80 --frontend-ip-name loadBalancerFrontEnd --frontend-port 80 --protocol tcp

az network lb rule create--resource-group $(RESOURCEGROUP) --name $(CLUSTERNAME)RuleWeb2 --lb-name $(CLUSTERNAME)LB --backend-pool-name $(CLUSTERNAME)LBBEPool --backend-port 443 --frontend-ip-name loadBalancerFrontEnd --frontend-port 443 --protocol tcp

### Step 1.5: Get LB & VM IP (manual)
Load Balancer IP Will be our Rancher IP and pointed to our hostname.

### Step 1.6: Update cluster.yml (manual)
we need to update internal and external ip in cluster.yml

### Step 1.7: RKE Install (make rke)

### Step 1.8: Move Creentials (make crdentails)

## Part 2 : Configure Helm and Install Rancher
### Step 2.1: Initialize Helm (make helm)
`kubectl apply -f helm_rbac.yaml`
`helm init --history-max 200 --service-account tiller --node-selectors "beta.kubernetes.io/os=linux"`

** Test: `kubectl -n kube-system  rollout status deploy/tiller-deploy` ***

### Step 2.2: Install Cert Manager (make cert-manager)

#### Step 2.2.1: Create cert-manager Namespace
`kubectl create namespace cert-manager`

#### Step 2.2.2: add cert manager catalog
`helm repo add jetstack https://charts.jetstack.io`

#### Step 2.2.3: update from helm chart Repositories
`helm repo update`

#### Step 2.2.4: Install Helm Chart
```

helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.14.2 \
  jetstack/cert-manager \
  --set installCRDs=true
7
```

### Step 2.3: Install Rancher (rancher)
#### Step 2.3.1: Add Rancher Catalog and Update
	`helm repo add rancher-latest https://releases.rancher.com/server-charts/latest`
	`helm repo update`

#### Step 2.3.2: Add cattle-system Namespace
    `kubectl create ns cattle-system`

#### Step 2.3.3: Switch to cattle-system Namespace
	`kubectl config set-context --current --namespace=cattle-system`

#### Step 2.3.4: Install Rancher Chart
Install Rancher with the helm chart.
```
helm install rancher-latest/rancher \
  		--name rancher \
  		--namespace cattle-system \
  		--set hostname=mikhail.simpleblocks.net \
  		--set auditLog.level=1
```