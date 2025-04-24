FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --production

COPY . .

RUN rm -rf test .dockerignore Dockerfile *.md

FROM node:20-alpine


WORKDIR /app

COPY --from=builder /app /app


EXPOSE 3000

CMD ["node", "dist/main"]