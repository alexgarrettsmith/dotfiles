#!/bin/sh

echo "Cloning repositories..."

# Set Git globals
git config --global user.email "alex@codecourse.com"

SITES=$HOME/Code

git clone git@github.com:codecourse/codecourse.git $SITES/codecourse