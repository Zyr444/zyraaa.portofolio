# ==========================================
# TAHAP 1: "Dapur" (Build React)
# ==========================================
FROM node:18-alpine AS builder
WORKDIR /app

# Copy file konfigurasi npm dulu biar cepat
COPY package*.json ./

# UBAH BAGIAN INI: Paksa install meskipun ada konflik versi React
RUN npm install --legacy-peer-deps

# Copy semua kode React kamu ke dalam Docker
COPY . .

# Masak kodenya! (Ini akan menghasilkan folder 'dist' atau 'build')
RUN npm run build

# ==========================================
# TAHAP 2: "Pelayan" (Nginx)
# ==========================================
FROM nginx:alpine

# Bersihkan meja Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy hasil masakan dari Tahap 1 ke Nginx
# UBAH KATA 'dist' JADI 'build' JIKA KAMU PAKAI CREATE REACT APP
COPY --from=builder /app/dist /usr/share/nginx/html

# Konfigurasi Nginx khusus React (Biar gak Error 404 kalau halamannya di-refresh)
RUN echo 'server { listen 80; location / { root /usr/share/nginx/html; index index.html index.htm; try_files $uri $uri/ /index.html; } }' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]