#!/bin/sh
# Use UPDATE_INTERVAL if defined, otherwise run once
UPDATE_INTERVAL=${UPDATE_INTERVAL:-}

PIXLET=/bin/pixlet

if [ -z "$UPDATE_INTERVAL" ]; then
  # Run once if UPDATE_INTERVAL is not defined
  if ${PIXLET} render /app.star && \
     ${PIXLET} push --background \
                    --installation-id ${PIXLET_INSTALLATION_ID} \
                     ${PIXLET_DEVICE_ID} \
                    /app.webp \
                    -t ${PIXLET_API_TOKEN}; then
    echo "Pushed successfully once."
  else
    echo "Failed to push."
  fi

else
  # Run every UPDATE_INTERVAL seconds if defined
  while true; do
    if ${PIXLET} render /app.star && \
       ${PIXLET} push --background \
                      --installation-id ${PIXLET_INSTALLATION_ID} \
                       ${PIXLET_DEVICE_ID} \
                      /app.webp \
                      -t ${PIXLET_API_TOKEN}; then
      echo "Pushed successfully, next push in $UPDATE_INTERVAL seconds."
    else
      echo "Failed to push. Retrying in $UPDATE_INTERVAL seconds."
    fi
    sleep $UPDATE_INTERVAL
  done
fi
