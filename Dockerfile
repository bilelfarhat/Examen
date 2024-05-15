
FROM node:16 as build

WORKDIR /app

COPY package.json yarn.lock /app/

RUN yarn install --frozen-lockfile

COPY . /app

RUN yarn build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
