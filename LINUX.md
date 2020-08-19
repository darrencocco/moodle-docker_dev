Linux setup guide
=================


Ubuntu LTS
----------

1. Run the following
```bash
sudo sh bootstrap/linux/ubuntu/install-docker.sh
```

2. Add your user to the docker group so that you can run docker commands as your normal user. (optional, recommended)
```bash
sudo usermod -aG docker $(INSERT YOUR USERNAME HERE)
```

3. Run bootstrap/linux/subuid-line.sh and add it's output to the start of /etc/subuid
*The output should look something like `user:1000:1`*

4. Run bootstrap/linux/subgid-line.sh and add it's output to the start of /etc/subgid
*The output should look SIMILAR to that from step 3*

5. Create/update the file /etc/docker/daemon.json to have the following contents
```json
{
  "userns-remap": "$(INSERT YOUR USERNAME HERE)"
}
```
*All this will map files created by root in docker containers to your normal user*

6. Now would be a good time to restart the docker daemon or just restart your whole computer.

7. Run `make setup-linux`


Fedora
------
*TODO: Write Fedora instructions*

Notes: Currently there are some issues with the bridges not being added to the
appropriate Trusted zone in FirewallD. You will have to run the following
commands to fix it every time there is an issue until a daemon can be written
to monitor and update it automatically.

firewall-cmd --permanent --zone=trusted --change-interface=docker0

firewall-cmd --zone=trusted --change-interface=br-$(BRIDGE ID)
