FROM node:16.17.1-alpine AS build

WORKDIR app

# copy everything
COPY . .

# install packages
RUN npm i

# build app with node plugin
RUN npm run build

FROM node:16.17.1-alpine AS prod

COPY --from=build /app/package.json .
COPY --from=build /app/build .

EXPOSE 3000

CMD ["node", "index.js"]