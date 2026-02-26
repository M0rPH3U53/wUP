#!/bin/bash

cat <<"EOF"
  
'##:::::'##:'##::::'##:'########::
 ##:'##: ##: ##:::: ##: ##.... ##:
 ##: ##: ##: ##:::: ##: ##:::: ##:
 ##: ##: ##: ##:::: ##: ########::
 ##: ##: ##: ##:::: ##: ##.....:::
 ##: ##: ##: ##:::: ##: ##::::::::
. ###. ###::. #######:: ##::::::::
:...::...::::.......:::..:::::::::                       

by M0rPH3U53
      
EOF

# Couleur ASSCI
BLEU='\033[34m'
ROUGE='\033[0;31m'
VERT='\033[0;32m'
GRIS='\033[0;90m'
RESET='\033[0m'
BLANC='\033[1;37m'
JAUNE='\033[0;33m'

echo -ne "${BLEU}[i]${RESET} ${BLANC}Interface:${RESET} "

read interface

echo -ne "${BLEU}[i]${RESET} ${BLANC}Timeout:${RESET} "

read timeout

# Découverte réseau d'appareil UPnP
echo " "
echo -ne "🔍 ${BLANC}Scan UPnP${RESET}..."
urls=$(gssdp-discover -i ${interface} --timeout=${timeout} | grep Location: | sort -u | awk '{print $2}')
echo -e "${JAUNE}100%${RESET}"

# Verifie si la variable est vide
if [ -z "${urls}" ]; then
    echo "❌ Aucune url trouvé"
    exit 1
fi

echo " "

# Telechargement des fichiers xml
for url in ${urls}; do
   	echo "📥 ${url}"
   	wget -U "Microsoft-Windows/10.0 UPnP/1.0" "${url}" > /dev/null 2>&1
done
