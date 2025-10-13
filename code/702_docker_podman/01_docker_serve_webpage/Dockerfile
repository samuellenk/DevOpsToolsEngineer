# Use the smallest official nginx image (Alpine‑based)
FROM nginx:alpine

# Remove the default static site that ships with nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy our own index.html (or any other static assets) into the web root
COPY index.html /usr/share/nginx/html/

# Expose the default HTTP port (optional – Docker will still map it)
# EXPOSE 80

# The base image already defines:
# CMD ["nginx", "-g", "daemon off;"]
