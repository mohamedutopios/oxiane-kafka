Pour installer Docker et Docker Compose dans un environnement WSL (Windows Subsystem for Linux), vous devez d'abord vous assurer que WSL est activé et configuré sur votre système Windows. Voici les étapes pour installer Docker et Docker Compose dans WSL :

### Étape 1 : Prérequis

Assurez-vous que vous avez WSL activé sur votre machine Windows. Vous pouvez vérifier cela en ouvrant PowerShell et en exécutant :

```bash
wsl --list --verbose
```

Si WSL n'est pas installé, vous pouvez l'installer en suivant les instructions sur le site officiel de Microsoft.

### Étape 2 : Installation de Docker sur WSL

1. **Ouvrez votre distribution WSL** de votre choix (par exemple, Ubuntu).

2. **Mettez à jour les paquets** de votre distribution :

   ```bash
   sudo apt update
   sudo apt upgrade
   ```

3. **Installez les paquets requis** pour permettre à `apt` d'utiliser un dépôt via HTTPS :

   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common
   ```

4. **Ajoutez la clé GPG officielle de Docker** :

   ```bash
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```

5. **Ajoutez le dépôt Docker à vos sources APT** :

   ```bash
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   ```

6. **Installez Docker CE** (Community Edition) :

   ```bash
   sudo apt update
   sudo apt install docker-ce
   ```

7. **Gérez les permissions** pour exécuter Docker sans `sudo` (optionnel) :

   ```bash
   sudo usermod -aG docker $USER
   ```

   Vous devrez déconnecter et reconnecter votre session utilisateur pour que ces changements prennent effet.

8. **Testez l'installation de Docker** :

   ```bash
   docker run hello-world
   ```

### Étape 3 : Installation de Docker Compose

1. **Téléchargez la dernière version de Docker Compose** :

   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

   Remplacez `v2.10.2` par la dernière version disponible de Docker Compose.

2. **Rendez le binaire exécutable** :

   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Vérifiez l'installation** :

   ```bash
   docker-compose --version
   ```

### Étape 4 : Configuration de Docker pour s'exécuter automatiquement au démarrage de WSL

Pour que Docker s'exécute automatiquement à chaque démarrage de WSL, vous pouvez ajouter une commande à votre fichier `.bashrc` ou `.profile` :

```bash
echo "sudo service docker start" >> ~/.bashrc
```

Après ces étapes, vous devriez avoir Docker et Docker Compose entièrement opérationnels sur votre environnement WSL. Vous pouvez commencer à utiliser Docker pour déployer des conteneurs et Docker Compose pour gérer des applications multi-conteneurs.