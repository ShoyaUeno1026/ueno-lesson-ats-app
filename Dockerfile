FROM node:22.1.0 as node
FROM ruby:3.3.0

ENV TZ Asia/Tokyo

WORKDIR /ueno-lesson-ats-app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN npm install yarn -g -y

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem update --system && bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY . ./
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]