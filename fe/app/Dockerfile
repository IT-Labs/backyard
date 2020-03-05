FROM node:10.18.0-alpine3.11 as builder

# Install dependencies
COPY package.json .
RUN yarn install

FROM node:10.18.0-alpine3.11

WORKDIR /usr/src/app

# Copy node modules
COPY --from=builder node_modules node_modules
# Copy app code
COPY . .

CMD [ "yarn", "start", "--prod"]
