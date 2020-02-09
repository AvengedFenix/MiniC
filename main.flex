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

//PALABRAS RESERVADAS
while = ("while")


variables = {letters}+|{letters}+{numbers}+|{numbers}+

findWhile = while("("){variables}+{relationalOperators}{variables}+(")")("{")

%%
<YYINITIAL> {

    {findWhile} {
        System.out.println("While expression found: " + yytext());
    }

    {spaces} {    }

    . {    }

}