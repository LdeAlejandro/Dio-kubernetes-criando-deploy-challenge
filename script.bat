
echo Iniciando...
call animation.bat  "Criando imagens"

:: Crianção de imagens docker com base no dockerfile
:: docker build -t ldealejandro/k8-challlenge-backend:1.0 backend/.
:: docker build -t ldealejandro/k8-challlenge-database:1.0 database/.


call animation.bat "Realizando o push das imagens 

:: Carregamento das imagens para o dockerhub
:: docker push ldealejandro/k8-challlenge-backend:1.0
:: docker push ldealejandro/k8-challlenge-database:1.0