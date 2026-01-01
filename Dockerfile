FROM node:18-alpine3.19

WORKDIR /app


RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY package*.json ./


RUN npm ci --omit=dev

COPY . .


USER appuser

EXPOSE 3000

CMD ["npm","start"]
