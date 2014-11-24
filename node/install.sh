#!/bin/sh
#
# Node.js
#
# This installs some of the common dependencies needed (or at least desired)
# using NPM.

if test ! $(which npm)
then
  echo "  Installing node for you."
  brew install node > /tmp/node-install.log
fi

# Install NPM packages
npm install -g bower yo karma-cli

exit 0