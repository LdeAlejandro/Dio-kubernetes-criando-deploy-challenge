echo Iniciando...

call animation.bat "Criando serviços no cluster"

kubectl apply -f ./services.yml

call animation.bat "Criando deployments no cluster"

kubectl apply -f ./deployments.yml