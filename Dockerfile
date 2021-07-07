FROM node:14-alpine as node_static

WORKDIR /usr/src/app

COPY source/package*.json ./

RUN npm install

COPY ./source .

RUN npm run build-prod

#ENTRYPOINT npm run start -- --host 0.0.0.0

FROM nginx:alpine

COPY nginx.conf /etc/nginx/

RUN rm -rf /usr/share/nginx/html/*

COPY --from=node_static /usr/src/app/dist/ /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
#ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]