# Use the official Nginx image as a base
FROM nginx

# Copy static files to the Nginx HTML directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY index.js /usr/share/nginx/html/

# Expose port 80
EXPOSE 80