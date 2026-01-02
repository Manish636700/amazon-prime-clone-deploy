# ---------- Build Stage ----------
FROM node:18-bullseye-slim AS build

WORKDIR /app

# Prevent npm hanging & reduce noise in CI
ENV npm_config_audit=false \
    npm_config_fund=false \
    npm_config_progress=false \
    NODE_OPTIONS=--max-old-space-size=2048

# Copy dependency files first
COPY package.json package-lock.json ./

# Deterministic, CI-safe install (includes devDependencies)
RUN npm ci --legacy-peer-deps

# Copy source code
COPY . .

# Build React app
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy React build output
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
