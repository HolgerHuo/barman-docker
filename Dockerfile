FROM debian:trixie

RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates curl

# Install postgres clients so that barman can use the appropriate version when
# using pg_basebackup.
# Install some other requirements as well.
#   cron: For scheduling base backups
#   gcc: For building psycopg2
#   libpq-dev: Needed to build/run psycopg2
#   libpython-dev: For building psycopg2
#   python: Needed to run barman
RUN install -d /usr/share/postgresql-common/pgdg \
    && curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    && sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt trixie-pgdg main' > /etc/apt/sources.list.d/pgdg.list" \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		cron \
		gcc \
		libpq-dev \
		libpython3-dev \
		postgresql-client-9.5 \
		postgresql-client-9.6 \
		postgresql-client-10 \
		postgresql-client-11 \
		postgresql-client-12 \
		postgresql-client-13 \
		postgresql-client-14 \
		postgresql-client-15 \
  		postgresql-client-16 \
    	postgresql-client-17 \
		postgresql-client-18 \
		python3 \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -f /etc/crontab /etc/cron.*/* \
	&& sed -i 's/\(.*pam_loginuid.so\)/#\1/' /etc/pam.d/cron

RUN sh -c "curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 - --break-system-packages" \
	&& useradd --system --shell /bin/bash barman \
	&& mkdir -p /etc/barman/barman.d \
	&& echo "* * * * * barman /usr/local/bin/barman -q cron --keep-descriptors" >> /etc/cron.d/barman

RUN pip install barman==3.16.2 requests==2.32.5 --break-system-packages

WORKDIR /var/lib/barman
CMD ["cron", "-L", "4",  "-f"]
