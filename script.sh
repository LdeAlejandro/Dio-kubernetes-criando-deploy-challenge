


#!/bin/bash
if [[ -f "./script.sh" ]]; then

	source ./animation.sh

#typewriter

else
	echo "Error script not found"
	 exit 1
fi

echo "Iniciando..."

typewriter "Criando imagen"

# Criação de imagens Docker com base no Dockerfile
docker build -t ldealejandro/k8-challlenge-backend:1.0 backend/.
docker build -t ldealejandro/k8-challlenge-database:1.0 database/.


typewriter "Realizando o push das imagens"
# Carregamento das imagens para o Docker Hub
docker push ldealejandro/k8-challlenge-backend:1.0
docker push ldealejandro/k8-challlenge-database:1.0