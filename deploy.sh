docker build -t jeremyzhang1/multi-client:latest -t jeremyzhang1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeremyzhang1/multi-server:latest -t jeremyzhang1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeremyzhang1/multi-worker:latest -t jeremyzhang1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeremyzhang1/multi-client:latest
docker push jeremyzhang1/multi-server:latest
docker push jeremyzhang1/multi-worker:latest

docker push jeremyzhang1/multi-client:$SHA
docker push jeremyzhang1/multi-server:$SHA
docker push jeremyzhang1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeremyzhang1/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeremyzhang1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeremyzhang1/multi-worker:$SHA