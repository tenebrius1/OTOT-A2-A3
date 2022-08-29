# commands related to creating kind clusters and validating their existence
printf "creating clusters\n"
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml
printf "\n"
kubectl cluster-info --context kind-kind-1
printf "\n"
kubectl get nodes

# create and apply deplyment
printf "creating backend\n"
kubectl apply -f k8s/manifests/backend-deployment.yml
printf "\n"
kubectl wait --for=condition=ready pod --selector=app=backend --timeout=60s
printf "\n"
kubectl get deployment/backend
printf "\n"
kubectl get po -lapp=backend

# create ingress controller
printf "\ncreating ingress controller\n"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
printf "\n"
kubectl wait --for condition=ready -n ingress-nginx pod -l app.kubernetes.io/component=controller --timeout=60s
printf "\n"
kubectl -n ingress-nginx get deploy

# set up ingress ClusterIP service
printf "\ncreating ClusterIP service\n"
kubectl apply -f k8s/manifests/backend-service.yml
printf "\n"
kubectl get svc

# create ingress server
printf "\ncreating ingress server\n"
kubectl apply -f k8s/manifests/backend-ingress.yml
kubectl get ingress
