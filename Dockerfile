# ---------- Build Stage ----------
FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./

# IMPORTANT: install devDependencies for build
RUN npm ci --include=dev

COPY . .
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
