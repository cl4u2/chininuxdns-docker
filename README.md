DNS basato su chininux
======================
Container docker per DNS basato su [chininux](https://github.com/ninuxorg/chininux).
Scarica le associazioni tra indirizzi IP [ninux](http://wiki.ninux.org) e nomi dall'API di [nodeshot](https://github.com/ninuxorg/nodeshot) periodicamente.
Permette di fare lookup e reverse lookup sugli indirizzi IP ninux.


English: chininux-based DNS
-------------------------

[chininux](https://github.com/ninuxorg/chininux) based DNS docker container.
It retrieves the association between [ninux](http://wiki.ninux.org) IP addressess and names from the [nodeshot](https://github.com/ninuxorg/nodeshot) API periodically.
It allows to perform lookups and reverse lookups on the ninux IP addresses.


Installazione
-------------

clonare o scaricare questo repository

fare il build dell'immagine docker
```
cd chininuxdns-docker
docker build --tag chininuxdns .
```

lanciare il container docker
```
docker run -d -p 53:53/udp chininuxdns
```

E configurare opportunamente il proprio firewall.


Test
----

reverse lookup di un indirizzo ninux
```
dig @127.0.0.1 -x 172.16.176.1

dig @127.0.0.1 -x 2001:4c00:893b:1:176::1
```

lookup di un indirizzo Internet
```
dig @127.0.0.1 wiki.ninux.org
```


Installazione manuale (no docker)
---------------------------------

Installare tramite il gestore di pacchetti della propria distribuzione Linux (per esempio apt-get) i pacchetti python2.7, dnsmasq e git.

Scaricare o clonare con git questo repository nella directory `/root/chininux-docker`.

Clonare con git il repository di chininux in `/root/chininux` e scaricare le dipendenze con pip:
```
git clone https://github.com/ninuxorg/chininux /root/chininux
cd /root/chininux
git submodule init
git submodule update
pip install -r /root/chininux/requirements.txt
```

Copiare da questo repository la configurazione di chininux:
```
cp /root/chininux-docker/settings.py /root/chininux/
```

Creare la directory da cui dnsmasq leggera' il file hosts prodotto da chininux:
```
mkdir -p /etc/chosts
```

Aggiungere al cron lo script che chiama periodicamente chininux per produrre il file hosts. Per esempio:
```
cp /root/chininux-dcoker/chininuxhostscript /etc/cron.hourly/chininuxhostscript
chmod +x /etc/cron.hourly/chininuxhostscript
```

E lanciarlo una volta per inizializzare il file hosts in /etc/chosts/:
```
/etc/cron.hourly/chininuxhostscript
```

Infine, dopo aver configurato opportunamente i propri firewall, lanciare dnsmasq:
```
dnsmasq -d --hostsdir=/etc/hosts -C /root/chininux-docker/dnsmasq.conf
```


