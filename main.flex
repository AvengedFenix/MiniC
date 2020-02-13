%%
%unicode
%class Lexar
%line
%column
%int
%standalone
%states line_comment,comment,includes
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
line_commentary= "//" {whiteSpace}+{anyChar}
commentary_start="/*" {whiteSpace}+{anyChar}
commentary_end = "*/"
new_line = [\n]+
hash = "#"
standard_libraries = ("assert.h"|"complex.h"|"ctype.h"|"errno.h"|"float.h"|"inttypes.h"|"iso646.h"|"limits.h"|"locale.h"|"math.h"|"setjmp.h"| "signal.h" | "stdalign.h" | "stdarg.h"| "stdatomic.h"| "stdbool.h" |"stddef.h"| "stdint.h" | "stdio.h" | "stdlib.h"|"stdnoreturn.h"|"string.h"|"tgmath.h"|"threads.h" | "time.h" | "uchar.h" | "wchar.h" | "wctype.h" ) 
start_system_include = "<"
end_system_include = ">"

//PALABRAS RESERVADAS
include = ("#include")
int = ("int")
float = ("float")
double = ("double")
while = ("while")
for = ("for")
if = ("if")
return = ("return")

//COMBINACIONES
variables = {letters}+|{letters}+{numbers}+|{numbers}+
numberType = {int} | {float} | {double}
whiteSpace = (\s | "")
system_header = {start_system_include}+{standard_libraries}+{end_system_include}
findInclude = {include}+{spaces}+{system_header}
findWhile = while{whiteSpace}+("("){whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{variables}+{whiteSpace}+(")"){whiteSpace}+("{")

findFor = for{whiteSpace}+("("){int}\s
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            {whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{numbers}+{whiteSpace}+(";")
            {whiteSpace}+({variables}+{counters} | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{numbers}+ | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{variables}+{numbers}+)
            {whiteSpace}+(")"){whiteSpace}+("{")

//commentary = {commentary_start}+ (.*?) + {commentary_end}
anyChar =({letters}*{numbers}*)*
variables = {letters}+|{letters}+{numbers}+|{numbers}+
findWhile = while("("){variables}+{relationalOperators}{variables}+(")")("{")
findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")


%%

<YYINITIAL> {
    {findInclude} {
        System.out.println("include was found:\n" + yytext());
    }

    {findWhile} {
        System.out.print("While expression found:\n " + yytext());
    }
    
    {findFor} {
        System.out.print("For found\n: " + yytext());
    }

    {line_commentary} {
        System.out.print("Comentario en linea encontrado:\n"+yytext());
        yybegin(line_comment);
    }

    {commentary_start} {
        System.out.print("Comentario encontrado:\n"+ yytext()); yybegin(comment);
    } 

    {findIf} {
        System.out.println("if was found:\n" + yytext());
    } 
    

    <line_comment>{
        {new_line} {System.out.print(yytext()+"\n"); yybegin(1);}
        //. {  } 
        //. {System.out.print(yytext());}
        {spaces} {    }
    }
    <comment>{
        {commentary_end} {System.out.print(yytext()+"\n"); yybegin(1);}
        //. {  } 
        //. {System.out.print(yytext());}
        {spaces} {    }
    }

    {spaces} {    }

    . {    }

}