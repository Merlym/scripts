#!/bin/bash
# script para gerar wordlist 
#
# VLAB 4-ATAQUES EM REDES CORPORATIVAS
# Lab ID: b17c0614f14e76e0b44bf3fcedc8d5eed56f2903
# 
# Gera wordlist com letras minúsculas e exclamação (!) com o comando
echo "[+] Aguarde final da execucao do script..."
crunch 2 2 'abcdefghijklmnopqrstuvwxyz!' -o wordlist1.txt &>/dev/null

# Gera uma wordlist menor a partir da rockyou.txt chamada rockyou-mini.txt
head --bytes 1500k /usr/share/wordlists/rockyou.txt > rock-mini.txt

# Juntando a wordlist rock-mini.txt com a wordlist1.txt
# ATENCAO: os dois arquivos devem estar no diretório corrente
echo "[+] Gerando wordlist...."
for parte1 in $(cat "rock-mini.txt")
do
   for  parte2 in $(cat "wordlist1.txt")
   do
      echo "$parte1$parte2" >> wordlist-final.txt
   done
done
echo "[+] Wordlist gerada com nome => wordlist-final.txt" 

# remove os arquivos gerados
rm rock-mini.txt
rm wordlist1.txt

exit 0
