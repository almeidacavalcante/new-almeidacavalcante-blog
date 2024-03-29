FROM node:20.11 as build

WORKDIR /app

COPY package.json ./

RUN NODE_OPTIONS="--max-old-space-size=1024" npm install

COPY . .

RUN npm run build

EXPOSE 3000


FROM nginx:alpine

COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
