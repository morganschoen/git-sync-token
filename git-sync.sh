#!/bin/sh

set -e

# Retrieve parameters
SOURCE_REPO=$1
SOURCE_BRANCH=$2
DESTINATION_REPO=$3
DESTINATION_BRANCH=$4

# Obtain the GitHub App token from the environment (source)
export GITHUB_TOKEN_SOURCE=$GITHUB_APP_TOKEN_SOURCE

# Obtain the GitHub App token from the environment (destination)
export GITHUB_TOKEN_DESTINATION=$GITHUB_APP_TOKEN_DESTINATION

# Construct HTTPS repository URLs
SOURCE_REPO="https://x-access-token:$GITHUB_TOKEN_SOURCE@github.com/${SOURCE_REPO}.git"
DESTINATION_REPO="https://x-access-token:$GITHUB_TOKEN_DESTINATION@github.com/${DESTINATION_REPO}.git"

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

# Define the authentication header for GitHub API (source)
#GIT_AUTH_HEADER="Authorization: token $GITHUB_TOKEN_SOURCE"

# Clone the source repository
git clone "$SOURCE_REPO" /root/source --origin source && cd /root/source

# Add the destination as a remote repository
git remote add destination "$DESTINATION_REPO"

# Fetch all branches from the source
git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

# Print out all branches for verification
git --no-pager branch -a -vv

# Define the authentication header for GitHub API (destination)
#GIT_AUTH_HEADER="Authorization: token $GITHUB_TOKEN_DESTINATION"

# Push the specified branch from source to destination
git push destination "${SOURCE_BRANCH}:${DESTINATION_BRANCH}" -f
