This example shows core objects: 

- **Pod**
- **Deployment**
- **Service**
- **Ingress**

It works on Kind/Minikube out‑of‑the‑box (Ingress controller is built‑in for Minikube).

## Technical Requirements

This is what you'll need for the example:

1. [Docker installation](https://docs.docker.com/engine/install/)
2. tools for Kubernetes:
  - [kubectl installation](https://kubernetes.io/docs/tasks/tools/#kubectl)
  - [minikube installation](https://kubernetes.io/docs/tasks/tools/#minikube)
3. create **bash completion for minikube**: `minikube completion bash | sudo tee /usr/share/bash-completion/completions/minikube`

Finally, **verify** that you have the components **and install** them, if necessary.

## Minikube Example: Step‑by‑step

1. Create a local **cluster**:

```bash
minikube start
minikube addons enable ingress
```

2. Write the **manifest** `hello.yml`.


3. **Apply** the manifest:

```bash
kubectl apply -f hello.yaml
```

4. **Verify** everything is running:

```bash
kubectl get pods -l app=hello
kubectl get svc hello-svc
kubectl get ingress hello-ingress
```

5. **Access** it in Minikube:

```bash
minikube service hello-svc --url
```

You should see the custom HTML page mentioning the pod's hostname.

As an alternative you can also run `minikube dashboard` and from there open the desired item.

6. **Play!** – Try the following to cement concepts

- Scale the deployment to 5 replicas: `kubectl scale deployment hello-nginx --replicas=5`
- Update the page text by editing the `ConfigMap`: `kubectl edit cm hello-index`
- Roll back a broken image: `kubectl set image deployment/hello-nginx nginx=nginx:1.19-alpine && kubectl rollout undo deployment/hello-nginx`
- Enable HTTPS with self‑signed certificate: follow the [Ingress TLS](https://minikube.sigs.k8s.io/docs/tutorials/custom_cert_ingress/) tutorial in the documentation
