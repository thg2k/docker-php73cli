FROM fedora:31
SHELL [ "/bin/bash", "-euxc" ]

LABEL \
  org.label-schema.build-date="2020-03-10T12:00:00Z" \
  org.label-schema.name="Simple PHP 7.3 CLI image" \
  org.label-schema.vendor="ThGnet" \
  org.label-schema.version="1.0"

RUN set -eux; \
  echo 'deltarpm=False' >> /etc/dnf/dnf.conf; \
  echo 'install_weak_deps=False' >> /etc/dnf/dnf.conf; \
  dnf -y update; \
  dnf --best install -y \
    php-cli \
    php-dom php-mbstring php-intl php-json unzip \
    diffutils \
    ; \
  dnf clean all; \
  groupadd -g 5000 app; useradd -u 5000 -g 5000 -d /srv/app -M -c "Web Application" app; \
  test -e /etc/nsswitch.conf.bak && mv /etc/nsswitch.conf.bak /etc/nsswitch.conf; \
  pwck -s; grpck -s; rm -f /etc/*-; \
  curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer;
