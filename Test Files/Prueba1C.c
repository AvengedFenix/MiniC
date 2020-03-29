
int main() {
    /*Hola este es un comentario largo*/
    int* soyUnApuntadorEntero = 2;
    char* soyUnApuntadorChar = 'a';
    int soyEntero;
    soyEntero = 10;
    char soyChar;
    soyChar = 'c';
    //Soy un comentario inline
    //printf(%c, "/soyChar");
    int* input;
    //scanf(% d, &input);
    return 0;
}
int miFuncion(int miValor) {
    if (miValor >= 500) {
        return miValor;
    } else {
        miFuncion(miValor + 50);
    }
}
