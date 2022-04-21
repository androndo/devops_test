#! /usr/bin/env bash

helm repo add bitnami https://charts.bitnami.com/bitnami

helm install my-release bitnami/redis

k apply -f ./app.yml

k run curl-test --image=radial/busyboxplus:curl -it --rm -- curl app-service.default.svc.cluster.local:8080
