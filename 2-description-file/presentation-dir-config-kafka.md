Le dossier `config/` dans une installation Apache Kafka contient divers fichiers de configuration essentiels pour le fonctionnement du broker Kafka, les producteurs, les consommateurs, ainsi que pour la gestion des connecteurs et des streams. Voici une liste détaillée des fichiers de configuration typiques que vous trouverez dans ce dossier, ainsi que les rôles de chacun :

1. **server.properties** : C'est le fichier de configuration principal pour les brokers Kafka. Il contient les paramètres pour la communication réseau, la configuration du stockage des logs, les réglages de performance, et les politiques de rétention. Les paramètres incluent le port d'écoute, la taille maximale des segments de log, les réglages de rétention et les paramètres pour la réplication et le partitionnement.

2. **zookeeper.properties** : ZooKeeper est utilisé pour gérer l'état du cluster Kafka. Ce fichier configure les aspects de ZooKeeper utilisés par Kafka, comme le port d'écoute de ZooKeeper, le chemin de stockage des données de ZooKeeper, et la taille maximale des logs de ZooKeeper.

3. **consumer.properties** : Ce fichier contient les paramètres de configuration pour les consommateurs Kafka utilisant l'ancienne API de consommation (hors Consumer API basée sur le nouveau client). Il inclut des configurations pour le groupe de consommation, l'identification du client, et des réglages pour le contrôle de flux et la gestion des erreurs.

4. **producer.properties** : Similaire au fichier `consumer.properties`, ce fichier configure les producteurs utilisant l'ancienne API de production. Il contient des réglages pour les buffers, la compression des données, et la gestion des erreurs.

5. **connect-standalone.properties** : Ce fichier est utilisé pour configurer le Kafka Connect en mode standalone, qui est utilisé pour exécuter des connecteurs Kafka sans un système de gestion distribuée. Il inclut des paramètres pour la gestion des tâches, le stockage des configurations, et les options pour les offsets des connecteurs.

6. **connect-distributed.properties** : À l'inverse du mode standalone, ce fichier configure Kafka Connect pour fonctionner en mode distribué. Ce mode permet de gérer les connecteurs et les tâches de manière équilibrée sur plusieurs instances pour une meilleure fiabilité et échelle.

7. **connect-log4j.properties** : Ce fichier configure les options de logging pour Kafka Connect, utilisant log4j. Il permet de définir le niveau de log, les formats de sortie, et les destinations des logs (comme les fichiers ou la console).

8. **log4j.properties** : Configure les logs pour les brokers Kafka et d'autres composants, en utilisant log4j. Ce fichier définit les niveaux de log, les formats et les destinations des logs pour divers composants du système.

9. **tools-log4j.properties** : Spécifie les configurations de logging pour les outils et utilitaires de Kafka, tels que les scripts fournis dans le répertoire `bin/`.

10. **kraft/server.properties** : Pour les déploiements qui utilisent le mode KRaft de Kafka (sans ZooKeeper), ce fichier configure le broker pour fonctionner en mode KRaft, y compris la gestion du quorum, les paramètres de stockage, et les options réseau.

