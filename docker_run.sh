#!/bin/sh

set -e

PATH=/home/app/local/ruby/bin:$PATH

git fetch
git checkout $GIT_BRANCH
git pull

ruby app.rb
