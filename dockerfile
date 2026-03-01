# TAHAP 1: Build
FROM node:18-alpine AS builder
WORKDIR /app

# Ambil rahasia dari GitHub Action
ARG VITE_SUPABASE_URL
ARG VITE_SUPABASE_ANON_KEY

# Tanamkan ke dalam Environment sistem agar dibaca Vite
ENV VITE_SUPABASE_URL=$VITE_SUPABASE_URL
ENV VITE_SUPABASE_ANON_KEY=$VITE_SUPABASE_ANON_KEY

COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# TAHAP 2: Serve
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist /usr/share/nginx/html
# Penting untuk Auth: Redirect semua route ke index.html (SPA)
RUN echo 'server { listen 80; location / { root /usr/share/nginx/html; index index.html index.htm; try_files $uri $uri/ /index.html; } }' > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]