# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ruby: 3.2.0
  rails: 7.1.1

* Setup
  rails new rails-jsonapi \
    --database=postgresql \
    --skip-action-mailbox \
    --skip-action-text \
    --skip-spring -T \
    --skip-turbolinks \
    --api

* Resources
  resource Author name:string --no-test-framework
  rails g resource Article title:string body:text author:references --no-test-framework

* System dependencies

* Configuration

* Database creation and initialization
  rails db:create db:migrate db:seed

* How to run
  http://localhost:3000/api/articles/1

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
