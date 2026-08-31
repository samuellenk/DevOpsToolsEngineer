# Example 1: use a helm chart

```bash
# helm should be installed:
helm version

# add & update Bitnami repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# run nginx ("my-webserver") in Cluster:
helm install my-webserver bitnami/nginx

# show release status:
helm list

# change values and verify:
helm upgrade my-webserver bitnami/nginx --set replicaCount=2
kubectl get pods
kubectl port-forward svc/my-webserver-nginx 8080:80
curl localhost:8080

# remove helm chart again:
helm uninstall my-webserver
```

# Example 2: create a helm chart

```bash
# create new chart:
helm create my-app-chart
cd my-app-chart

# remove existing templates:
rm -rf templates/*
```

replace values.yaml:
```bash
cat <<EOF > values.yaml
appTitle: "Welcome to this minikube cluster"
environment: "dev"
EOF
```

create template in templates/configmap.yaml:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  title: {{ .Values.appTitle | quote }}
  env: {{ .Values.environment | quote }}
  chart_info: "{{ .Chart.Name }}-{{ .Chart.Version }}"
```

install and test the chart:
```bash
# dry run:
helm template my-release .

# install chart on minikube:
helm install my-release .

# check for ConfigMap in Kubernetes:
kubectl get configmaps
kubectl describe configmap my-release-configmap
```

upgrade the chart:
```bash
# override values:
helm upgrade my-release . --set environment="production"
# check the changes:
kubectl get configmap my-release-configmap -o yaml
```

remove the chart:
```bash
helm uninstall my-release
```
