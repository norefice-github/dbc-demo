#!/bin/bash

# docker context use default
# docker context use cloud-salestestorg-se-cloud-builder

start_time=$(date +%s)
docker buildx build --tag demonstrationorg/mastodon:4.2.3 . --no-cache
end_time=$(date +%s)

elapsed_time=$((end_time - start_time))

printf "\nBuild completed in %02d:%02d:%02d (hh:mm:ss)\n" \
  $((elapsed_time / 3600)) $(((elapsed_time % 3600) / 60)) $((elapsed_time % 60))
