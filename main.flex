%%
%unicode
%class Lexar
%line
%column
%int
%standalone



//OPERADORES
relationalOperators = ("!=" | "==" | "<" | "<=" | ">" | ">=")
logicalOperators = ("&&" | "||" | "!")
arithmeticOperators = ("+" | "-" | "*" | "/")
asignationOperators = ("=")
counters = ("++" | "--")

//MISC
letters = [a-z A-Z]
numbers =  [0-9]
spaces = [\n\r\t]+ 
symbols = ","|";"|"."|":"|"'"|"!"|"?"|"¡"|"¿"|"_"|"{"|"}"|"["|"]"|"@"|"#"|"$"|"%"|"^"|"&"|"*" 
line_commentary= "//"
commentary_start="/*"
commentary_end = "*/"

//PALABRAS RESERVADAS

//Data Types
int = ("int")
long = ("long")
float = ("float")
double = ("double")
char = ("char")
bool = ("bool")
void = ("void")

//Decisiones
while = ("while")
for = ("for")
if = ("if")


//COMBINACIONES
anyChar = ({letters}*{numbers}*)*
variables = {letters}+|{letters}+{numbers}+|{numbers}+
numberType = {int} | {float} | {double}
whiteSpace = (\s | "")
varTypes = {int} | {double} | {float} | {long} | {char} | {bool}
functions = {void} | {int} | {double} | {float} | {long} | {char} | {bool}

commentary = {commentary_start}+ (.*?)+ {commentary_end}

findWhile = while{whiteSpace}+("("){whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{variables}+{whiteSpace}+(")"){whiteSpace}+("{")

findFor = for{whiteSpace}+("("){varTypes}\s
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            {whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            {whiteSpace}+({variables}+{counters} | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+ | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{variables}+{numbers}+)
            {whiteSpace}+(")"){whiteSpace}+("{")

findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")

findFunctions = {functions}\s{variables}+{whiteSpace}+
                    ("("){whiteSpace}+({varTypes}\s {variables}+ | {void} | "")
                    {whiteSpace}+(")"){whiteSpace}+("{")

findDeclarations = {varTypes}\s{variables}+(";")

//AREGLAR ESTO PORQUE LE PODES ASIGNAR LETRAS A UN INT O DOUBLE
declareAssign = {varTypes}\s{variables}+{whiteSpace}+{asignationOperators}
                    {whiteSpace}+({numbers}+ | ("\""){whiteSpace}+{anyChar}{whiteSpace}+("\"") | true | false){whiteSpace}+(";")



%%
<YYINITIAL> {

    {findDeclarations} {
        System.out.println("Declaration: " + yytext() + "\n");
    }

    {declareAssign} {
        System.out.println("Asignation and declaration: " + yytext() + "\n");
    }

    {findWhile} {
        System.out.println("While found: " + yytext() + "\n");

        //yybegin(metodo);
    }
    
    {findFor} {
        System.out.println("For found: " + yytext() + "\n");
    }

    {findFunctions} {
        System.out.println("Function found: " + yytext() + "\n");
    }
    
    {commentary} {
        System.out.println("Comentario encontrado: " + yytext() + "\n");

    }
    {findIf} {
        System.out.println("if was found: " + yytext() + "\n");
    }

    {spaces} {    }

    . {    }

}

/*<METODO> {
    {findIf} {
        System.out.println("Mario se la come"):
    }
    {commentary} {
        yybegin(0):
    }
}*/