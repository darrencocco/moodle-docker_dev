Mac OS setup guide
==================

1. Follow the instructions for installing [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/)

2. Install Xcode through the Mac App Store

3. Download the [docker-hostmanager](https://github.com/iamluc/docker-hostmanager/releases) PHAR and copy it to /opt/docker/docker-hostmanager.phar

4. Download and install [OpenVPN Connect for macOS](https://openvpn.net/downloads/openvpn-connect-v3-macos.dmg)

5. Restart

6. Run `make setup-mac`

7. Load the newly generated local-dev.ovpn file into OpenVPN Connect.
*This VPN connection will be how you access the servers*

*Please note you will have to run the following command and leave it running whenever you are using Docker*
```bash
sudo php /op/docker/docker-hostmanager.phar synchronize-hosts
```
