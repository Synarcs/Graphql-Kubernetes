FROM node
# change to  the actual version name while going to production.

LABEL Apolloserve="Apollo server running on client"

WORKDIR /usr

COPY package.json ./
COPY .env ./

RUN npm cache clean --force
RUN npm install
COPY app.js ./

VOLUME [ "." , "."]

EXPOSE 4000
CMD [ "npm","run","start" ]
