# Resource prioritization
https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/


## Enable Default Quotas
https://kubernetes.io/docs/concepts/policy/resource-quotas/#limit-priority-class-consumption-by-default



## Disabling Preemption
```
apiVersion: kubescheduler.config.k8s.io/v1alpha1
kind: KubeSchedulerConfiguration
algorithmSource:
  provider: DefaultProvider

...

disablePreemption: true
```

## What Is Preemption
Using priority classes like below we can set order for which one is higher and which one is lower.

Higher is higher priority.

```
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
description: "This priority class should be used for XYZ service pods only."
```

### Assign priority to pod
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  priorityClassName: high-priority
```

### Pod Disruption Budget
Set how many maximum amount of pods can be unavailable.
https://kubernetes.io/docs/concepts/workloads/pods/disruptions/

### Configuring Pod Disruption
https://kubernetes.io/docs/tasks/run-application/configure-pdb/

```
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: zk-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: zookeeper
```
