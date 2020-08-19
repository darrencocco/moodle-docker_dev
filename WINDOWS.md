Windows setup guide
===================

1. Enable local script execution in PowerShell(Run As Admin)
```PowerShell
Set-ExecutionPolicy RemoteSigned
```

2. Run bootstrap/windows/first.ps1 in PowerShell(Run As Admin)

3. Download and install [Docker for Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows) then restart.

4. Run bootstrap/windows/second.ps1 in PowerShell(Run As Admin)

5. Launch Ubuntu for WSL and go through the first time setup process.
*Please note that you will occasionally get notifications asking you to give to files/folders for Docker.
It is recommended you accept them promptly because they are needed for the servers to run*

6. Run bootstrap/windows/third.sh in Ubuntu for WSL

7. Restart again.

8. Run make setup-windows in Ubuntu for WSL

9. Download and install [OpenVPN Connect for Windows](https://openvpn.net/client-connect-vpn-for-windows/)

10. Use the local-dev.ovpn config file that has been generated in this directly. You will nee`d this VPN connection to gain access to the servers inside Docker.
