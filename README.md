# pixlet-push-update

This is a dockerized build of [tidbyt/pixlet](https://github.com/tidbyt/pixlet) with a helpful script that builds and pushes and updates an app to a [Tidbyt](https://tidbyt.com) device.
This repo is a fork of [mike-douglas/pixlet-push](https://github.com/mike-douglas/pixlet-push)
## Example

```yaml
version: '3.8'
services:
  pixlet-push:
    image: coominpickle/pixlet-push-update:latest
    environment:
      - PIXLET_API_TOKEN=<YOUR API TOKEN>
      - PIXLET_INSTALLATION_ID=<YOUR APP NAME>
      - PIXLET_DEVICE_ID=<YOUR DEVICE ID>
      - UPDATE_INTERVAL=120
    volumes:
      - ./example.star:/app.star
    restart: unlesss-stopped

```

## Environment Variables

**Note:** Quotation marks (`"`) are **not required** for these environment variables. If quotation marks are added, the variables **will not work correctly**.

- `PIXLET_API_TOKEN`: The API token retrieved from the mobile app  
- `PIXLET_DEVICE_ID`: The Device ID retrieved from the mobile app (on the same screen as the API token)  
- `PIXLET_INSTALLATION_ID`: The unique name of your app that will appear in the app when it's pushed  
- `UPDATE_INTERVAL`: Time between updates, if empty only push once

