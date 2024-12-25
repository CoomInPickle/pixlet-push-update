#!/bin/sh
# Use UPDATE_INTERVAL if defined, otherwise run once
UPDATE_INTERVAL=${UPDATE_INTERVAL:-}

PIXLET=/bin/pixlet


if [ -z "$UPDATE_INTERVAL" ]; then
  # Run once if UPDATE_INTERVAL is not defined
  ${PIXLET} render /app.star && \
    ${PIXLET} push --background \
                   --api-token ${PIXLET_API_TOKEN} \
                   --installation-id ${PIXLET_INSTALLATION_ID} \
                   ${PIXLET_DEVICE_ID} \
                   /app.webp
else
  # Run every UPDATE_INTERVAL seconds if defined
  while true; do
    ${PIXLET} render /app.star && \
      ${PIXLET} push --background \
                     --api-token ${PIXLET_API_TOKEN} \
                     --installation-id ${PIXLET_INSTALLATION_ID} \
                     ${PIXLET_DEVICE_ID} \
                     /app.webp
    sleep $UPDATE_INTERVAL
  done
fi
