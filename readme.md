## Instuctions d'installation

docker-compose up -d

docker container ls => Récupération de l'id des containers

Lancer le script createcontainerns.sh > creation du lien symbolique pour les namespaces

con1 => idcontainer1 choisit comme namespace pour le container 1
con2 => idcontainer2 choisit comme namespace pour le container 2

con1 est le firewall
con2 est le satellite

# Création du virtual cable

ip link add veth-fw type veth peer name veth-sat

# Rattachement des interfaces virtuelles aux containers

ip link set veth-fw netns <nscon1>
ip link set veth-sat netns <nscon2>

# Ajout des adresses ip

ip netns <con1> ip addr add 10.10.10.1/24 dev veth-fw
ip netns <con2> ip addr add 10.10.10.2/24 dev veth-sat

# Passer les interfaces de up à down

ip netns <con1> ip link set veth-fw up
ip netns <con2> ip link set veth-sat up

# Ajout de la route par défaut dans le satellite

ip netns exec <con2> ip route add default via 10.10.10.1

# Création du nat entre le satellite et firewall

(apt install iptables)
iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -d 0.0.0.0/0 -j MASQUERADE

# Activation de l'ip forwarding sur le firewall

vim /etc/systctl.conf => net.ipv4.ip_forward=1 à décommenter

# Ajout du dns google à la conf

sur le firewall et sur le satellite

echo "nameserver 8.8.8.8 > /etc/resolv.conf"

# Installation terminée

