#!/bin/bash
#
PATH_LOCAL="/home/dsolimando"
PATH_REMOTO="/mnt/backups/"
IP_SERVER="192.168.1.240"
NOMBRE_ARCHIVO="backup.$(date +%m%d).tar.gz"
OUTPUT_DIR="$(pwd)"
USUARIO_REMOTO="dsolimando"
if ! command -v rsync &>/dev/null; then
        echo "rsync no disponible"
else
        echo "rsync disponible en $(which rsync)"
fi

function create_tar(){
        echo "Creando tar"
        tar czf $NOMBRE_ARCHIVO --directory $PATH_LOCAL $OUTPUT_DIR
}

function push_to_server(){                                                                                                                                          echo "Mandando archivo al servidor"
        rsync --progress $OUTPUT_DIR/$NOMBRE_ARCHIVO $USUARIO_REMOTO@$IP_SERVER:/$PATH_REMOTO/$NOMBRE_ARCHIVO
}

function main(){
        create_tar
        push_to_server
}
main