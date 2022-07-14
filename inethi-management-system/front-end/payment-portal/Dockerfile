FROM node:18-alpine

WORKDIR /app

COPY package.json .
RUN npm install -g npm@8.12.1
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]