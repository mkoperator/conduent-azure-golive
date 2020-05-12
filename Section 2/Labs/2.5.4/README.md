# 2.5.4 LAB: Project setup with Resource Limits
## Step 1: Deploy Deployment with no Limit in Default Project
`kubectl apply -f deployment.yaml`
## Step 2: Add Resource Limit of 1cpu to project with default.	
## Step 3: Add Namespace ‘conduent’ to no project.
## Step 4: Try to move namespace into project.
## Step 5: Remove Project limits and move namespace.
## Step 6: Move namespace.
## Step 7: Try to redeploy to to old namespace.
`kubectl apply -f deployment.yaml`
## Step 8: Deploy to new namespace.
`kubectl apply -f deployment.yaml`
