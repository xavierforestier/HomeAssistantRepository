# détecter les mises à jour upstream
- tâche planifiée
- utiliser api.github.com pour récupérer la dernière release
- vérifier l'existant de l'ebuild correspondant
- si manquant, créer un une PullRequest feature/package-version

# nouveau paquet
- quand une PR feature/xxx est créée
- copier ebuild en nouvelle version
- récupérer pyproject.toml sur (ex : https://raw.githubusercontent.com/esphome/esphome/refs/tags/2025.8.2/pyproject.toml )
- parser le type de build:
  - poetry
  - setuptools
  - hatchling
 
## setuptool
- chercher l'un de :
  - "requirement.txt",
  - pyproject.toml > dependencies = [ ... ]
  - setup.cfg > install_requires =
  - setup.py > install_requires=[ ]
- parser dépendances
- pour chaque dépendance, extraire le no de verison, et màj la version de la dep de l'ebuild avec "sed"

## poetry 
TODO

## hatchling 
TODO

## compilation
emerge l'ebuild et parser le retour
- si pas d'erreur :
  - valider PR dans master
  - appeler compilation sur toute PR ouverte
- si erreur :
  - parser la dep manquante et sa version
  - créer la PR correspondante si elle n'existe pas déjà.
