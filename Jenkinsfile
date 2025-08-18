/*

## Fluxo Resumido

1. Baixa o código → `Checkout`
2. Constrói e testa aplicação Node.js → `Build & Test`
3. Faz login no GHCR → `Login to GHCR`
4. Constrói a imagem Docker → `Docker Build`
5. Publica a imagem → `Docker Push`
6. Valida e empacota Helm Chart → `Build Helm Chart`
7. Implanta no Kubernetes com Helm → `Deploy Helm Chart`
8. Se falhar, rollback automático → `Post > failure`

## Summary Flow

1. Download the code → `Checkout`
2. Build and test the Node.js application → `Build & Test`
3. Log in to GHCR → `Login to GHCR`
4. Build the Docker image → `Docker Build`
5. Publish the image → `Docker Push`
6. Validate and package Helm Chart → `Build Helm Chart`
7. Deploy to Kubernetes with Helm → `Deploy Helm Chart`
8. If failure occurs, automatic rollback → `Post > failure`
*/



pipeline {
  agent any
  /*
IMAGE → Local onde a imagem será publicada no GHCR.
TAG → Identifica a versão da imagem (número incremental do Jenkins).
HELM_RELEASE → Nome do release Helm que será criado/atualizado.
KUBE_NAMESPACE → Namespace onde o deploy será feito no Kubernetes.
*/

  /*
## Pipeline Structure

### Environment Variables
- **IMAGE** → Name and destination of the image in GitHub Container Registry (GHCR).
Example: `ghcr.io/brscherer/server`
- **TAG** → Image version. Uses the Jenkins incremental number (`BUILD_NUMBER`).
- **HELM_RELEASE** → Name of the Helm release to be created or updated (`server`).
- **KUBE_NAMESPACE** → Namespace in Kubernetes where the deployment will take place (`apps`).
*/
  environment {
    IMAGE = "ghcr.io/brscherer/server"
    TAG = "${env.BUILD_NUMBER}"
    HELM_RELEASE = "server"
    KUBE_NAMESPACE = "apps"
  }
  /*
Garante que o Node.js configurado no Jenkins esteja disponível para execução dos testes e builds.

Ensures that the Node.js configured in Jenkins is available to run tests and builds.
  */
  tools {
    nodejs 'nodejs'
  }

  /*
**Checkout**  
   - Faz checkout do código fonte do repositório configurado no Jenkins.

   **Checkout**
- Checks out the source code from the repository configured in Jenkins.
*/
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    /*
 **Build & Test**  
   - Acessa a pasta `apps/server`.  
   - Instala dependências com `npm ci`.  
   - Executa os testes unitários com `npm test`.


   **Build & Test**
- Access the `apps/server` folder.
- Install dependencies with `npm ci`.
- Run unit tests with `npm test`.
*/
    stage('Build & Test') {
      steps {
        dir('apps/server') {
          sh 'npm ci'
          sh 'npm test'
        }
      }
    }

    /*
     **Login to GHCR**  
   - Usa credenciais (`ghcr-creds`) configuradas no Jenkins.  
   - Realiza login no GitHub Container Registry com `docker login`.


   **Login to GHCR**
- Uses credentials (`ghcr-creds`) configured in Jenkins.
- Logs in to GitHub Container Registry with `docker login`.
    */
    stage('Login to GHCR') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'ghcr-creds', usernameVariable: 'GHCR_USER', passwordVariable: 'GHCR_TOKEN')]) {
          sh 'echo $GHCR_TOKEN | docker login ghcr.io -u $GHCR_USER --password-stdin'
        }
      }
    }

    /*
     **Docker Build**  
   - Cria a imagem Docker da aplicação em `apps/server`.  
   - Nome da imagem: `${IMAGE}:${BUILD_NUMBER}`.

   **Docker Build**
- Creates the application's Docker image in `apps/server`.
- Image name: `${IMAGE}:${BUILD_NUMBER}`.
    */
    stage('Docker build') {
      steps {
        dir("apps/server"){
          sh "docker build -t $IMAGE:$BUILD_NUMBER ."
        }
      }
    }

    /*
    - Publish the image created for GHCR.

    - Publish the image created for GHCR.
    */
    stage('Docker push') {
      steps {
        dir("apps/server"){
          sh "docker push $IMAGE:$BUILD_NUMBER "
        }
      }
    }

    /*
    . **Build Helm Chart**  
   - Acessa `apps/server/chart`.  
   - Valida o chart com `helm lint`.  
   - Empacota o chart com `helm package`.

       **Build Helm Chart**
    - Accesses `apps/server/chart`.
    - Validates the chart with `helm lint`.
    - Packages the chart with `helm package`.
    */
    stage('Build Helm Chart') {
      steps {
        dir("apps/server/chart") {
          sh 'helm lint .'
          sh 'helm package .'
        }
      }
    }

    /*
    **Deploy Helm Chart**  
   - Realiza upgrade/instalação do release Helm no namespace definido.  
   - Aponta a aplicação para usar a nova imagem recém-publicada.  
   - Aguarda (`--wait --timeout 5m`) até que os pods estejam prontos.


   **Deploy Helm Chart**  
   - Realiza upgrade/instalação do release Helm no namespace definido.  
   - Aponta a aplicação para usar a nova imagem recém-publicada.  
   - Aguarda (`--wait --timeout 5m`) até que os pods estejam prontos.
*/
    stage('Deploy Helm Chart') {
      steps {
        sh """
          helm upgrade --install ${HELM_RELEASE} ${WORKSPACE}/apps/server/chart \
            --namespace ${KUBE_NAMESPACE} \
            --set image.repository=${IMAGE} \
            --set image.tag=${TAG} \
            --wait --timeout 5m
        """
      }
    }
  }
  /*
  ## Post Actions
- **failure**  
  - Em caso de falha no deploy, executa rollback do release Helm para a versão anterior (`helm rollback`).  
  - Se não houver release anterior, apenas registra aviso no log.

  ## Post Actions
- **failure**
- In case of deployment failure, rollback the Helm release to the previous version (`helm rollback`).
- If there is no previous release, only log a warning.
  */
  post {
    failure {
      echo 'Failure detected. Rolling back...'
      sh "helm rollback ${HELM_RELEASE} 0 --namespace ${KUBE_NAMESPACE} || echo 'No previous release'"
    }
  }
}
