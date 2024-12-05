# Imagen base con PHP y Apache
FROM php:8.1-apache

# Habilitar módulos de PHP necesarios
RUN docker-php-ext-install opcache

# Configurar carpeta de trabajo
WORKDIR /var/www/html

# Copiar la aplicación al contenedor
COPY app/ /var/www/html/

# Dar permisos a la carpeta de imágenes
RUN chmod -R 755 /var/www/html/images

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Apache
CMD ["apache2-foreground"]
