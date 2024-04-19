### Étape 1 : Télécharger Kafka
Téléchargez la dernière version de Kafka depuis le site officiel d'Apache Kafka ou utilisez votre gestionnaire de paquets si vous êtes sur Linux.

### Étape 2 : Configuration de base
1. **Extrayez** le contenu du fichier téléchargé dans un répertoire de votre choix.
2. Ouvrez le répertoire `config` et créez une nouvelle configuration pour KRaft. Vous pouvez copier `server.properties` en `server.properties.kraft` pour commencer.

### Étape 3 : Modifier les Propriétés pour KRaft
Dans `server.properties.kraft`, modifiez ou ajoutez les propriétés suivantes :
```properties
# Désactiver Zookeeper
process.roles=broker,controller

# Chemin d'accès pour stocker les métadonnées de KRaft
node.id=1
controller.quorum.voters=1@localhost:9093

# Ports et adresses
listeners=PLAINTEXT://localhost:9092
controller.listener.names=CONTROLLER
listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT

# Répertoires de stockage (assurez-vous que ces répertoires existent ou créez-les)
log.dirs=/path/to/kraft-combined-logs
metadata.log.dir=/path/to/metadata-logs

# Autres configurations recommandées
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
```
Assurez-vous de configurer les chemins `log.dirs` et `metadata.log.dir` vers des répertoires valides.

### Étape 4 : Initialiser le Cluster KRaft
Avant de démarrer votre serveur pour la première fois, vous devez initialiser les métadonnées du cluster. Utilisez la commande suivante dans le répertoire de Kafka :
```bash
bin/kafka-storage.sh format -t <UUID> -c config/server.properties.kraft
```
Remplacez `<UUID>` par un identifiant unique généré, que vous pouvez obtenir en utilisant la commande `uuidgen` dans votre terminal.

### Étape 5 : Démarrer le serveur Kafka
Lancez votre serveur Kafka avec la nouvelle configuration :
```bash
bin/kafka-server-start.sh config/server.properties.kraft
```

### Étape 6 : Vérification
Pour vérifier que votre serveur fonctionne correctement, vous pouvez utiliser les outils de ligne de commande de Kafka pour créer des topics, produire et consommer des messages.

Voilà ! Vous avez configuré un serveur Kafka en utilisant le mode KRaft sans Zookeeper. Cette configuration est simplifiée et destinée à un environnement de test ou de développement. Pour une configuration de production, des considérations supplémentaires sur la sécurité, la haute disponibilité et la performance doivent être prises en compte.