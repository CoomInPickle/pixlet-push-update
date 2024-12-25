#!/bin/sh

# Use UPDATE_INTERVAL if defined, otherwise run once
UPDATE_INTERVAL=${UPDATE_INTERVAL:-}

PIXLET=/bin/pixlet

# Check if UPDATE_INTERVAL is set (i.e., not empty)
if [ -z "$UPDATE_INTERVAL" ]; then
  # Run once if UPDATE_INTERVAL is not defined
  ${PIXLET} render ${1} && \
    ${PIXLET} push --background \
                   --api-token ${PIXLET_API_TOKEN} \
                   --installation-id ${PIXLET_INSTALLATION_ID} \
                   ${PIXLET_DEVICE_ID} \
                   `dirname ${1}`/`basename ${1} .star`.webp
else
  # Run every UPDATE_INTERVAL seconds if defined
  while true; do
    ${PIXLET} render ${1} && \
      ${PIXLET} push --background \
                     --api-token ${PIXLET_API_TOKEN} \
                     --installation-id ${PIXLET_INSTALLATION_ID} \
                     ${PIXLET_DEVICE_ID} \
                     `dirname ${1}`/`basename ${1} .star`.webp
    # Wait for the specified interval before repeating
    sleep $UPDATE_INTERVAL
  done
fi
