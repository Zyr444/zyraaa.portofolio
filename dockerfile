FROM nginx:alpine

# 1. Bersihkan folder default Nginx
RUN rm -rf /usr/share/nginx/html/*

# 2. Copy semua file dari folder proyek (titik) ke folder Nginx
# Pastikan ada spasi antara titik dan /usr/...
COPY . /usr/share/nginx/html/

# 3. Beri izin akses (PENTING: Biar gak Forbidden/Putih)
RUN chmod -R 755 /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]