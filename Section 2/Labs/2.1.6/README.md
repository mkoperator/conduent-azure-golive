# 2.1.6 LAB: Setup AKS Rancher on Cluster
This is the most involved and important lab of the course. Setting up a base Rancher 2.x installation is required to complete the course.

The lab is broken up into two components, Azure Resource Creation and then Rancher Deployment. The Azure resource creation can be done via the commandline or via the portal. The Rancher Deployment part is done via helm in the commandline. Your machine should meet the course's lab requirements. 

Be sure to login to azure via the cli.

If using the Make commands, please customise student values in `Makefile`.

## Part 1 : Azure Resource Creation
We must create an aks cluster in a new resource group in your subscription. A Single node 'Standard DS2 v2' cluster.

### Step 1.1: Create a resource group. (make rgroup)
`az group create --name rpso-r3 --location eastus`

### Step 1.2: Create a single node cluster. (make cluster)
`az aks create --resource-group rpso-r3 --name rpso-r3 --node-count 1 --kubernetes-version 1.16.7 --generate-ssh-keys`

** ~ 10 minute runtime. **

### Step 1.3: Get AKS Credentials (make credentials)
`az aks get-credentials --resource-group rpso-r3 --name rpso-r3`

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

```

### Step 2.3: Install Nginx (make nginx)
#### Step 2.3.1: Add Nginx Helm Chart Catalog
    `helm repo add nginx-stable https://helm.nginx.com/stable`
    `helm repo update`

#### Step 2.3.2: Create ingress-nginx Namespace
	`kubectl create ns ingress-nginx`

#### Step 2.3.3: Change namespace to ingress-nginx
	`kubectl config set-context --current --namespace=ingress-nginx`

#### Step 2.3.4: Install Nginx Controller
	`helm install --name ingress-controller nginx-stable/nginx-ingress`

#### Step 2.3.5: Get External IP
	`kubectl get all`

### Step 2.4: Share Public IP with instructor to create .simpleblocks.net subdomain.


### Step 2.5: Install Rancher (rancher)
#### Step 2.5.1: Add Rancher Catalog and Update
	`helm repo add rancher-latest https://releases.rancher.com/server-charts/latest`
	`helm repo update`

#### Step 2.5.2: Add cattle-system Namespace
    `kubectl create ns cattle-system`

#### Step 2.5.3: Switch to cattle-system Namespace
	`kubectl config set-context --current --namespace=cattle-system`

#### Step 2.5.4: Install Rancher Chart
Install Rancher with the helm chart.
```
helm install rancher-latest/rancher \
  		--name rancher \
  		--namespace cattle-system \
  		--set hostname=mikhail.simpleblocks.net \
  		--set auditLog.level=1
```

### Step 2.5: Link Ingress to Rancher (make ingress)
Update the ingress and replace the word 'HOSTNAME' with your actual hostname.
    `vi ingress_template.yaml`
    `kubectl apply -f ingress_template.yaml`