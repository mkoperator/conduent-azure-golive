# 2.3.6 LAB : Deploy RKE Cluster on Kubernetes with Rancher UI
We'll need a working Rancher Cluster and valid Azure Credentials to get started.

## Part 1 : Setup Azure Components.
### Step 1.1 : Add ResourceGroup (make rgroup)
### Step 1.2: Add Service Principal (make principal)
Once you create the principal, update the PRINCIPAL variable in Makefile. You will want to save the password.
### Step 1.3:  Add Contributor Rights to the ResourceGroup. (make role)
## Part 2 : Rancher UI
### Step 2.1 : Add Cloud Credentials
Use the system accounts we created above.
### Step 2.2 : Add Node Templates
change resourcegroup to your resourcegroup
### Step 2.3 : Create A cluster with Credentials and Template and Security Policy
You will need to enter some of the info again.