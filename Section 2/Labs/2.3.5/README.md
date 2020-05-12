# 2.2.2 LAB: Rancher CLI
## Part 1: Azure Resources
### Step 1.1: Provision Resource Group (make rgroup)
### Step 1.2: Provision AKS Cluster (make cluster)
### Step 1.3: Get Credentials (make credentails)
## Part 2: Rancher CLI
You can find complete list of cli versions in: https://rancher.com/docs/rancher/v2.x/en/cli/
`wget https://github.com/rancher/cli/releases/download/v2.4.3/rancher-darwin-amd64-v2.4.3.tar.gz`

### Step 1: Get Rancher Bearer Token and Server URL
Get this from your profile in Rancher UI

### Step 2: Login
`./rancher login https://<SERVER_URL> --token <BEARER_TOKEN>`

### Step 3: Add Cluster
`./rancher cluster create --import clsterName`

## Step 4: Import Cluster
`./rancher namespace create <clusterid> conduent`

## Step 5: Insecure Import String