# Kubernetes: Interactive Lab

Goal: Learn core Kubernetes components, operations, and resource management using `kubectl` and YAML.

## Technical Requirements

The following components are necessary to complete this lab:

- [ ] [Docker](https://docs.docker.com/engine/install/) installation
- [ ] Kubernetes cluster using [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [ ] [kubectl](https://kubernetes.io/docs/tasks/tools/) configured

## Step 0: Setup and Verification

Generate Bash completion:
```bash
minikube completion bash | sudo tee /usr/share/bash-completion/completions/minikube
kubectl completion bash | sudo tee /usr/share/bash-completion/completions/kubectl
```

Check versions:
```bash
kubectl version
minikube version
```

Check cluster status:
```bash
kubectl cluster-info
minikube status
```

Check nodes:
```bash
kubectl get nodes
kubectl get nodes minikube
```

Check context:
```bash
kubectl config get-contexts
kubectl config current-context
```

### Checkpoint

- [ ] You can use Tab-completion for `minikube` and `kubectl`
- [ ] You've got a running Kubernetes cluster
- [ ] You can use `kubectl`

## Step 1: Kubernetes Core Components

Understand these components:

| Component          | Role                           |
|--------------------|--------------------------------|
| API Server         | Frontend for the control plane |
| etcd               | Cluster key-value store        |
| Scheduler          | Assigns pods to nodes          |
| Controller Manager | Maintains cluster state        |

Get component statuses:
```bash
kubectl get cs
kubectl get componentstatuses
```

### Checkpoint

- [ ] You know what API server, etcd, scheduler, and controllers do
- [ ] You can explain their roles
- [ ] You can draw an image showing their dependencies

## Step 2: Create Your First Pod

**Key Concept**: 

- [ ] A **Pod** is the **smallest deployable unit** and **holds containers**.

Create a pod:
```bash
kubectl run nginx --image=nginx --restart=Never
```

Check your pod:
```bash
kubectl get pods
kubectl describe pod nginx
```

### Checkpoint

- [ ] You understand what a Pod is
- [ ] You created a pod
- [ ] You viewed details from your pod

## Step 3: Use YAML for Declarative Resource Management

Create `nginx-pod.yaml`:
```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx-yaml
spec:
  containers:
  - name: nginx
    image: nginx
```

Apply the file:
```bash
kubectl apply -f nginx-pod.yaml
```

Compare:
```bash
kubectl get pods
```

### Checkpoint

- [ ] You defined and created a Pod using `yaml`
- [ ] You understand the difference between imperative and declarative in Kubernetes

## Step 4: Deployments and Scaling

Create ```nginx-deployment.yaml```bash:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
```

Apply and check:
```bash
kubectl apply -f nginx-deployment.yaml
kubectl get deployments
kubectl get pods
kubectl get deployments,pods
```

Scale:
```bash
kubectl scale deployment nginx-deployment --replicas=3
kubectl get pods
```

### Checkpoint

- [ ] You understand Deployments
- [ ] You understand ReplicaSets
- [ ] You scaled your deployment

## Step 5: Exposing Applications using Services

Create a service:
```bash
kubectl expose deployment nginx-deployment --port=80 --type=NodePort
```

View the service:
```bash
kubectl get services
minikube service nginx-deployment
```

### Checkpoint

- [ ] You can expose apps via Services
- [ ] You understand NodePort basics
- [ ] You opened the Service in your local browser

## Step 6: Rolling Updates

Update your Deployment:
```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.22
```

Watch rollout:
```bash
kubectl rollout status deployment nginx-deployment
```

### Checkpoint

- [ ] You updated your deployment with zero downtime
- [ ] You understand rolling updates

## Step 7: Persistent Volumes

Create `pvc.yaml`:
```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
```

Apply it:
```bash
kubectl apply -f pvc.yaml
```

### Checkpoint

- [ ] You understand Kubernetes storage basics
- [ ] You created a PersistentVolumeClaim (PVC)

## Step 8: ConfigMaps and Secrets

Create a ConfigMap:
```bash
kubectl create configmap app-config --from-literal=ENV=production
```

Create a Secret:
```bash
kubectl create secret generic db-secret --from-literal=PASSWORD=mysecurepass
```

Query a ConfigMap:
```bash
kubectl describe configmap app-config
kubectl get configmap app-config
kubectl get configmap app-config -o yaml
```

Query a Secret:
```bash
kubectl describe secret db-secret
kubectl get secret db-secret
kubectl get secret db-secret -o json
```

### Checkpoint

- [ ] You created a ConfigMap
- [ ] You created a Secret
- [ ] You know the difference between them

## Step 9: Awareness of Advanced Resources

Check available resource types:
```bash
kubectl api-resources
kubectl api-resources | sort
```

View specialized workloads:
```bash
kubectl get daemonsets --all-namespaces
kubectl get statefulsets --all-namespaces
kubectl get jobs --all-namespaces
kubectl get cronjobs --all-namespaces
```

### Checkpoint

- [ ] You are aware of DaemonSets
- [ ] You are aware of StatefulSets
- [ ] You are aware of Jobs
- [ ] You are aware of CronJobs
