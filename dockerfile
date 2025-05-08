FROM node:23-alpine AS builder

WORKDIR /app

COPY package*.json ./


COPY . .

RUN rm -rf test .dockerignore Dockerfile *.md

FROM node:23-alpine


WORKDIR /app

#CRIAR USUARIO E GRUPOS
RUN addgroup -S appgroup && adduser -S appuser -G appgroup


COPY --from=builder /app /app

#PERMISSAO DE ACESSO
RUN chown -R appuser:appgroup /app
RUN chmod -R 555 /app 

USER appuser

EXPOSE 3000

CMD ["", ""]