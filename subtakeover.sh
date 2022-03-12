#!/bin/bash
# # vim: noai:ts=4:sw=4:expandtab
#
# script subtakeover.sh
# Luciano Domingues
# 26.11.2019
 
# atraves de uma wordlist pre-existente
# tenta descobrir via forca bruta os
# subdominios CNAME de um dominio informado
 
# versao 1.0
 
########################
## VARIAVEIS
#################
DiretorioAtual=$(pwd)
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[0;33m'
BlueF='\e[1;34m' #Biru
RESET="\033[00m" #normal
orange='\e[38;5;166m'
 
########################
## FUNCOES
#################
_Uso() {
echo -e $orange""
echo "---- [ script subtakeover.sh "
echo -e $red""
echo "Modo de Uso: `basename $0` <DOMINIO> <WORDLIST>"
echo "Exemplo: ./subtakeover.sh businesscorp.com.br wordlist.txt"
echo -e $RESET""
exit 1
}
 
_BannerInicio(){
clear
echo "[" $(date) "]"
echo "[+] Iniciando processo de forca bruta nos CNAMEs do dominio $1"
}
 
_BannerFim(){
cp tmp.$$ subtakeover.txt
echo " "
echo "Lista de dominios encontrados estao no arq subtakeover.txt"
echo "--------------------------** FIM **------------------------"
echo "[" $(date) "]"
echo " "
}
 
_WordListExiste(){
if [ ! -e $DiretorioAtual/$2 ]; then
echo "[-] wordlist informada ( $2 ) nao existe no diretorio local , abortando..."
exit 1
else
TamanhoWordList=$(wc -l $DiretorioAtual/$2|cut -d" " -f1)
echo "[+] tamanho da wordlist: $TamanhoWordList palavras"
fi
}
_MapeiaSubCNAMES(){
stat="0"
for sub in $(cat $2); do
resolve=$(host -t cname $sub.$1 ns1.businesscorp.com.br | grep "is an alias")
if [ $? -eq 0 ]; then
dns=$(echo $resolve | cut -d" " -f1)
alias=$(echo $resolve | cut -d" " -f6)
if [ $stat == "1" ]; then
echo ""
stat="0"
fi
echo "[+] Encontrado subdominio CNAME: $alias "
echo $dns " alias => " $alias
echo $dns " alias => " $alias >> tmp.$$
else
echo -n "."
stat="1"
fi
done
}
 
_ApagaArqTemporario(){
if [ -e "tmp.$$" ]; then
rm tmp.$$ &>/dev/null
fi
}
 
## == fim das Funcoes
 
 
### SCRIPT INICIA AQUI -=============
if [ $# -lt 2 ]; then
_Uso
fi
# chamada das funcoes
_BannerInicio $1 $2
_WordListExiste $1 $2
_MapeiaSubCNAMES $1 $2
_BannerFim
_ApagaArqTemporario
 
exit 0