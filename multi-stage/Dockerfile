# Multi-stage Dockerfile
# Builds the image in multiple stages
FROM node:20.18-alpine AS builder

# 1. Create the working directory.
WORKDIR /build

# 1.1 Copy the package.json and package-lock.json.
COPY package.*.json

# 1.2 Install the dependencies.
RUN npm install

# 1.3 Copy the source code.
COPY . .

# 1.4 Build the application.
RUN npm run build

# 2. Create the runner image.
FROM node:20.18-alpine AS runner

# 2.1 Create the working directory
WORKDIR /app

# 2.2 Copy the required files from the builder image.
COPY --from=builder node_modules .
COPY --from=builder /dist .
COPY --from=builder package.*.json .

# 2.3 Expose the port.
EXPOSE 3000

# 2.4 Start the application.
# Finally run the application.
CMD ["node", "app.js"]


