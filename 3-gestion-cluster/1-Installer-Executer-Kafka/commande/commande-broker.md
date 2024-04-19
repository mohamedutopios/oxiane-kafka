### 2. **Gestion des Brokers**
- **Voir les détails des brokers** (Nécessite l'outil kafka-broker-api-versions):
  ```bash
  kafka-broker-api-versions --bootstrap-server localhost:9092
  ```

### 3. **Consommation et Production de Messages**
- **Produire des messages dans un topic**:
  ```bash
  kafka-console-producer --broker-list localhost:9092 --topic your_topic
  ```
  
- **Consommer des messages depuis un topic**:
  ```bash
  kafka-console-consumer --bootstrap-server localhost:9092 --topic your_topic --from-beginning
  ```

### 4. **Gestion des Groupes de Consommateurs**
- **Lister tous les groupes de consommateurs**:
  ```bash
  kafka-consumer-groups --bootstrap-server localhost:9092 --list
  ```
  
- **Décrire un groupe de consommateurs**:
  ```bash
  kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group your_group
  ```

- **Réinitialiser les offsets d'un groupe de consommateurs**:
  ```bash
  kafka-consumer-groups --bootstrap-server localhost:9092 --group your_group --reset-offsets --to-earliest --execute --topic your_topic
  ```

### 5. **Gestion des ACLs (Access Control Lists)**
- **Ajouter une ACL pour un utilisateur spécifique sur un topic**:
  ```bash
  kafka-acls --bootstrap-server localhost:9092 --add --allow-principal User:your_user --operation Read --topic your_topic
  ```

- **Lister toutes les ACLs**:
  ```bash
  kafka-acls --bootstrap-server localhost:9092 --list
  ```

### 6. **Surveillance et Maintenance**
- **Voir l'état du cluster**:
  Cela peut nécessiter des outils externes comme Apache Kafka's JMX metrics ou des outils de monitoring tels que Prometheus avec Kafka Exporter.

Ces commandes vous permettent de contrôler et de gérer de nombreux aspects de votre cluster Kafka. Utilisez-les en fonction de vos besoins pour créer, surveiller, et optimiser vos systèmes Kafka. Assurez-vous que vous avez configuré l'accès à votre serveur Kafka correctement et que vos commandes correspondent aux versions des clients Kafka que vous utilisez.