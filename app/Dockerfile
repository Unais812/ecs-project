# Build stage: AS builder sets the build stage named builder
FROM node:25-alpine AS builder

# Setting the working directory for the app
WORKDIR /app

# Copying the app dependencies
COPY package.json yarn.lock

# Copying the rest of the source code
COPY . .

# Runs the commands to execute the build process for the image
RUN yarn install

# yarn creates a directory called build which contains the production ready assests
RUN yarn build 

#---Runtime stage---

# Sets the base image to something lighter as we dont require node and all of its tools
FROM node:25-alpine

WORKDIR /app

# Copying the static build output from the build stage 
COPY --from=builder /app/build /app/build

# Copies the files needed to serve the public application - html files
COPY --from=builder /app/public /app/public

# Installs package globally on system and 'serve' is the executable that starts the web server
RUN yarn global add serve

# serve is the executable yarn uses to serve the application 
CMD [ "serve", "-s", "build" ]