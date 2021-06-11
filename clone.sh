#!/bin/sh

echo "Cloning repositories..."

# Set Git globals
git config --global user.email "alex@codecourse.com"

SITES=$HOME/Code

git clone git@github.com:codecourse/codecourse.git $SITES/codecourse
git clone git@github.com:codecourse/api.codecourse.com.git $SITES/api.codecourse.com
git clone git@github.com:codecourse/client.codecourse.com.git $SITES/client.codecourse.com
