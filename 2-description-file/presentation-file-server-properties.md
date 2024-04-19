Le fichier `server.properties` est le fichier de configuration principal pour les brokers Kafka. Il contient divers paramètres qui contrôlent le comportement, la performance et les capacités du broker. Voici un résumé des options les plus courantes que vous pouvez trouver dans ce fichier, accompagné de leurs explications :

### Paramètres Généraux de Configuration
- **broker.id**: Identifiant unique du broker dans le cluster Kafka. Chaque broker doit avoir un ID unique.
- **log.dirs**: Emplacements du système de fichiers où Kafka stocke les journaux des partitions.
- **zookeeper.connect**: Liste des hôtes et ports ZooKeeper que Kafka utilise pour se connecter à l'ensemble ZooKeeper.

### Réseau
- **listeners**: Adresses IP et ports que le broker Kafka écoute. Cela peut inclure plusieurs protocoles comme PLAINTEXT, SSL, SASL_PLAINTEXT, SASL_SSL.
- **advertised.listeners**: Liste des hôtes/port que le broker annonce aux producteurs, consommateurs et autres brokers. Ceci est souvent utilisé dans les configurations multi-réseaux ou lors du déploiement de Kafka dans des environnements cloud.
- **num.network.threads**: Nombre de threads que le broker utilise pour gérer les requêtes de réseau.

### Stockage
- **log.segment.bytes**: Taille maximale d'un seul fichier de log avant qu'un nouveau soit créé.
- **log.retention.hours**, **log.retention.bytes**, et **log.retention.minutes**: Contrôlent la durée de rétention des messages sur le broker avant leur suppression automatique.

### Performance
- **num.io.threads**: Nombre de threads utilisés pour le traitement des entrées/sorties; c'est-à-dire la lecture et l'écriture des données sur le disque.
- **socket.send.buffer.bytes** et **socket.receive.buffer.bytes**: Taille des tampons de socket pour les réseaux entrants et sortants.

### Réplication
- **num.replica.fetchers**: Nombre de threads utilisés pour répliquer les messages d'un broker à un autre.
- **replica.lag.time.max.ms**: Temps maximum qu'un réplica peut être en retard derrière le leader avant d'être considéré comme hors service.
- **min.insync.replicas**: Nombre minimum de réplicas qui doivent confirmer une écriture pour qu'elle soit considérée comme réussie lorsque acks est réglé sur "all".

### Sécurité
- **ssl.keystore.location** et **ssl.key.password**: Chemins et mots de passe pour les clés SSL utilisées pour le chiffrement.
- **sasl.enabled.mechanisms**: Mécanismes SASL activés pour l'authentification.

### Divers
- **auto.create.topics.enable**: Permet ou désactive la création automatique de topics si un producteur ou consommateur fait référence à un topic qui n'existe pas encore.
- **delete.topic.enable**: Permet ou désactive la possibilité de supprimer des topics.

### KRaft (Kafka Raft)
- **process.roles**: Définit les rôles du nœud dans une configuration KRaft (broker, controller).
- **node.id**: Identifiant unique du nœud dans une configuration KRaft.
- **controller.quorum.voters**: Adresses des membres du quorum dans une configuration KRaft.
