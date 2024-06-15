# Application Météo
## Description
Cette application de météo permet aux utilisateurs de rechercher des prévisions météorologiques en entrant le nom d'une ville. L'utilisateur peut également choisir une plage de dates pour obtenir les prévisions horaires sur plusieurs jours. Les données sont obtenues en utilisant l'API Open-Meteo et affichées de manière détaillée pour chaque heure.

## Fonctionnalités
Recherche de villes pour obtenir les prévisions météorologiques.
Sélection de plage de dates pour obtenir les prévisions sur plusieurs jours.
Affichage des détails météorologiques pour chaque heure incluant la température, la température ressentie, la pluie, la visibilité, la direction du vent et les rafales de vent.
## Dépendances
### flutter
Utilisé comme cadre principal pour construire l'application.

### http
Ajouté pour effectuer des requêtes HTTP vers l'API Open-Meteo.

### intl
Ajouté pour formater les dates dans un format lisible (yyyy-MM-dd) nécessaire pour les requêtes d'API et l'affichage des dates sélectionnées.


## Installation
### Clonez ce dépôt:
``` git clone https://github.com/Funloi2/Flutter-Weather-App ```
### Accédez au répertoire du projet:
``` cd Flutter-Weather-App ```
### Installez les dépendances:
``` flutter pub get ```
### Exécutez l'application:
``` flutter run ```
### Utilisation
1. Entrez le nom d'une ville dans la barre de recherche.
2. Appuyez sur le bouton de sélection de plage de dates pour choisir une date de début et de fin.
3. Appuyez sur Entrée pour rechercher les prévisions météorologiques.
4. Les prévisions horaires pour la plage de dates sélectionnée s'affichent.
5. Cliquez sur une carte d'heure spécifique pour voir plus de détails.