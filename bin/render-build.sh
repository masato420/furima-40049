#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate || bundle exec rake db:setup
bundle exec rails generate devise User
bundle exec rake db:migrate