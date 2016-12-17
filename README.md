DNS basato su chininux
======================
Container docker per DNS basato su (chininux)[https://github.com/ninuxorg/chininux].
Scarica le associazioni tra indirizzi IP (ninux)[http://wiki.ninux.org] e nomi dall'API di (nodeshot)[https://github.com/ninuxorg/nodeshot] periodicamente.
Permette di fare lookup e reverse lookup sugli indirizzi IP ninux.


English: chinux-based DNS
-------------------------

(chininux)[https://github.com/ninuxorg/chininux] based DNS docker container.
It retrieves the association between (ninux)[http://wiki.ninux.org] IP addressess and names from the (nodeshot)[https://github.com/ninuxorg/nodeshot] API periodically.
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


Test
----

reverse lookup di un indirizzo ninux
```
dig @127.0.0.1 -x 172.16.176.1
```

lookup di un indirizzo Internet
```
dig @127.0.0.1 wiki.ninux.org
```

