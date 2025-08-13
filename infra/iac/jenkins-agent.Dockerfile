# Jenkins agent with Docker, Helm, Gradle, and Git
##Usa como base o Jenkins inbound agent com Java 21.
#Esse agente é usado para conectar-se a um Jenkins Master e executar jobs remotamente.
FROM jenkins/inbound-agent:latest-jdk21

##Necessário para instalar pacotes e ferramentas adicionais dentro da imagem.
USER root

##Atualiza os pacotes.
#Instala dependências.
#Instala o Podman (alternativa ao Docker que não requer daemon)
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common && \
    apt-get update && \
    apt-get install -y podman

##Cria um link simbólico para que comandos docker funcionem usando o Podman.
#Isso garante compatibilidade com scripts que esperam o binário docker.
RUN ln -s /usr/bin/podman /usr/bin/docker

# Baixa e instala o Helm 3, gerenciador de pacotes para Kubernetes.
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instala Gradle 8.7 para compilar e buildar projetos Java.
#Adiciona o binário gradle ao PATH para ser usado diretamente.
RUN apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -O /tmp/gradle.zip && \
    unzip /tmp/gradle.zip -d /opt && \
    ln -s /opt/gradle-8.7/bin/gradle /usr/bin/gradle

# Instala o Git para versionamento e clonagem de repositórios nos pipelines.
RUN apt-get install -y git