#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
  );

  INSERT INTO product (name, description)
  VALUES
    ('Support Enterprise', 'Our greatest edition for all of your ticket needs'),
    ('Support Professional', 'Our best value for providing professional support to your users'),
    ('Support Team', 'Getting familiar with our solutions to provide value for your users'),
    ('Chat Enterprise', 'Offer 24h real-time support to your customers'),
    ('Chat Professional', 'Embedded, real-time, chat widget for your website'),
    ('Zendesk Suite', 'All of our features in a simple, ready-to-use package');
EOSQL
