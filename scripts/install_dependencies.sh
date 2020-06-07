#!/bin/bash

set -e

main()
{
  if [[ -x "$(command -v bundle)" ]]; then
    echo "Bundle already installed!"
  else
    echo "Installing bundler..."
    gem install bundler
  fi

  bundle install --path vendor/bundle
}

main
