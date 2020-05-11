# 2.3.2 LAB: Add AKS Cluster Via Rancher UI
To add an AKS Cluster via the Rancher UI you will need a service account from azure with Contributor role to the Resource Group in which you wish to create the cluster.

## Part 1: Add Azure Service Principal
### Section 1.1: Create ResourceGroup (make rgroup)
Go to azure portal under Resource Groups
Add a new resource group.
`az group create --name myResourceGroup --location eastus`

### Section 1.2: Add Application (make principal)
Add the application by going to Azure Active Directory.
Then Applications. 
Add a new Application.
`az ad sp create-for-rbac --name rancher-client`

### Section 1.3: Add Contributor Role (make role)
Select Role Assignments from the application menu. 
Add new assignment.
Select Contributor and save.
`az role assignment create --assignee PRINCIPAL_ID --role Contributor`

## Part 2: Create in Rancher UI
No make scripts are offered for part 2. They must be done via the ui.

### Section 2.1: Add Cluster
Select Azure AKS

### Section 2.2: Input and Validate Credentials
Add credentials created in Part 1 and Authenticate.

### Section 2.3: Configure Cluster and Create
Add a Cluster Name.
Select the latest kubernetes version available. Select a 3 node cluster.
Use the resource group created above: rancher-test
Select Advanced Networking, and the Calico Network policy.
Disable Monitoring.
Finally upload your public key likely found in ~/.ssh/id_rsa.pub