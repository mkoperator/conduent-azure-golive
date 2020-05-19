# 5.3.4 Deploy Autoscaler
## Step 1:  Add HPA to insecure deployment
`kubectl apply -f hpa.yaml` nothing hpapens.
## Step 2: Add cpu limits to deployment.
`kubectl apply -f insecure-deployment.yaml`
Now the scaling set will take.