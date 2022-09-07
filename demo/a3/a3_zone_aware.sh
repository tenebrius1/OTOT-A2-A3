# apply zone aware backend manifest
printf "deplying zone aware backend"
kubectl apply -f k8s/manifests/backend-deployment-zone-aware.yml
kubectl get nodes -L topology.kubernetes.io/zone
kubectl wait --for=condition=ready pod -l app=backend-zone-aware --timeout=60s
kubectl get po -lapp=backend-zone-aware -owide --sort-by='.spec.nodeName'