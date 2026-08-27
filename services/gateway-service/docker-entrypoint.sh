#!/usr/bin/env bash

if [[ -n "${POSTGRES_USER:-}" ]]; then
	if [[ -f /run/secrets/db_password ]]; then
		export POSTGRES_PASSWORD=$(cat /run/secrets/db_password)
	else
		echo 'ENTRYPOINT FILE ERROR: File db_password not found! Exiting...' 1>&2
		exit 1
	fi
fi


if [[ -n "${RABBIT_MQ_USER:-}" ]]; then
	if [[ -f /run/secrets/mq_password ]]; then
		export RABBIT_MQ_PASSWORD=$(cat /run/secrets/mq_password)
	else
		echo 'ENTRYPOINT FILE ERROR: File mq_password not found! Exiting...' 1>&2
		exit 1
	fi
fi

exec "$@"
