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

//MISC
letters = [a-z A-Z]
numbers =  [0-9]
spaces = [\n\r\t]+ 
symbols = ","|";"|"."|":"|"'"|"!"|"?"|"¡"|"¿"|"_"|"{"|"}"|"["|"]"|"@"|"#"|"$"|"%"|"^"|"&"|"*" 
line_commentary= "//"
commentary_start="/*"
commentary_end = "*/"

//PALABRAS RESERVADAS
while = ("while")
for = ("for")
if = ("if")




commentary = {commentary_start}+ (.*?)+ {commentary_end}
variables = {letters}+|{letters}+{numbers}+|{numbers}+
findWhile = while("("){variables}+{relationalOperators}{variables}+(")")("{")
findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")

%%
<YYINITIAL> {

    {findWhile} {
        System.out.println("While expression found: " + yytext());
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