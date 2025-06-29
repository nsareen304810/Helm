#!/bin/bash
airflow db upgrade
exec airflow "$@"
