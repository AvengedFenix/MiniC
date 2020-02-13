%%
%unicode
%class Lexar
%line
%column
%int
%standalone
%states line_comment,comment,includes, whileLoops

/*%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
*/

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
hash = "#"
standard_libraries = ("assert.h"|"complex.h"|"ctype.h"|"errno.h"|"float.h"|"inttypes.h"|"iso646.h"|"limits.h"|"locale.h"|"math.h"|"setjmp.h"| "signal.h" | "stdalign.h" | "stdarg.h"| "stdatomic.h"| "stdbool.h" |"stddef.h"| "stdint.h" | "stdio.h" | "stdlib.h"|"stdnoreturn.h"|"string.h"|"tgmath.h"|"threads.h" | "time.h" | "uchar.h" | "wchar.h" | "wctype.h" ) 
start_system_include = "<"
end_system_include = ">"
new_line= [\n]+

//PALABRAS RESERVADAS
include = ("include")
closing = "}"

//Data Types
int = ("int")
long = ("long")
double = ("double")
char = ("char")
bool = ("bool")
void = ("void")
signed = "signed" 
short = "short" 
unsigned = "unsigned" 
long = "long"
float = "float"
string = ["(.*?)"]

//Decisiones
while = ("while")
for = ("for")
if = ("if")
return = ("return")

//COMBINACIONES
anyChar = ({letters}*{numbers}*)*
variables = {letters}+|{letters}+{numbers}+|{numbers}+
numberType = {int} | {float} | {double}
whiteSpace = (\s | "")
system_header = {start_system_include}+{standard_libraries}+{end_system_include}
program_header = (\")+{anyChar}+(\")
varTypes = {int} | {double} | {float} | {long} | {char} | {bool}
numTypes = {int} | {double} | {float}
nonNumTypes = {char} | {bool}
functions = {void} | {int} | {double} | {float} | {long} | {char} | {bool}

commentary = {commentary_start}+ (.*?)+ {commentary_end}

findMain = {int}\s{whiteSpace}+("main"){whiteSpace}+("("){whiteSpace}+(")"){whiteSpace}+("{")

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
findInclude = {hash}{include}{whiteSpace}+({system_header}|{program_header})

//Esto no está funcionando
findDeclarations = (/*({signed} | {unsigned})?\s({short} | {long})?\s{numTypes} |*/ {varTypes})\s{whiteSpace}+(variables)+{whiteSpace}+(";")

nonNumDeclareAssign = ({char}\s{variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+("\""){whiteSpace}+{anyChar}{whiteSpace}+("\"") 
                        | {bool}\s{variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+(true | false)){whiteSpace}+(";")


numDeclareAssign = ({signed} | {unsigned})?\s({short} | {long})?\s
                    {whiteSpace}{numTypes}\s{variables}+{whiteSpace}+{asignationOperators}
                    {whiteSpace}+{numbers}+{whiteSpace}+(";")

%%

<YYINITIAL> {

    {findInclude} {
        System.out.println(" import found:\n" + yytext());
    }

    {findMain} {
        System.out.println("Main: " + yytext() + "\n");
        //yybegin(rules);
    }


    //<rules>{

    {findDeclarations} {
        System.out.println("Declaration: " + yytext() + "\n");
    }

    {nonNumDeclareAssign} {
        System.out.println("Bool or char Asignation and declaration: " + yytext() + "\n");
    }

    {numDeclareAssign} {
        System.out.println("Number declaration found: " + yytext() + "\n");
    }

    {findWhile} {
        System.out.println("While found: " + yytext() + "\n");
        yybegin(whileLoops);
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
        {new_line} {System.out.print(yytext()+"\n"); yybegin(1);
        }
        . {  } 
        //. {System.out.print(yytext());}
        {spaces} {    }
    }
    <comment>{
        {commentary_end} {System.out.print(yytext()+"\n"); yybegin(1);}
        . {  } 
        //. {System.out.print(yytext());}
        {spaces} {    }

    }

//}

    <whileLoops> {
        {closing} {
            System.out.println("While end found at line: " + yyline);
            yybegin(YYINITIAL);
        }
        
        {spaces} { }

        . { }
    }

    {spaces} {    }

    . {    }

}