# Stage 1: Development
FROM node:lts-slim AS development

# Set working directory
WORKDIR /usr/src/app

COPY global-bundle.pem /usr/src/app/global-bundle.pem

# Copy dependency files first (better layer caching)
COPY package.json package-lock.json ./

# Install dependencies as root (default user is root)
RUN npm ci

# Create non-root user
# RUN useradd -ms /bin/bash appuser

# Copy the source code
COPY . .

# RUN chown -R appuser /usr/src/app

# Switch to non-root AFTER deps are installed
# USER appuser

# Expose backend port
EXPOSE 3000

# Default command for dev
CMD ["npm", "run", "dev"]
