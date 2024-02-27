# holo-docker
Linux container images of SteamOS Holo

## Getting Started

```sh
./download.sh
./build.sh
./push_image.sh
```

### SteamDeck

These scripts should work just fine on an actual SteamDeck, assuming that SteamOS is up-to-date, and you are comfortable using the SteamDeck terminal. However you will need to do just a little bit of setup, as the default location for container storage is much too small for this.

```sh
mkdir ~/containers
sudo cp -a /var/lib/container/storage ~/containers/storage
sudo vim /etc/containers/storage.conf
```

Change the line that reads:

- `graphroot = "/var/lib/containers/storage"`

to

- `graphroot = "/home/deck/containers/storage"`

You will also need to use the `sudo` command when running the top-level build and push scripts.

