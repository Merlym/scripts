#!/bin/bash
# Port Knocking
# Desec
#################################
if [ "$1" == "" ]
then
echo "Hping - PortKnocking"
echo "Modo de uso: ./script IP"
else
for port in {13,37,30000,3000}; 
do
hping3 -p $port -S -c 1 $1 2>/dev/null;
done
echo "+++ Resposta Desativando Malware +++"
echo ""
curl "$1:1337"
fi
