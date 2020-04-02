FROM node:10 as demo-frontend-build
COPY ./ /demo-frontend
WORKDIR /demo-frontend
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && cnpm install && npm run build

FROM nginx:latest
RUN mkdir /demo-frontend-html
RUN rm -fr /etc/nginx/conf.d/default.conf
COPY --from=demo-frontend-build /demo-frontend/dist /demo-frontend-html
COPY demo-frontend.conf /etc/nginx/conf.d
