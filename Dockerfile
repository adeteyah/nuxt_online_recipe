# Build Stage
FROM node:22-alpine AS build
WORKDIR /app

# Copy package.json and lockfile first
COPY package*.json ./
RUN npm ci --production  # Install only necessary dependencies

# Copy the rest of the project files
COPY . ./

# Build the project
RUN npm run build

# Run Stage
FROM node:22-alpine
WORKDIR /app

# Copy only the build output
COPY --from=build /app/.output/ ./

# Ensure correct environment variables
ENV NITRO_HOST=0.0.0.0
ENV NITRO_PORT=8080
ENV PORT=8080

EXPOSE 8080

# Start Nuxt Nitro server
CMD ["node", "./server/index.mjs"]
