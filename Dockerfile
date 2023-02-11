FROM node:19.6-alpine AS build

# Install dependencies and build the app
# The built app is in the dist/ directory

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn install

COPY . .

RUN yarn run build

FROM nginx:1.23-alpine

# Copy from the build stage and serve the app with nginx

COPY --from=build /app/dist /usr/share/nginx/html
