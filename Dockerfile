# Build a production copy
FROM node:8.9-alpine as builder
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install
COPY . .
RUN npm run build

# Run production copy via Nginx
FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80

