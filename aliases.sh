#!/bin/bash

git config --global alias.review '!f() {
  REPO=`git config remote.origin.url | sed "s/^.*:\(.*\).git/\1/"`
  BRANCH=`git rev-parse --abbrev-ref HEAD`
  echo "https://www.pullreview.com/${REPO}/reviews/${BRANCH}"
}
xdg-open `f`'

git config --global alias.add-upstream 'remote add upstream'
git config --global alias.sync-master-with-upstream '!f() {
  HEAD_NAME=$(cat $(git rev-parse --show-toplevel)/.git/refs/remotes/origin/HEAD | sed "s/.*\///")
  git fetch upstream && git rebase upstream/$HEAD_NAME
}
f'

git config --global alias.merge-dry '!f() {
  BASE_SHA=`git merge-base HEAD $1`
  OUTPUT=`mktemp --suffix=.patch`
  git merge-tree $BASE_SHA $1 HEAD > $OUTPUT
  subl $OUTPUT
}
f'
