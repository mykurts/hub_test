FROM ruby:3.0.1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y \
 build-essential libpq-dev nodejs zlib1g-dev liblzma-dev yarn
WORKDIR app/hub_test
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN SECRET_KEY_BASE="assets_compile" RAILS_ENV=production bundle exec rake assets:precompile
# Add entrypoint script to handle migrations

# RUN ["chmod", "+x", "./docker-entrypoint.sh"]

# ENTRYPOINT [ "./docker-entrypoint.sh" ]
EXPOSE 1598
CMD ["rails", "server", "-b", "0.0.0.0"]