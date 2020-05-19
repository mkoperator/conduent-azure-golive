# 2.2.2 LAB: Rancher CLI
## Step 1: Get the Rancher CLI
You can find complete list of cli versions in: https://rancher.com/docs/rancher/v2.x/en/cli/
`wget https://github.com/rancher/cli/releases/download/v2.4.3/rancher-darwin-amd64-v2.4.3.tar.gz`

## Step 2: Gete Rancher Bearer Token and Server URL
Get this from your profile in Rancher UI

## Step 3: Login
`./rancher login https://<SERVER_URL> --token <BEARER_TOKEN>`

## Step 4: Add Project
`./rancher projects create conduent`
`./rancher projects list`
./rancher namespaces

## Step 5: Add Namespace
`./rancher namespace create conduent`

### Step 6: Move Namespace into Project
# 2.2.2 LAB: Project Namespaces
## Step 1: Download Rancher CLI
## Step 2: Get Rancher Token and Server URL
## Step 3: Login
## Step 3: dd Project
## Step 4: Add Namespace
## Step 5: Move Namespace to project