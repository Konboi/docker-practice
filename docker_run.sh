#!/bin/sh

set -e

PATH=/home/app/local/ruby/bin:$PATH

git fetch
git checkout $GIT_BRANCH
git pull

bundle install

rackup -p 4567 -o 0.0.0.0 config.ru
