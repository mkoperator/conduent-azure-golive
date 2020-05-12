#!/bin/bash
az ad sp create-for-rbac --skip-assignment -o json > auth.json
appId=$(jq -r ".appId" auth.json)
password=$(jq -r ".password" auth.json)
objectId=$(az ad sp show --id $appId --query "objectId" -o tsv)
cat <<EOF > parameters.json
{
	"aksServicePrincipalAppId": { "value": "$appId" },
	"aksServicePrincipalClientSecret": { "value": "$password" },
	"aksServicePrincipalObjectId": { "value": "$objectId" },
	"aksEnableRBAC": { "value": true }
}
EOF
wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/deploy/azuredeploy.json -O template.json

resourceGroupName="rpso-aks1"
location="eastus"
deploymentName="ingress-appgw"

# create a resource group
az group create -n $resourceGroupName -l $location

# modify the template as needed
az group deployment create \
        -g $resourceGroupName \
        -n $deploymentName \
        --template-file template.json \
        --parameters parameters.json

az group deployment show -g $resourceGroupName -n $deploymentName --query "properties.outputs" -o json > deployment-outputs.json

aksClusterName=$(jq -r ".aksClusterName.value" deployment-outputs.json)
resourceGroupName=$(jq -r ".resourceGroupName.value" deployment-outputs.json)

az aks get-credentials --resource-group $resourceGroupName --name $aksClusterName

kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment-rbac.yaml

kubectl create serviceaccount --namespace kube-system tiller-sa
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller-sa
helm init --tiller-namespace kube-system --service-account tiller-sa

helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update

applicationGatewayName=$(jq -r ".applicationGatewayName.value" deployment-outputs.json)
resourceGroupName=$(jq -r ".resourceGroupName.value" deployment-outputs.json)
subscriptionId=$(jq -r ".subscriptionId.value" deployment-outputs.json)
identityClientId=$(jq -r ".identityClientId.value" deployment-outputs.json)
identityResourceId=$(jq -r ".identityResourceId.value" deployment-outputs.json)

wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/sample-helm-config.yaml -O helm-config.yaml

sed -i .bak "s/<subscriptionId>/$subscriptionId/g" helm-config.yaml
sed -i .bak "s/<resourceGroupName>/$resourceGroupName/g" helm-config.yaml
sed -i .bak "s/<applicationGatewayName>/$applicationGatewayName/g" helm-config.yaml
sed -i .bak 's/<identityResourceId>/${identityResourceId}/g' helm-config.yaml
sed -i .bak "s/<identityClientId>/$identityClientId/g" helm-config.yaml


helm install rancher-latest/rancher \
	--name rancher \
	--namespace cattle-system \
	--set hostname=mikhail.simpleblocks.net \
	--set auditLog.level=1 \
	--set tls=external \
	--set ingress.extraAnnotations='kubernetes.io/ingress.class: azure/application-gateway'

