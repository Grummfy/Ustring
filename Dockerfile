FROM debian:sid

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget curl \
	unzip git php-cli php-mbstring php-xdebug php-xml unicode unicode-data \
	unifont ttf-unifont locales ttf-ancient-fonts xfonts-efont-unicode openssl ca-certificates && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	locale-gen en_GB.UTF-8 && \
    update-locale en_GB.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
	rm -rf \
		/var/lib/apt/lists/* \
		/tmp/* \
		/var/tmp/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
	php -r "unlink('composer-setup.php');" && \
	rm installer

WORKDIR /var/www/src
