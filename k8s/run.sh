#! /usr/bin/env bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm install my-release bitnami/redis
helm install prom prometheus-community/kube-prometheus-stack

k apply -f ./app.yml

k run curl-test --image=radial/busyboxplus:curl -it --rm -- curl app-service.default.svc.cluster.local:8080
