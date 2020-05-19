# 5.4.5 LAB: Resource prioritization 
## Part 5.4.5.1 Deploy Priority Classes
Deploy our priority classs.
`kubectl apply -f high-priority-class.yaml`
`kubectl apply -f low-priority-class.yaml`
## Part 5.4.5.2 Make Insecure a Low Priority Workload
`kubectl apply -f insecure-deployment.yaml`
## Part 5.4.5.3 Deploy High Priority Workload 
`kubectl apply -f secure-deployment.yaml`
## Part 5.4.5.4 Show which deployments work based on prioritization.
