# deploy metrics-server
printf "\ndeploying metrics-server\n"
kubectl apply -f k8s/manifests/metrics-server.yml
printf "\n"
kubectl wait -nkube-system --for=condition=ready pod -l k8s-app=metrics-server --timeout=60s
printf "\n"
kubectl -nkube-system get deploy
printf "\n"

# deploy HPA
printf "deploying HPA\n"
kubectl apply -f k8s/manifests/backend-hpa.yml
printf "\nload testing server...\n"
./demo/a3/load_test.sh
printf "\n"
kubectl describe hpa