### 1. **Gestion des Topics**
- **Créer un topic**:
  ```bash
  kafka-topics --bootstrap-server localhost:9092 --create --topic topic1 --partitions 3 --replication-factor 2
  ```
  
- **Lister tous les topics**:
  ```bash
  kafka-topics --bootstrap-server localhost:9092 --list
  ```
  
- **Décrire un topic spécifique**:
  ```bash
  kafka-topics --bootstrap-server localhost:9092 --describe --topic topic1
  ```
  
- **Supprimer un topic**:
  ```bash
  kafka-topics --bootstrap-server localhost:9092 --delete --topic topic1
  ```

- **Modifier le nombre de partitions d'un topic**:
  ```bash
  kafka-topics --bootstrap-server localhost:9092 --alter --topic your_topic --partitions 6
  ```

- **Création d'un topic + modification de nombre de replication :**

### Étape 0: Créer un topic :

    1 - kafka-topics --bootstrap-server localhost:9092 --create --topic demo --partitions 4
    2 - Je vois, pour augmenter le facteur de réplication d'un topic dans Apache Kafka, c'est un peu plus complexe que d'augmenter simplement le nombre de partitions, car Kafka ne fournit pas une commande directe pour augmenter le facteur de réplication d'un topic existant via la commande `kafka-topics`.

Pour augmenter le facteur de réplication, vous devez utiliser un processus en deux étapes : générer un fichier de reconfiguration des réplicas pour chaque partition, puis appliquer cette reconfiguration. Voici les étapes détaillées pour le faire :

### Étape 1: Générer un fichier de reconfiguration :

Vous devez d'abord créer un fichier JSON qui spécifie le nouveau facteur de réplication pour chaque partition. Ce fichier définira quelles partitions doivent avoir des réplicas ajoutés et sur quels brokers ces réplicas seront placés.

1. **Exporter la configuration actuelle des partitions** :
   ```bash
   kafka-topics --bootstrap-server kafka1:9092 --topic topic1 --describe
   ```

   Prenez note de la configuration actuelle de chaque partition.

2. **Créer un fichier JSON de reconfiguration** :
   Vous devez ajuster ce fichier pour refléter le nouveau facteur de réplication souhaité. Par exemple, si un topic a actuellement un facteur de réplication de 1 et que vous souhaitez l'augmenter à 2, vous ajoutez un broker supplémentaire à la liste des réplicas pour chaque partition.

   ```json
   {
     "version": 1,
     "partitions": [
         {"topic": "topic1", "partition": 0, "replicas": [1, 2]},
         {"topic": "topic1", "partition": 1, "replicas": [1, 3]},
         {"topic": "topic1", "partition": 2, "replicas": [2, 3]},
         {"topic": "topic1", "partition": 3, "replicas": [1, 3]}
     ]
   }
   ```

### Étape 2: Appliquer la reconfiguration

Une fois que vous avez votre fichier JSON préparé, vous pouvez utiliser l'outil `kafka-reassign-partitions` pour appliquer la nouvelle configuration de réplication.

```bash
kafka-reassign-partitions --bootstrap-server kafka1:9092 --reassignment-json-file path_to_your_file.json --execute
```

Après avoir exécuté la commande, vous pouvez vérifier l'état du réassignement :

```bash
kafka-reassign-partitions --bootstrap-server kafka1:9092 --reassignment-json-file path_to_your_file.json --verify
```

### Points à considérer

- Assurez-vous que votre cluster a suffisamment de brokers pour supporter le facteur de réplication augmenté.
- Réfléchissez bien à la distribution des réplicas pour éviter de surcharger certains brokers.
- Ce processus peut avoir un impact sur les performances du cluster pendant sa réalisation, notamment si le trafic est élevé.



