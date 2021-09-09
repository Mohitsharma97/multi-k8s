docker build -t mohit1504/multi-client:latest -t mohit1504/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohit1504/multi-server:latest -t mohit1504/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohit1504/multi-worker:latest -t mohit1504/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mohit1504/multi-client:latest
docker push mohit1504/multi-server:latest
docker push mohit1504/multi-worker:latest

docker push mohit1504/multi-client:$SHA
docker push mohit1504/multi-server:$SHA
docker push mohit1504/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohit1504/multi-server:$SHA
kubectl set image deployments/client-deployment client=mohit1504/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mohit1504/multi-worker:$SHA

