FROM node:25-alpine

WORKDIR /app

COPY . .

RUN yarn install
RUN yarn build 
RUN yarn global add serve 

CMD [ "serve", "-s", "build" ]

