#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:create
bundle exec rake generate migration add_password_digest_to_users password_digest:string
bundle exec rake db:migrate