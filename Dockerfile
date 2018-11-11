# Stage 1
FROM node:8.11.2-alpine as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
## cd to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
## copy all dist into current WORKDIR
## COPY dist/my-project .
COPY --from=node /usr/src/app/dist/my-project .
CMD ["nginx", "-g", "daemon off;"]