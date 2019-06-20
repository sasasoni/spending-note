# README

Spending-Note は、支出の合計金額を記録して家計簿代わりに。また、親にお遣い費用、食費や飲み物代など最低限の費用を自動でメールで請求することに特化したアプリです。

- Ruby 2.5.1

- Rails 5.2.3

### create database

Before put this command, need to start database.
`$ bin/rails db:create`

### start database

`$ sudo service postgresql start`
password: \*\*\*\*

<!-- sasa -> ???? -->

### job scheduling

install Redis
`$ sudo apt install redis-server`
start Redis
`$ redis-server`

start sidekiq
`$ bundle exec sidekiq`
