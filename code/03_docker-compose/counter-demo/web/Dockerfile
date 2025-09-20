# Use the official PHP image with Apache pre‑installed
FROM php:7.4-apache

# Enable the mysqli extension (we’ll use it from PHP)
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy the source code into Apache’s document root
COPY src/ /var/www/html/

# Give Apache permission to write to the directory if you ever need it
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 (the default Apache port)
EXPOSE 80
