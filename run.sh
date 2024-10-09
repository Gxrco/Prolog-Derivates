#!/bin/bash

# Ruta al archivo Prolog
PROLOG_FILE="main.pl"

# Verifica si el archivo Prolog existe
if [ ! -f "$PROLOG_FILE" ]; then
    echo "El archivo $PROLOG_FILE no existe en el directorio actual."
    exit 1
fi

# Ejecutar SWI-Prolog con las consultas en modo no interactivo
swipl -q -s "$PROLOG_FILE" -g run_examples -t halt
