#!/bin/bash

set -euxo pipefail

echo -e "
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tilt-dev
  namespace: alpha
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: tilt-dev
  namespace: alpha
rules:
- apiGroups: ['', 'extensions', 'apps']
  resources: ['*']
  verbs: ['*']
- apiGroups: ['batch']
  resources:
  - jobs
  - cronjobs
  verbs: ['*']
- apiGroups:
  - networking.istio.io
  resources:
  - virtualservices
  verbs:
  - '*'
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: tilt-dev
  namespace: alpha
subjects:
- kind: ServiceAccount
  name: tilt-dev
  namespace: alpha
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: tilt-dev" | kubectl apply -f -

tokenName=$(kubectl get sa tilt-dev -n alpha -o 'jsonpath={.secrets[0].name}')
token=$(kubectl get secret $tokenName -n alpha -o "jsonpath={.data.token}" | base64 -d)
certificate=$(kubectl get secret $tokenName -n alpha -o "jsonpath={.data['ca\.crt']}")

context_name="$(kubectl config current-context)"
cluster_name="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"${context_name}\")].context.cluster}")"
server_name="$(kubectl config view -o "jsonpath={.clusters[?(@.name==\"${cluster_name}\")].cluster.server}")"

echo -e "apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
    certificate-authority-data: $certificate
    server: $server_name
  name: COMPANY-alpha-tilt

users:
- name: tilt-dev
  user:
    as-user-extra: {}
    client-key-data: $certificate
    token: $token

contexts:
- context:
    cluster: COMPANY-alpha-tilt
    namespace: alpha
    user: tilt-dev
  name: tilt

current-context: tilt" > config.gen.yaml
