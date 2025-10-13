# Kubernetes: Challenge Lab

Goal: After completing the [Kubernetes: Interactive Lab](./../01_interactive/README.md), you can now create a solution yourself!

Create a working app with:

- [ ] ConfigMap
- [ ] Secret
- [ ] PVC
- [ ] Deployment
- [ ] Service
- [ ] Ingress

## Suggested solution

Based on the requirement for the challenge, here is a sample solution:
```bash
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

## Checkpoint

Verify everything is running as desired:

- [ ] App is running: `kubectl get pods`
- [ ] Service is exposed: `kubectl get svc && minikube service challenge-service --url`
- [ ] PVC is bound: `kubectl get pvc`
- [ ] ConfigMap is created: `kubectl get configmaps`
- [ ] Secret is created: `kubectl get secret`

## Adding Ingress

### Setup

1. Enable Ingress addon in Minikube:
```bash
minikube addons enable ingress
```

2. Add hosts entry on your docker host for testing:
```bash
echo '127.0.0.1 myapp.local' | sudo tee -a /etc/hosts
```

### Adjust and add definitions

Update Service to `ClusterIP`:
```bash
kubectl edit service challenge-service
```

Add `ingress.yaml`:
```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: challenge-service
            port:
              number: 80
```

Create the ingress resource:
```bash
kubectl apply -f ingress.yaml
```

Verify the ingress component:
```bash
kubectl get ingress challenge-ingress
```

### Access Ingress in Minikube

1. Create tunnel:
```bash
minikube tunnel
```

2. Open the app in your local browser: [http://myapp.local](http://myapp.local)

## Final Checkpoint

- [ ] Ingress is deployed
- [ ] You can access your app on [http://myapp.local](http://myapp.local)
- [ ] Everything works end-to-end
