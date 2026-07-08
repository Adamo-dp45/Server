### Make - Permet de gérer la recompilation de choses et automatiser les tâches

.SILENT: # Si on veut qu'il ne retourne aucune commande dans le terminal, si on ne met pas de valeur il applique sur tous

.PHONY: install test server help cache-clear proxy watch ## Pour indiquer qu'une cible est fausse, signifie que ça ne correspond pas à un dossier qu'on veut créer ou un résultat de build, sinon il va éssayer tous le temps de le lancer

# -- Quand on tape `make` sans rien mettre il va lancer la première commande
.DEFAULT_GOAL= help ## Indiquer la cible à lancer par défaut

## -- Variable
PORT=8000 ## On peut redéfinir la variable lors de la commande `make server PORT=3000`
	- On n'a d'autres manière d'assigner les variables
		- PORT:="" : Pour interprêter les sous variables qui sont à l'intérieur
		- PORT?=8000 : Utiliser le port 8000 si ce n'est pas 
HOST=127.0.0.1
PHP=php
CURRENT_DIR=$(shell pwd) # Permet d'avoir le dossier courant

## -- Condition
ifdef VERSION # Si l'utilisateur tape `make test VERSION=8.4`
	PHP=docker run .. php:$(VERSION)
endif

## -- Couleur dans le terminal
COM_COLOR=\033[0;34m
OBJ_COLOR=\033[0;36m
OK_COLOR=\033[0;32m
ERROR_COLOR=\033[0;31m
WARN_COLOR=\033[0;33m
NO_COLOR=\033[m

include .env # On peut inclure un fichier qui définirai les variables

## -- Syntaxe
cible: prerequis prerequis # Preréquis pour obtenir la cible, les fichiers qui vont être nécéssaire pour obtenir la cible
	script qui permet de générer la cible

vendor: composer.json # Pour générer le dossier vendor on a besoin du fichier composer.json, si composer.json change il relance la commande
	@composer install -- Si on veut pas qu'il affiche la commande qu'il est entrain de taper dans le terminal @

composer.lock: composer.json # Si le composer.json est plus récent que le composer.lock il met à jour
	composer update

install: vendor composer.lock # On peut créer de fausse commande, pour indiquer que la cible est fausse dans .PHONY dès que quelque chose doit être lancer en permanence, sinon si dans notre projet il y'a un fichier qui s'appelle install il ne fera rien

## -- Alias
test: install # test sans (s) sinon il va me bloqué si j'ai un dossier tests dans mon projet
	$(PHP) ./vendor/bin/phpunit

server: install
	echo -e "Lançement du $(OK_COLOR)serveur web php$(NO_COLOR)" -- Le -e c'est pour que la couleur ne soit pas échappé
	ENV=dev php -S localhost:$(PORT) -t public -d display_errors=1

proxy: # Pour actualiser la page
	browser-sync start --port 3000 --proxy $(HOST):$(PORT) --files 'src/**/*.php' --files 'src/**/*.twig'

watch: server proxy # On peut définir le nombre de job à utilisé en même temps, dans ce cas parceque si je lance la commande watch il va s'arrêté à l'éxécution du serveur de php mais si on tape la commande `make watch -j2` lance les 2 à la fois

cache-clear:
	rm -rf ./tmp

help: # Une commande @grep -E.. existe sur internet et permet d'afficher les commentaires en console