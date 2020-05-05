FROM ruby:2.7.1

ARG http_proxy
ARG https_proxy

RUN apt-get install -y git

RUN mkdir /tdiary

RUN git clone https://github.com/tdiary/tdiary-core.git /tdiary/tdiary-core
RUN git clone https://github.com/tdiary/tdiary-contrib.git /tdiary/tdiary-contrib
RUN git clone https://github.com/tdiary/tdiary-theme.git /tdiary/tdiary-theme
RUN git clone https://github.com/tdiary/tdiary-style-gfm.git /tdiary/tdiary-style-gfm
RUN git clone https://github.com/tamoot/tdiary_local_plugin.git /tdiary/tdiary_local_plugin

WORKDIR /tdiary/tdiary-core

# bundler
ADD Gemfile.local ./Gemfile.local
RUN bundle install --path vendor/bundle --without=development:test --jobs=4 --retry=3

# conf
ADD htpasswd ./.htpasswd

# rename for entrypoint.sh
RUN mv config.ru config.ru.org

# theme
RUN cd theme && ln -s  ../../tdiary-theme/* .

# js
RUN cd js && ln -s ../../tdiary-contrib/js/* .


# puma
ADD puma_config.rb ./puma_config.rb
RUN mkdir -p ./tmp/puma ./tmp/pids ./tmp/logs ./tmp/sockets
ADD entrypoint.sh ./entrypoint.sh
RUN chmod 0755 ./entrypoint.sh

# share other container
VOLUME /tdiary/tdiary-core/public
VOLUME /tdiary/tdiary-core/tmp

CMD ["/tdiary/tdiary-core/entrypoint.sh"]
