#!/bin/sh
set -e

echo "Building all Ruby versions..."
docker buildx bake

failed=""
for tag in 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 3.0 3.1 3.2 3.3 3.4 4.0; do
  echo ""
  echo "=== Ruby $tag ==="
  if docker run --rm "kss-test:$tag"; then
    echo "--- Ruby $tag: PASS ---"
  else
    echo "--- Ruby $tag: FAIL ---"
    failed="$failed $tag"
  fi
done

echo ""
if [ -n "$failed" ]; then
  echo "FAILED:$failed"
  exit 1
else
  echo "All versions passed."
fi
