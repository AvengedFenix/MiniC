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
int = ("int")
float = ("float")
double = ("double")
while = ("while")
for = ("for")
if = ("if")


//COMBINACIONES
variables = {letters}+|{letters}+{numbers}+|{numbers}+
numberType = {int} | {float} | {double}
whiteSpace = (\s | "")

findWhile = while{whiteSpace}+("("){whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{variables}+{whiteSpace}+(")"){whiteSpace}+("{")
findFor = for{whiteSpace}+("("){int}\s
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            {whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            //{whiteSpace}+{variables}+{counters}{whiteSpace}+(")"){whiteSpace}+("{")
            {whiteSpace}+({variables}+{counters} | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+ | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{variables}+{numbers}+)
            {whiteSpace}+(")"){whiteSpace}+("{")

commentary = {commentary_start}+ (.*?)+ {commentary_end}
variables = {letters}+|{letters}+{numbers}+|{numbers}+
findWhile = while("("){variables}+{relationalOperators}{variables}+(")")("{")
findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")


%%
<YYINITIAL> {

    {findWhile} {
        System.out.println("While expression found: " + yytext());
    }
    
    {findFor} {
        System.out.println("For found: " + yytext());
    }
    
    {commentary} {
        System.out.println("Comentario encontrado: " + yytext());

    }
    {findIf} {
        System.out.println("if was found: " + yytext());
    }

    {spaces} {    }

    . {    }

}