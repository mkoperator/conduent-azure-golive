# 4.2.2 Deploy Privileged and Unprivileged Workloads
## Step 1: Deploy unprivilaged workload
run `kubectl apply -f isecure-deployment.yaml`
Still works even though we are specifying privileged. Take a look at the default psp.
run `kubectl delete -f secure-deployment.yaml`

## Step 2: Add Restricted PSP
`kubectl apply -f restricted-psp.yaml`

## Step 3: Set restricted as default
`kubectl apply -f role-update.yaml`

## Step 3: Test insecure deployment
run `kubectl apply -f insecure-deployment.yaml`
will fail.

## Step 4: Secure Role Binding.
run `kubectl apply -f secure-role.yaml`
Allows any ClusterOwner to deploy secure workloads.
The insecure deployment should now work if retried.

## Step 5: Check Insecure Deployment Again.