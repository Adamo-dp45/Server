### Issue

- Pour mettre `Debian` en français
    > On installe les fichiers de langue française
        > sudo apt update && sudo apt install locales
    > !! configure les locales
        > sudo dpkg-reconfigure locales
    > !! sur l'interface de texte
        > On coche `fr_FR.UTF-8 UTF-8` utiliser la barre espace pour cocher et appuie sur `Entrée`
        > !! choisi `fr_FR.UTF-8` comme locale par défaut
        > !! applique immédiatement la langue
            > export LANG=fr_FR.UTF-8
    > Pour que ce soit permanent pour tous les utilisateurs on ajoute dans `/etc/default/locale`
        > LANG="fr_FR.UTF-8"
            > LANGUAGE="fr_FR:fr"
    > On appuie sur `Ctrl+O` pour enregistrer, puis `Ctrl+X` pour quitter et on redémarre le serveur
        > sudo reboot

- !! clavier `AZERTY` sur `Debian`
    > On passe en root `su -`
    > !! installe les fichiers de langue française, déjà fait
    > !! configure le clavier en AZERTY
    > `localectl` permet de vérifier
    > dpkg-reconfigure keyboard-configuration
        > On choisi un clavier de type `Generic 105-key (Intl) PC`
        > !! la langue `French`, l'agencement `French` et accpeté les options par défaut
    > !! applique les modifications et reboot
        > service keyboard-setup restart