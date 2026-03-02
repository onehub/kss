#!/bin/sh
set -e

echo "Building all Ruby versions..."
docker buildx bake

echo ""
echo "Running tests..."
parallel --will-cite --tag --tagstring "Ruby {}" --line-buffer \
  docker run --rm "kss-test:{}" \
  ::: 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 3.0 3.1 3.2 3.3 3.4 4.0 head
