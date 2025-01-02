# Write a dockerfile for a simple NodeJS Web Application. Bonus points if you add a database. You do not need to write any NodeJS Code.

# set base image to latest official
FROM node:latest

# set working directory
WORKDIR /app

# copy package files and install dependencies
COPY package*.json ./
RUN npm install

# copy source code
COPY . .

# expose app port, commonly used for nodeJS is 3000
EXPOSE 3000

CMD ["npm", "start"]