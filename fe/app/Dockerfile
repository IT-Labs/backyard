FROM node:16.13.1-alpine as builder

# Install dependencies
COPY package.json .

RUN yarn install

FROM node:16.13.1-alpine
WORKDIR /usr/src/app
# Copy node modules
COPY --from=builder node_modules node_modules
# Copy app code
COPY . .
