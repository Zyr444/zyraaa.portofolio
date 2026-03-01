# ==========================================
# TAHAP 1: Build React/Vite
# ==========================================
FROM node:18-alpine AS builder
WORKDIR /app

# Copy file package dan install (pakai legacy-peer-deps biar aman)
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy semua source code
COPY . .

# Build aplikasi Vite (Akan menghasilkan folder 'dist')
RUN npm run build

# ==========================================
# TAHAP 2: Sajikan dengan Nginx
# ==========================================
FROM nginx:alpine

# Bersihkan folder default Nginx
RUN rm -rf /usr/share/nginx/html/*

# COPY HASIL BUILD DARI TAHAP 1 (folder dist)
COPY --from=builder /app/dist /usr/share/nginx/html

# Konfigurasi Nginx untuk React/SPA
RUN echo 'server { listen 80; location / { root /usr/share/nginx/html; index index.html index.htm; try_files $uri $uri/ /index.html; } }' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]