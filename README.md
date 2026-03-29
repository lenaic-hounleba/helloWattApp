# ⚡ helloWattApp - Service RPC de gestion de consommation énergétique

![RPC](https://img.shields.io/badge/RPC-rpcgen-blue)
![C](https://img.shields.io/badge/Langage-C-lightgrey)
![Architecture](https://img.shields.io/badge/Architecture-Client--Serveur-green)

Application client-serveur développée en C avec **rpcgen** (POSIX RPC), permettant à un utilisateur de gérer son compte, son logement et de suivre sa consommation énergétique à distance.

---

## 📌 Description

**helloWattApp** est un service RPC simulant une plateforme de suivi de consommation électrique, inspirée des services type Linky/EDF. Le client communique avec le serveur via des appels de procédures distantes (RPC) pour gérer son profil et consulter ses données de consommation.

Le système s'articule autour de **17 fonctions RPC** réparties en deux scénarios :

| Scénario | Fonctions |
|----------|-----------|
| 👤 Scénario 1 | Créer un compte, se connecter, modifier son mot de passe et son téléphone, saisir les caractéristiques du logement et de l'énergie, consulter et comparer la consommation mensuelle, configurer une alerte mensuelle, supprimer son compte |
| ⚡ Scénario 2 | Consulter la consommation annuelle et journalière, afficher les usages par poste, saisir le numéro PDL (compteur Linky), configurer une alerte journalière et une alerte de tension réseau, se déconnecter |

---

## 🧩 Architecture

```
┌─────────────────────────────────────┐
│         hellowatt_client.c          │  ← scénarios client (appels RPC)
└──────────────────┬──────────────────┘
                   │ appels RPC (UDP)
┌──────────────────▼──────────────────┐
│         hellowatt_server.c          │  ← implémentation des 17 fonctions
└──────────────────┬──────────────────┘
                   │ généré par rpcgen à partir de
┌──────────────────▼──────────────────┐
│            hellowatt.x              │  ← interface RPC (structs + programme)
│   hellowatt.h · hellowatt_svc.c     │
│   hellowatt_clnt.c · hellowatt_xdr.c│
└─────────────────────────────────────┘
```

---

## 📁 Structure du projet

```
projet-rpc/
├── codes/
│   ├── hellowatt.x           # interface RPC - structs et déclarations des 17 fonctions
│   ├── hellowatt.h           # généré par rpcgen
│   ├── hellowatt_svc.c       # généré par rpcgen - main du serveur
│   ├── hellowatt_clnt.c      # généré par rpcgen - stubs client
│   ├── hellowatt_xdr.c       # généré par rpcgen - filtres XDR (sérialisation)
│   ├── hellowatt_server.c    # écrit manuellement - implémentation des 17 fonctions
│   ├── hellowatt_client.c    # écrit manuellement - scénarios client
│   └── Makefile              # généré par rpcgen
├── exe-serveur.jpg           # capture d'écran de l'exécution côté serveur
├── exe-client.jpg            # capture d'écran de l'exécution côté client
├── model MCD.png             # modèle conceptuel des données
└── scenarios_hellowatt.pdf   # description des deux scénarios
```

---

## ⚙️ Stack technique

- **Langage** : C
- **Protocole** : RPC (Remote Procedure Call) via `rpcgen`
- **Transport** : UDP
- **Sérialisation** : XDR (External Data Representation)
- **OS** : Linux (Ubuntu / Lubuntu)
- **Bibliothèques** : `libtirpc`, `libnsl`

---

## 🧠 Fonctionnalités principales

### Scénario 1 - Gestion du compte et du logement
- 🔐 Création de compte et connexion avec email + mot de passe
- ✏️ Mise à jour du mot de passe et du numéro de téléphone
- 🏠 Saisie des caractéristiques du logement (adresse, surface, type, structure)
- ⚡ Saisie des sources d'énergie (chauffage, cuisson)
- 📊 Consultation de la consommation mensuelle (€, kWh, CO₂)
- 📈 Comparaison de la consommation avec la moyenne régionale
- 🔔 Configuration d'une alerte de dépense maximale par mois
- 🗑️ Suppression définitive du compte

### Scénario 2 - Suivi avancé de la consommation
- 📅 Consultation de la consommation annuelle (somme de tous les jours)
- 🗓️ Consultation de la consommation journalière
- 🔌 Répartition des usages par poste (chauffage, cuisson, éclairage, électroménager, autres)
- 🔢 Saisie du numéro PDL du compteur Linky
- 🔔 Configuration d'une alerte de dépense maximale par jour
- ⚠️ Activation/désactivation des notifications de tension réseau
- 🚪 Déconnexion sécurisée

---

## 🚀 Compilation et exécution

### Prérequis
```bash
sudo apt install libtirpc-dev libnsl-dev
```

### Générer les fichiers depuis le .x
```bash
rpcgen -a hellowatt.x
```

### Mettre à jour le Makefile
```makefile
CFLAGS += -g $(shell pkg-config --cflags libtirpc)
LDLIBS += -lnsl $(shell pkg-config --libs libtirpc)
```

### Terminal 1 - Compiler et lancer le serveur
```bash
make hellowatt_server
./hellowatt_server
```

### Terminal 2 - Compiler et lancer le client
```bash
make hellowatt_client
./hellowatt_client localhost
```

---

## 📸 Aperçu de l'exécution

### Côté serveur
![Exécution serveur](exe-serveur.jpg)

### Côté client
![Exécution client](exe-client.jpg)

---

## 👥 Équipe

Projet réalisé en binôme dans le cadre de l'UE **RIP/RPC** - Licence 3 Informatique, Université de Bretagne Occidentale, 2025-2026.

---

## 👨‍💻 Auteur 

**Lenaïc Love HOUNLEBA**

CEO & Développeur Full Stack - [ComeUp](https://comeup.com/fr/@lenaic-1)  

🔗 [github.com/lenaic-hounleba](https://github.com/lenaic-hounleba)  
📧 lovehounleba@gmail.com

---

*Projet réalisé dans le cadre de l'EC RIP/RPC - Licence 3 Informatique, Université de Bretagne Occidentale, 2025-2026.*
