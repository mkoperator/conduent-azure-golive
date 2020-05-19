# 5.3.3 Deploy HPA
## Step 1:  Add HPA to insecure deployment
`kubectl apply -f hpa.yaml` nothing hpapens.
## Step 2: Add cpu limits to deployment.
`kubectl apply -f insecure-deployment.yaml`
Now the scaling set will take.

# 5.3.2 Deploy Auto Scaler
## Step 1: 
az aks update \
  --resource-group aks-native2 \
  --name c-4hgzw \
  --cluster-autoscaler-profile scan-interval=30s

## Step 2: 
az aks nodepool update \
  --resource-group aks-native2 \
  --cluster-name c-4hgzw \
  --name rancher \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3