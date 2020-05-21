FROM node:12.9.0-alpine

ENV APP_HOME /app
ENV PATH ${APP_HOME}/node_modules/.bin:$PATH
ENV TZ Asia/Tokyo

ENV HOST 0.0.0.0
ENV PORT 8080

WORKDIR ${APP_HOME}
ADD . ${APP_HOME}

RUN apk update && \
    apk upgrade && \
    npm install -g n && \
    npm install -g create-nuxt-app && \
    
    yarn install &&\
    rm -rf /var/cache/apk/*

EXPOSE ${PORT}

CMD ["yarn", "dev"]