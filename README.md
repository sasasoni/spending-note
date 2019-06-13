# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

### create database

Before put this command, need to start database.
`$ bin/rails db:create`

### start database

`$ sudo service postgresql start`
password: soni

### job scheduling

install Redis
`$ sudo apt install redis-server`
start Redis
`$ redis-server`

start sidekiq
`$ bundle exec sidekiq`
