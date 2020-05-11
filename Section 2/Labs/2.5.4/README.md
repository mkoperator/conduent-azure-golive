# 2.5.4 LAB: Project setup with Resource Limits
## Step 1: Rancher UI : Add Project
Go into Rancher UI Admin and add a project. Restrict project to 500mcpu.

## Step 2: Add a namespace to project.

## Step 3: Try to deploy a workload without limits
`kubectl apply -f deployment.yaml`
