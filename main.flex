%%
%unicode
%class Lexar
%line
%column
%int
%standalone
%states line_comment,comment
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
new_line = [\n]+

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
            {whiteSpace}+({variables}+{counters} | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+ | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{variables}+{numbers}+)
            {whiteSpace}+(")"){whiteSpace}+("{")

commentary = {commentary_start}+ (.*?) + {commentary_end}
variables = {letters}+|{letters}+{numbers}+|{numbers}+
findWhile = while("("){variables}+{relationalOperators}{variables}+(")")("{")
findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")


%%
<YYINITIAL> {

    {findWhile} {
        System.out.print("While expression found: " + yytext());
    }
    
    {findFor} {
        System.out.print("For found: " + yytext());
    }


    {line_commentary} {
        System.out.print("Comentario en linea encontrado"); yybegin(line_comment);
    }

    {commentary} {
        System.out.print("Comentario encontrado"); yybegin(comment);

    }

    {findIf} {
        System.out.print("if was found: " + yytext());
    }

    <line_comment>{
        {new_line} {System.out.println("\n"); yybegin(1);}
        . {System.out.print(yytext());}
    }
    <comment>{
        {commentary_end} {System.out.println("\n"); yybegin(1);}
        . {System.out.print(yytext());}
    }

    {spaces} {    }

    . {    }

}