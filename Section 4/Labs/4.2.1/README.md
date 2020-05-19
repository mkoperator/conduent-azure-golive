# 4.2.1 LAB: Add Pod Security Policies to Local Rancher cluster
- Modify the cluster.yml in Section 2/Labs/2.1.6
- Update cluster.yml to comment out `pod_security_policy=false`, then uncomment `# pod_security_policy: true`.
- run `rke up`
- test with `kubectl apply -f validate-psp.yaml` in the default namespace, if it fails due to pod security policy you did well.
- Add a default policy for the namespace `kubectl apply -f role.yaml`
- test with `kubectl apply -f validate-psp.yaml` in the default namespace, if it fails due to pod security policy you did well.


