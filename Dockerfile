FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y nodejs mariadb-client

WORKDIR /demo_docker

COPY Gemfile /demo_docker/Gemfile
COPY Gemfile.lock /demo_docker/Gemfile.lock

RUN bundle install

# Copy and run script every time the container start.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]