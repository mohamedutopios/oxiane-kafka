# Les opérations : 

## Ouvrir 2 terminaux : Un pour ksql et l'autre pour kafka

***Terminal pour kafka :***

 - 1 : docker exec -it broker /bin/bash
 - 2 : cd /usr/var
 - 3 : kafka-topics --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic USERS

 
***Terminal pour ksql :***

 - 1 : docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088

### Get started - KSQL Command Line

At UNIX prompt
```
kafka-console-producer --broker-list localhost:9092 --topic USERS << EOF
Alice,US
Bob,GB
Carol,AU
Dan,US
EOF
```

At KSQL prompt
```
show topics;

-- this will show nothing
print 'USERS';

print 'USERS' from beginning;

print 'USERS' from beginning limit 2;

print 'USERS' from beginning interval 2 limit 2 ;

```

1. **`SHOW TOPICS;`** ou **`list topics;`** : Cette commande liste tous les sujets Kafka disponibles dans votre cluster. Cela inclut à la fois les sujets que ksqlDB utilise en interne et les sujets externes auxquels vous pourriez être intéressé pour la création de flux ou de tables.

3. **`PRINT <topic_name> [FROM BEGINNING];`** : Cette commande vous permet de voir les messages dans un sujet Kafka. Vous pouvez également ajouter `FROM BEGINNING` pour lire tous les messages du sujet depuis le début, sinon elle affichera seulement les nouveaux messages à partir du moment où la commande est exécutée.

En plus de ces commandes spécifiques aux sujets, il existe d'autres commandes administratives et de métadonnées dans ksqlDB :

- **`SHOW QUERIES;`** : Affiche toutes les requêtes en cours d'exécution sur le serveur ksqlDB.
- **`SHOW STREAMS;`** : Liste tous les flux définis dans ksqlDB.
- **`SHOW TABLES;`** : Liste toutes les tables définies dans ksqlDB.
- **`SHOW FUNCTIONS;`** : Liste toutes les fonctions disponibles dans ksqlDB.
- **`SHOW PROPERTIES;`** : Affiche les propriétés de configuration actuelles de la session ksqlDB.

KSQL, maintenant connu sous le nom de ksqlDB, est un langage de requête de streaming pour Apache Kafka. Il vous permet de traiter et d'interroger des données en temps réel. Voici quelques types de commandes que vous pouvez utiliser avec ksqlDB :

1. **Créer des flux et des tables** :
   - `CREATE STREAM` : Crée un flux pour gérer des données qui sont en mouvement continu.
   - `CREATE TABLE` : Crée une table pour gérer des données qui sont considérées comme étant dans un état plus ou moins stable.

2. **Requêtes de sélection** :
   - `SELECT` : Utilisé pour interroger des flux et des tables, souvent avec des fonctions de fenêtrage et d'agrégation.

3. **Insertion de données** :
   - `INSERT INTO` : Permet d'insérer des données dans un flux ou une table existante.

4. **Mise à jour et suppression** :
   - `CREATE OR REPLACE` : Permet de remplacer un flux ou une table existant(e) par une nouvelle définition sans supprimer l'objet original.

5. **Opérations sur les jointures** :
   - Jointures entre flux (`STREAM-STREAM JOIN`), flux et table (`STREAM-TABLE JOIN`), ou entre tables (`TABLE-TABLE JOIN`).

6. **Fenêtrage** :
   - Des fonctions de fenêtrage permettent de diviser les données en fenêtres de temps pour l'agrégation, par exemple, `WINDOW TUMBLING` (fenêtre glissante) et `WINDOW HOPPING` (fenêtre sautante).

7. **Gestion des topologies de traitement** :
   - `EXPLAIN` : Fournit des informations sur la manière dont une requête est exécutée et sur la planification de son exécution.

8. **Termination de requêtes** :
   - `TERMINATE` : Permet de stopper une requête en cours.

9. **Suppression de flux et de tables** :
   - `DROP STREAM` et `DROP TABLE` : Pour supprimer un flux ou une table existant(e).

10. **Déclarations de types personnalisés** :
    - `CREATE TYPE` : Permet de définir un nouveau type de données structuré.

Ces commandes offrent une gamme complète d'opérations pour le traitement en temps réel des flux de données dans des applications basées sur Kafka, permettant ainsi aux développeurs et aux analystes de manipuler et d'analyser les flux de données de manière interactive et en temps réel.