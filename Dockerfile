# Use the official Node.js image from the Docker Hub
FROM node:14-alpine

# Add OCI label with the repository URL
LABEL org.opencontainers.image.source="https://github.com/jchauhan-crest/bitbucket-usercase-ui"

# Set the working directory inside the container
WORKDIR /app

# Copy all the contents of your local directory into the container
COPY . .

# Install the necessary dependencies in your project (assuming package.json is in the copied directory)
RUN npm install

# Start the application
CMD ["npm", "start"]