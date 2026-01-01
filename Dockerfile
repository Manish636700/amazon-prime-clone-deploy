FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.25-alpine3.20
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html
RUN chown -R appuser:appgroup /usr/share/nginx /var/cache/nginx
USER appuser
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
