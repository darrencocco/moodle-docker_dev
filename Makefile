COMPOSE_SERVER = -f servers/docker-compose.yaml
COMPOSE_WINDOWS_UTILS = -f utilities/networking/windows.yaml
COMPOSE_LINUX_UTILS = -f utilities/networking/linux.yaml
COMPOSE_MAC_UTILS = -f utilities/networking/mac.yaml

OVPN_DATADIR = utilities/networking/openvpn-data/

### API servers
start-servers:
	@docker-compose $(COMPOSE_SERVER) up -d

stop-servers:
	@docker-compose $(COMPOSE_SERVER) down


stop-all: stop-compilers stop-servers

all: build-all start-servers

### Setup
setup-windows:
	@docker-compose $(COMPOSE_MAC_UTILS) down
	@rm -f local-dev.ovpn
	@rm -rf $(OVPN_DATADIR)
	@docker-compose $(COMPOSE_MAC_UTILS) up -d
	@docker-compose $(COMPOSE_MAC_UTILS) stop
	@docker-compose $(COMPOSE_WINDOWS_UTILS) run --rm openvpn ovpn_genconfig -u udp://127.0.0.1 -D -d -p 'route 172.16.0.0 255.240.0.0'
	@docker-compose $(COMPOSE_WINDOWS_UTILS) run --rm openvpn ovpn_initpki nopass
	@docker-compose $(COMPOSE_WINDOWS_UTILS) restart
	@docker-compose $(COMPOSE_WINDOWS_UTILS) run --rm openvpn easyrsa build-client-full local-dev nopass
	@docker-compose $(COMPOSE_WINDOWS_UTILS) run --rm openvpn ovpn_getclient local-dev > local-dev.ovpn
	
setup-linux:
	@docker-compose $(COMPOSE_LINUX_UTILS) up -d
	
setup-mac:
	@docker-compose $(COMPOSE_MAC_UTILS) down
	@rm -f local-dev.ovpn
	@rm -rf $(OVPN_DATADIR)
	@docker-compose $(COMPOSE_MAC_UTILS) up -d
	@docker-compose $(COMPOSE_MAC_UTILS) stop
	@docker-compose $(COMPOSE_MAC_UTILS) run --rm openvpn ovpn_genconfig -u udp://127.0.0.1 -N -D -d -p 'route 172.16.0.0 255.240.0.0 vpn_gateway'
	@docker-compose $(COMPOSE_MAC_UTILS) run --rm openvpn ovpn_initpki nopass
	@docker-compose $(COMPOSE_MAC_UTILS) restart
	@docker-compose $(COMPOSE_MAC_UTILS) run --rm openvpn easyrsa build-client-full local-dev nopass
	@docker-compose $(COMPOSE_MAC_UTILS) run --rm openvpn ovpn_getclient local-dev > local-dev.ovpn


### Cleaning
clean: start-servers
	@docker-compose $(COMPOSE_SERVER) down -v

prune:
	@docker system prune -f

clean-all: prune clean
