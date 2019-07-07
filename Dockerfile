FROM node:11.12.0-alpine as build-stage
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/package.json
RUN npm install
COPY . /usr/src/app
RUN npm run build

FROM nginx:1.15.9-alpine
COPY config/nginx.conf /usr/local/etc/nginx/nginx.conf
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]