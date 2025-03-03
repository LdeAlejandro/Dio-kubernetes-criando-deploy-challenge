# Cluster Kubernetes com Backend, Frontend e MySQL

## Requisitos
Para completar este projeto, os seguintes requisitos devem ser atendidos:

- O cluster deve conter **3 réplicas do backend**.
- O **frontend deve estar fora do cluster**.
- Deve haver um **LoadBalancer** para gerenciar a comunicação entre frontend e backend.
- O banco de dados **MySQL deve estar em um único pod**, sem replicação.
- Deve haver **persistência de dados** para o banco de dados.
- O banco de dados deve ser chamado **`meubanco`**.
- A tabela do banco de dados deve se chamar **`mensagens`** e ter a seguinte estrutura:
  
  ```sql
  CREATE TABLE mensagens (
      id INT PRIMARY KEY AUTO_INCREMENT,
      nome VARCHAR(255) NOT NULL,
      email VARCHAR(255) NOT NULL,
      comentario VARCHAR(500) NOT NULL
  );
  ```

## Visão Geral
Este projeto descreve a configuração de um cluster Kubernetes contendo três réplicas para o backend, um frontend externo ao cluster, um balanceador de carga para gerenciar a comunicação entre eles e um banco de dados MySQL com persistência de dados.

## Arquitetura
- **Backend**: 3 réplicas rodando dentro do cluster Kubernetes.
- **Frontend**: Executado fora do cluster.
- **Load Balancer**: Gerencia o tráfego entre o frontend e o backend.
- **MySQL**: Executado em um único pod sem replicação.
- **Persistência de Dados**: O banco de dados MySQL possui armazenamento persistente.

## Deploy no Kubernetes

1. **Criar o namespace**:
   ```bash
   kubectl create namespace meu-projeto
   ```

2. **Deploy do MySQL com persistência**:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: mysql-pvc
     namespace: meu-projeto
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: mysql
     namespace: meu-projeto
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: mysql
     template:
       metadata:
         labels:
           app: mysql
       spec:
         containers:
           - name: mysql
             image: mysql:latest
             env:
               - name: MYSQL_ROOT_PASSWORD
                 value: "root"
               - name: MYSQL_DATABASE
                 value: "meubanco"
             volumeMounts:
               - mountPath: "/var/lib/mysql"
                 name: mysql-storage
         volumes:
           - name: mysql-storage
             persistentVolumeClaim:
               claimName: mysql-pvc
   ```

3. **Deploy do Backend com 3 réplicas**:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: backend
     namespace: meu-projeto
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: backend
     template:
       metadata:
         labels:
           app: backend
       spec:
         containers:
           - name: backend
             image: meu-backend:latest
             ports:
               - containerPort: 8080
   ```

4. **Criar o Load Balancer para o Backend**:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: backend-loadbalancer
     namespace: meu-projeto
   spec:
     type: LoadBalancer
     selector:
       app: backend
     ports:
       - protocol: TCP
         port: 80
         targetPort: 8080
   ```

## Conexão entre os Componentes
- O **frontend** se comunica com o backend através do LoadBalancer.
- O **backend** se conecta ao banco de dados MySQL no pod dedicado.
- O banco de dados MySQL armazena os dados de forma persistente.

  ```bash
  kubectl logs -l app=backend -n meu-projeto
  ```