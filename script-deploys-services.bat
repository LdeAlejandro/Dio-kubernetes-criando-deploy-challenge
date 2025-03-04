echo Iniciando...

call animation.bat "Criando servicos no cluster"

kubectl apply -f ./services.yml

call animation.bat "Criando deployments no cluster"

kubectl apply -f ./deployments.yml