FROM node:14-alpine as builder

WORKDIR /usr/src/app

COPY source/package*.json ./

RUN npm install

COPY ./source .

RUN npm run build-prod

#ENTRYPOINT npm run start -- --host 0.0.0.0

FROM nginx:alpine

#!/bin/sh

COPY nginx.conf /etc/nginx/

RUN rm -rf /usr/share/nginx/html/*

# Copy from the stahg 1
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html

#theirs
ENTRYPOINT ["nginx", "-g", "daemon off;"]

#mine
#ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]