#!/bin/bash

set -e

GIT_USERNAME=$1
GIT_EMAIL=$2
GIT_COMMIT_SHA=$3
TARGET_BRANCH=$4
ARTIFACT_DIRECTORY=$5
REPO=$6

if [ -z $GIT_USERNAME ]; then
  echo "Please provide a username to use as git deployer"
  exit 1
elif [ -z $GIT_EMAIL ]; then
  echo "Please provide an email to use as git deployer"
  exit 1
elif [ -z $GIT_COMMIT_SHA ]; then
  echo "Please provide an commit use as deploy message"
  exit 1
elif [ -z $TARGET_BRANCH ]; then
  echo "Please provide a target branch to deploy to"
  exit 1
elif [ -z $ARTIFACT_DIRECTORY ]; then
  echo "Please provide the directory where artifacts are stored"
  exit 1
elif [ -z $REPO ]; then
  echo "Please provide the repository (such as git@github.com:username/branch.git) to deploy to"
  exit 1
fi

CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
GIT_COMMIT_MESSAGE=$(git log --format=oneline -n 1 $GIT_COMMIT_SHA)
TEMP_BRANCH_NAME=temp-branch

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USERNAME

if ! [ $CURRENT_BRANCH == "master" ]; then
  echo "Will not deploy from non-master branch"
  exit 1
fi

if ! [ $(git ls-remote --heads $REPO $TARGET_BRANCH | wc -l) -ge 1 ]; then
  echo "Creating remote branch: $TARGET_BRANCH"
  git checkout -b $TARGET_BRANCH
  git commit --allow-empty -m "first commit"
  git push origin $TARGET_BRANCH
  git checkout master
fi

if [ -d $TEMP_BRANCH_NAME ]; then rm -rf $TEMP_BRANCH_NAME; fi

# Clone Target Branch and remove content
git clone \
  --single-branch --branch $TARGET_BRANCH \
  $REPO $TEMP_BRANCH_NAME && \
  cd $TEMP_BRANCH_NAME && \
  git rm -rf . > /dev/null 2>&1 && \
  cd ../

cp -a $ARTIFACT_DIRECTORY/. $TEMP_BRANCH_NAME

# Deploy changes
cd $TEMP_BRANCH_NAME && \
  git add . && \
  git commit -m  "Auto-generated - $GIT_COMMIT_MESSAGE [ci skip]" && \
  git push origin $TARGET_BRANCH && \
  cd ../

# Cleanup
rm -rf $TEMP_BRANCH_NAME
