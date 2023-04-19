FROM php:7.0.33-cli

ENV COMPOSER_HOME=/usr/src/dbdiff \
    PATH="/usr/src/dbdiff/vendor/bin:$PATH"

RUN apt-get update && \
    apt-get install --no-install-recommends -y zlib1g-dev && \
    apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo pdo_mysql zip

RUN curl -o composer -sL https://github.com/composer/composer/releases/download/2.2.21/composer.phar

RUN php composer global require --no-plugins dbdiff/dbdiff

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["dbdiff"]