#!/bin/sh

setup_git() {
  git config --global user.email "snw35@use.startmail.com"
  git config --global user.name "snw35"
  git remote add origin https://${GH_TOKEN}@github.com/snw35/nvchecker.git > /dev/null 2>&1
}

commit_files() {
  git checkout master
  git add -A
  git commit --message "Software Updated
  Commit: $TRAVIS_COMMIT
  Travis build: $TRAVIS_BUILD_NUMBER
  nvchecker version: $NVCHECKER_VERSION
  tornado version: $TORNADO_VERSION
  pycurl version: $PYCURL_VERSION"
}

create_tag() {
  if [ "`git ls-remote --exit-code --tags origin $NVCHECKER_VERSION`" ]; then
    git push --delete origin $NVCHECKER_VERSION
  fi
  git tag $NVCHECKER_VERSION $TRAVIS_COMMIT > /dev/null 2>&1
}

upload_files() {
  git push --quiet --set-upstream origin
  git push --tags --quiet --set-upstream origin
}

setup_git
commit_files
create_tag
upload_files
