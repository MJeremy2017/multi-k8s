docker build -t jeremyzhang1/multi-client:latest -t jeremyzhang1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeremyzhang1/multi-server:latest -t jeremyzhang1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeremyzhang1/multi-worker:latest -t jeremyzhang1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeremyzhang1/multi-client:latest
docker push jeremyzhang1/multi-server:latest
docker push jeremyzhang1/multi-worker:latest

docker push jeremyzhang1/multi-client:$SHA
docker push jeremyzhang1/multi-server:$SHA
docker push jeremyzhang1/multi-worker:$SHA

kubctl apply -f k8s
kubctl set image deployments/server-deployment server=jeremyzhang1/multi-server:$SHA
kubctl set image deployments/client-deployment client=jeremyzhang1/multi-client:$SHA
kubctl set image deployments/worker-deployment worker=jeremyzhang1/multi-worker:$SHA