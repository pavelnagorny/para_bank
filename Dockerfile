# Use an official Ruby runtime as a parent image
FROM ruby:3.2.1

RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

USER root:root
RUN chmod 755 /usr/bin/chromium
RUN chmod -R 755 /usr/bin/chromedriver

# Set the working directory in the container
WORKDIR /usr/src/parabank

# Install required dependencies
RUN gem install bundler

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the test scripts into the container
COPY . .

# Set the entry point to run your tests
ENTRYPOINT ["cucumber"]
