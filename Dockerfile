# Stage 1 - build frontend app
FROM node:16 as build-deps

WORKDIR /app/

COPY ./ /app/

# RUN apk add git
RUN apt install git

RUN  yarn install

RUN  yarn build

FROM nginx:alpine

RUN rm -f /etc/nginx/conf.d/default.conf

COPY ./nginx/domains/supuestamente.conf /etc/nginx/conf.d/default.conf

COPY --from=build-deps /app/docs/.vuepress/dist/ /dist/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
