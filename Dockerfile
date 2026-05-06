# ============ STAGE 1: BUILD ============
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar dependencias primero (optimiza caché)
COPY package*.json .
RUN npm ci

# Copiar el resto y compilar
COPY . .
RUN npm run build

# ============ STAGE 2: RUN ============
FROM nginx:alpine

# Crear usuario no root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copiar build de Vite al directorio de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Configuración básica de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]