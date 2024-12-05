# Imagen base con PHP y Apache
FROM php:8.1-apache

# Instalar vsftpd y otras dependencias necesarias
RUN apt-get update && apt-get install -y \
    vsftpd \
    libfuse2 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Crear un usuario para FTP
RUN useradd -m ftpuser && echo "ftpuser:ftp123" | chpasswd

# Crear la carpeta de imágenes y asignarla al usuario FTP
RUN mkdir -p /var/www/html/images && \
    chown ftpuser:ftpuser /var/www/html/images

# Configurar vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Habilitar los módulos PHP necesarios
RUN docker-php-ext-install opcache

# Configurar la carpeta de trabajo
WORKDIR /var/www/html

# Copiar los archivos de la aplicación
COPY app/ /var/www/html/

# Permisos para las carpetas
RUN chmod -R 755 /var/www/html

# Exponer puertos para Apache y FTP
EXPOSE 88 22

# Iniciar Apache y vsftpd
CMD service vsftpd start && apache2-foreground
