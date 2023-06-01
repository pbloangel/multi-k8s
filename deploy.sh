docker build -t pabloangel/multi-client:latest -t pabloangel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pabloangel/multi-server:latest -t pabloangel/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t pabloangel/multi-worker:latest -t pabloangel/mutli-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pabloangel/multi-client:latest
docker push pabloangel/multi-server:latest
docker push pabloangel/multi-worker:latest
docker push pabloangel/multi-client:$SHA
docker push pabloangel/multi-server:$SHA
docker push pabloangel/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pabloangel/multi-server:$SHA
kubectl set image deployments/client-deployment client=pabloangel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pabloangel/multi-worker:$SHA