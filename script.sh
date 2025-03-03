#!/bin/bash

echo "Criando imagens"

# Criação de imagens Docker com base no Dockerfile
docker build -t ldealejandro/k8-challlenge-backend:1.0 backend/.
docker build -t ldealejandro/k8-challlenge-database:1.0 database/.

# Código para escrita animada
text="Criando................"
for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.3  # 300ms de atraso
done
echo ""

echo "Realizando o push das imagens"
# Carregamento das imagens para o Docker Hub
docker push ldealejandro/k8-challlenge-backend:1.0
docker push ldealejandro/k8-challlenge-database:1.0
