#!/bin/bash
clear

for voice in `say -v '?' | awk {'printf("%s%s%s\t", $1, "_", $2)'}`; do echo "$voice"; done | grep "_en_"
echo