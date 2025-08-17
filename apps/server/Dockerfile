# Stage 1: Build dependencies
# Ele inicia a primeira etapa (Stage 1) da construção de uma imagem Docker.
# Usa a imagem oficial node:20-alpine como base
# It starts the first stage (Stage 1) of building a Docker image.
# It uses the official node:20-alpine image as a base.
FROM node:20-alpine AS builder

# Copy the package*.json files.
# Copia os arquivos package*.json.
WORKDIR /usr/src/app
COPY package*.json ./
# Executa npm ci --omit=dev para instalar apenas dependências de produção.
# Run npm ci --omit=dev to install only production dependencies.
RUN npm ci --omit=dev

# Copia o restante do código para o container.
# Copy the rest of the code into the container.
COPY . .

# Stage 2: Runtime image
# Aqui começa uma nova imagem limpa, também baseada em node:20-alpine.
# Ela não herda nada automaticamente da primeira stage.
# Here starts a new, clean image, also based on node:20-alpine.
# It doesn't automatically inherit anything from the first stage.
FROM node:20-alpine

WORKDIR /usr/src/app
# Copia os arquivos gerados no estágio de build.
# Copy the files generated in the build stage.
COPY --from=builder /usr/src/app ./

# Expõe a porta 3001 para conexões externas.
# Exposes port 3001 to external connections.
EXPOSE 3001
USER node

# Define o usuário node (boa prática de segurança, evitando rodar como root).
# Defines the node user (good security practice, avoiding running as root).
CMD ["node", "server.js"]
