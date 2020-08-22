docker build -t kostasxikis/multi-client:latest -t kostasxikis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kostasxikis/multi-server:latest -t kostasxikis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kostasxikis/multi-worker:latest -t kostasxikis/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kostasxikis/multi-client:latest
docker push kostasxikis/multi-server:latest
docker push kostasxikis/multi-worker:latest
docker push kostasxikis/multi-client:$SHA
docker push kostasxikis/multi-server:$SHA
docker push kostasxikis/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kostasxikis/multi-server:$SHA
kubectl set image deployments/client-deployment client=kostasxikis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kostasxikis/multi-worker:$SHA