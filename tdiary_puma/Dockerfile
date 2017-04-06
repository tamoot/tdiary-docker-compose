FROM ruby:2.4.1

ARG http_proxy
ARG https_proxy
ARG TDIARY_BASE_DIR
ARG TDIARY_CONF_FILE

RUN apt-get install -y git

RUN mkdir /tdiary

RUN git clone https://github.com/tdiary/tdiary-core.git /tdiary/tdiary-core
RUN git clone https://github.com/tdiary/tdiary-contrib.git /tdiary/tdiary-contrib
RUN git clone https://github.com/tdiary/tdiary-theme.git /tdiary/tdiary-theme

WORKDIR /tdiary/tdiary-core

# bundler
ADD Gemfile.local ./Gemfile.local
RUN bundle install --path vendor/bundle --without=development:test --jobs=4 --retry=3
RUN bundle exec rake assets:copy

# conf
RUN cp ${TDIARY_CONF_FILE} tdiary.conf
ADD htpasswd ./.htpasswd

# rack
RUN sed -i.org -e "s!run TDiary::Application.new!run TDiary::Application.new('${TDIARY_BASE_DIR}')!" ./config.ru

# theme
RUN cd theme && ln -s  ../../tdiary-theme/* .

# puma
ADD puma_config.rb ./puma_config.rb
RUN mkdir -p ./tmp/puma ./tmp/pids ./tmp/logs ./tmp/sockets

# share other container
VOLUME /tdiary/tdiary-core/public
VOLUME /tdiary/tdiary-core/tmp
