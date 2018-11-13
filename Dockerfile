FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
## cd to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
## copy all dist into current WORKDIR
## COPY dist/my-project .
COPY  /src/app/dist/my-project .
CMD ["nginx", "-g", "daemon off;"]