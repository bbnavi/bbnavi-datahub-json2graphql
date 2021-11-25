FROM registry.gitlab.tpwd.de/cmmc-systems/ruby-nginx/ruby-2.7.1

RUN mkdir -p /unicorn
RUN mkdir -p /app
WORKDIR /app

# nginx default
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/database.yml /app/config/database.yml
COPY docker/unicorn.rb /app/config/unicorn.rb

COPY . .

RUN chmod +x /app/docker/entrypoint.sh

RUN bundle install

ENTRYPOINT ["/app/docker/entrypoint.sh"]

CMD ["sh", "-c", "nginx-debug ; bundle exec unicorn -c config/unicorn.rb"]
