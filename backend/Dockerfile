FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install all dependencies (including devDependencies for tsc)
COPY package*.json ./
RUN npm ci

# Copy the rest of the backend source code
COPY . .

# Build the TypeScript code
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

# Copy package files and install only production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy the compiled output from the builder stage
COPY --from=builder /app/dist ./dist

# Expose the port the app runs on (adjust if your app uses a different default)
ENV PORT=3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
