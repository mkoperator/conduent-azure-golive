# Section 4 : Security Topics
## CIS Bench
CIS Benchmarks help harden clusters and validate current settings.

- Rancher's RKE Testing:
  https://rancher.com/docs/rancher/v2.x/en/security/benchmark-2.1/

- Aqua's Open Source Projects:
  https://github.com/aquasecurity/kube-bench
  https://github.com/aquasecurity/kube-hunter

## Image Scanning
- Currently with Sonarqube (enterprise).
- Open source container scanning can be had through https://github.com/aquasecurity/trivy
- Looking for recommendation from Rancher team.

## Secret Encryption - they use key vault, basic discussion
You are using Key Vault, excellent choice. Currently not integrated into secret storage.

Customers will not have access to create their own secrets, application helm templates will include code for securing secrets.

KeyVault kubernetes secret storage using csi driver:
https://github.com/Azure/secrets-store-csi-driver-provider-azure

## Runtime Threat Detection
Not currently utilizing. Topics of image scanning, network policies, and opa were covered. Looking for Rancher team to provide recommendations.

### OPA
Open Policy Agent Gatekeeper checks and validates workloads prior to allowing them into the cluster.
https://kubernetes.io/blog/2019/08/06/opa-gatekeeper-policy-and-governance-for-kubernetes/


## Pod Security Policies
Utilize to prevent unrestricted access to the nodes and protect the cluster from errant access. Currently Preview in AKS. Should be ready to implement before launch.

### Rancher allows pod security Policies for RKE
https://rancher.com/docs/rancher/v2.x/en/admin-settings/pod-security-policies/

### Azure Pod Security Policy:
https://docs.microsoft.com/en-us/azure/aks/use-pod-security-policies

### Kubernetes Core Concepts
https://kubernetes.io/docs/concepts/policy/pod-security-policy/


## Network Plugins
Utilizing Azure CNI currently to map private ip addresses to pod and allow internal access from company network.

### Azure CNI
https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni

### Default Kubenet Plugin
https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/#kubenet

## Network Policy
Specify what can a pod access within namespace. Currently not using any policy. Calico or Azure policies would be effective if other services not required.

### Network policy options in kubenetes
https://kubernetes.io/docs/concepts/services-networking/network-policies/


### Using Calico for Azure CNI
https://azure.microsoft.com/en-us/blog/integrating-azure-cni-and-calico-a-technical-deep-dive/

tl;dr: Use Calico for compatibility with istio and Calico's extended features.


## SSL Termination
- Azure Application Load Balancer is a reasonable place to terminate SSL as long as traffic is routed privately from that point on. Depends on your level of trust in your (Azure) network.
