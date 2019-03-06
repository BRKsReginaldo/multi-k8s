# Building images
docker build -t brksdeadpool/multi-client:latest -t brksdeadpool/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brksdeadpool/multi-server:latest -t brksdeadpool/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brksdeadpool/multi-worker:latest -t brksdeadpool/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to docker
docker push brksdeadpool/multi-client:latest
docker push brksdeadpool/multi-server:latest
docker push brksdeadpool/multi-worker:latest
docker push brksdeadpool/multi-client:$SHA
docker push brksdeadpool/multi-server:$SHA
docker push brksdeadpool/multi-worker:$SHA

# Apply Services
kubectl apply -f k8s

# Imperatively set images to latest version
kubectl set image deployments/client-deployment client=brksdeadpool/multi-client:$SHA
kubectl set image deployments/server-deployment server=brksdeadpool/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=brksdeadpool/multi-worker:$SHA