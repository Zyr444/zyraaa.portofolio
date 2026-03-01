# Pake Nginx yang enteng
FROM nginx:alpine

# Hapus file default Nginx biar bersih (Opsional tapi bagus)
RUN rm -rf /usr/share/nginx/html/*

# COPY SEMUA isi folder project kamu (termasuk folder css, js, img)
COPY . /usr/share/nginx/html/

# Buka jalur port 80
EXPOSE 80