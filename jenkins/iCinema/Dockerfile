# Build stage
FROM node:18 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build-frontend

# Run stage
FROM node:18
WORKDIR /app
COPY --from=build /app /app
EXPOSE 5000
CMD ["npm", "start"]
