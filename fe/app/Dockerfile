FROM node:15.12.0-alpine3.13 as builder

# Install dependencies
COPY package.json .

RUN yarn install

FROM node:15.12.0-alpine3.13
WORKDIR /usr/src/app
# Copy node modules
COPY --from=builder node_modules node_modules
# Copy app code
COPY . .
