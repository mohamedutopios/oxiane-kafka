Le fichier `zookeeper.properties` dans Apache Kafka est utilisé pour configurer ZooKeeper, qui est crucial pour la gestion des métadonnées et la coordination dans un cluster Kafka. Voici un résumé des options les plus courantes que vous pouvez trouver dans ce fichier, avec leurs explications :

### Paramètres Généraux de Configuration
- **clientPort**: Le port d'écoute pour les connexions des clients à ZooKeeper. Typiquement, ce port est 2181.
- **dataDir**: Répertoire où ZooKeeper stocke ses fichiers de données persistants.
- **dataLogDir**: Optionnel. Répertoire où ZooKeeper stocke ses fichiers de log. Si non spécifié, ZooKeeper utilise `dataDir` pour le stockage des logs.

### Performance et Scalabilité
- **tickTime**: Durée en millisecondes de chaque "tick", qui est la base de temps pour mesurer les durées dans ZooKeeper, telles que les durées de session et les délais d'attente.
- **initLimit**: Nombre de "ticks" que le follower peut être derrière le leader lors du démarrage initial de ZooKeeper.
- **syncLimit**: Nombre de "ticks" qu'un follower peut être derrière le leader pendant le fonctionnement normal.

### Sécurité
- **authProvider.x**: Configure l'authentification. Par exemple, `authProvider.1=org.apache.zookeeper.server.auth.SASLAuthenticationProvider` active l'authentification SASL.
- **ssl.keyStore.location** et **ssl.keyStore.password**: Emplacement et mot de passe du keystore SSL pour les connexions sécurisées.
- **ssl.trustStore.location** et **ssl.trustStore.password**: Emplacement et mot de passe du truststore SSL.

### Réplication et Quorum
- **server.x=A:B:C**: Configuration des serveurs dans un ensemble ZooKeeper. `x` est un identifiant unique pour chaque serveur; `A` est l'adresse IP du serveur; `B` est le port de communication entre les pairs pour la formation du quorum; `C` est le port par lequel les leaders sont élus. Ces lignes sont utilisées dans les ensembles ZooKeeper de plusieurs serveurs pour gérer la tolérance aux pannes.
- **maxClientCnxns**: Nombre maximum de connexions simultanées qu'un client peut établir avec un seul serveur ZooKeeper.

### Logs et Audit
- **quorumListenOnAllIPs**: Détermine si ZooKeeper doit écouter sur toutes les interfaces réseau ou non.
- **autopurge.snapRetainCount** et **autopurge.purgeInterval**: Configurations pour le nettoyage automatique des anciens snapshots et logs. `snapRetainCount` indique le nombre de snapshots à conserver, et `purgeInterval` spécifie l'intervalle (en heures) entre deux purges automatiques.

### Divers
- **standaloneEnabled** et **reconfigEnabled**: `standaloneEnabled` définit si ZooKeeper doit opérer en mode standalone (c'est-à-dire sans quorum) et `reconfigEnabled` active ou désactive la possibilité de reconfiguration dynamique des clusters ZooKeeper.

