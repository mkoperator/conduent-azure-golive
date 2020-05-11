# 2.3.4 LAB: Import Existing Cluster
This lab goes through importing and existing cluster. We'll add a cluster which we can import.

## Part 1: Add Cluster via Portal or via CLI 
### Step 1.1: Add A Resource Group (make rgroup)
`	az group create --name myResourceGroup --location eastus`

### Step 1.2: Add Cluster (make cluster)
This part takes a bit of time.
`az aks create --resource-group myResourceGroup --name myCluster --node-count 1 --network-plugin $azure --generate-ssh-keys`

### Step 1.3: Get/Set Credentials
`az aks get-credentials --resource-group myResourceGroup --name myClusterName`

## Part 2: Add to Rancher via Import UI
Part 2 is done via the Rancher UI.

### Step 2.1: Add Cluster
From Global View select "Add Cluster"

### Step 2.2: Import Existing
Select "Import Existing"

### Step 2.3: Select Name
Enter Name.

### Step 2.4: Install Rancher Agent Using Self Signed SSL
Once step 1.3 is completed, your kubectl should be linked to the cluster. Simply run the self signed ssl script from the Rancher UI in your CLI.