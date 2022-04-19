FROM ruby:3.0.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails_project
WORKDIR /rails_project
COPY Gemfile /rails_project/Gemfile
COPY Gemfile.lock /rails_project/Gemfile.lock
RUN bundle install
COPY . /rails_project

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]