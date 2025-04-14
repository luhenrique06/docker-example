FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --production

COPY . .

RUN rm -rf test .dockerignore Dockerfile *.md

FROM node:20-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app /app

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
