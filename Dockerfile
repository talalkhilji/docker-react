# Use an existing image as a base, add tag to create multi step docker file
FROM node:alpine as builder

WORKDIR /app
# Download and install a dependency
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Tell the image what todo what it starts
# as a container
RUN npm run build

#use nigx and copy build folder
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html