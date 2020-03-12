package FlexAndCup;
import java_cup.runtime.Symbol;
%%
%unicode
%class Lexar
%line
%column
%int
%type java_cup.runtime.Symbol
%standalone
%states line_comment,comment,includes, whileLoops
%cup
%full


%{   
    /* To create a new java_cup.runtime.Symbol with information about
        the current token, the token will have no value in this
       case. */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Also creates a new java_cup.runtime.Symbol with information
       about the current token, but this object has a value. */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

//OPERADORES
//relationalOperators = ("!=" | "==" | "<" | "<=" | ">" | ">=")
different = "!="
comparisson = "=="
lesserThan = "<"
lesserEqualThan = "<="
greaterThan = ">"
greaterEqualThan = ">="


logicalOperators = ("&&" | "||" | "!")
and = "&&"
or = "||"

//Preguntarle al ingeniero si estos pueden ir en una sola variable
arithmeticOperators = ("+" | "-" | "*" | "/")
plus = "+"
minus = "-"
//Asterisk ya esta
slash = "/"

asignationOperators = ("=")
asignationOperators = ("=" | "+=" | "-=" | "*=" | "/=")

equal = "="

//counters = ("++" | "--")
plusPlus = "++"
minusMinus = "--" 
plusEquals = "+="
minusEquals = "-="
divideEquals = "/="
timesEquals = "*="

//MISC
letters = [a-z A-Z]
digits =  [0-9]
spaces = [\n\r\t]+ 

comma = ","
colon = ":"
semicolon =";"
period = "."
apostrophe = "\'"
exclamation = "!"
question = "?"
underscore = "_"
open_brace = "{"
close_brace= "}"
open_bracket= "["
close_bracket="]"
open_parenthesis = "("
close_parenthesis = ")"
at = "@"
hash = "#"
percent= "%"
hat = "^"
ampersand = "&"
asterisk = "*"
quote = "\""



line_commentary= "//" {whiteSpace}+{anyChar}
commentary_start="/*" {whiteSpace}+{anyChar}
commentary_end = "*/"
hash = "#"
//standard_libraries = ("assert.h"|"complex.h"|"ctype.h"|"errno.h"|"float.h"|"inttypes.h"|"iso646.h"|"limits.h"|"locale.h"|"math.h"|"setjmp.h"| "signal.h" | "stdalign.h" | "stdarg.h"| "stdatomic.h"| "stdbool.h" |"stddef.h"| "stdint.h" | "stdio.h" | "stdlib.h"|"stdnoreturn.h"|"string.h"|"tgmath.h"|"threads.h" | "time.h" | "uchar.h" | "wchar.h" | "wctype.h" ) 
//start_system_include = "<"
//end_system_include = ">"
new_line= [\n]+

//PALABRAS RESERVADAS
true = "true"
false = "false"
include = "include"
closing = "}"
pragma = "pragma"
struct = "struct"
union = "union"
main = "main"
for = "for"
while = "while"
return = "return"
null = "NULL"


//Data Types
int = "int"
long = "long"
double = "double"
char = "char"
bool = "bool"
void = "void"
signed = "signed" 
short = "short" 
long ="long"
unsigned = "unsigned" 
long = "long"
float = "float"
string = "string"
scanf = "scanf"
printf = "printf"


//Decisiones
while = "while"
for = "for"
if = "if"
return = "return"

//COMBINACIONES
anyChar = ({letters}{digits})*
variables = {letters}+|{letters}+{digits}+|{digits}+
numberType = {int} | {float} | {double}
whiteSpace = (\s | "")
identifier = {letters}+ ({letters}|{digits})*

system_header = {start_system_include}+{standard_libraries}+{end_system_include}
program_header = (\")+{anyChar}+(\")
varTypes = {int} | {double} | {float} | {long} | {char} | {bool} 
numTypes = {int} | {double} | {float}
nonNumTypes = {char} | {bool}
functions = {void} | {int} | {double} | {float} | {long} | {char} | {bool}
pointer = {varTypes}({spaces}|{whiteSpace}){asterisk}{identifier}
pointer_reference = {ampersand}{identifier}
commentary = {commentary_start}+ (.*?)+ {commentary_end}
str = {quote} [^\"\'\`]+ {quote}
strs = {quote}{anyChar}{quote}


//findMain = {int}\s{whiteSpace}+("main"){whiteSpace}+("("){whiteSpace}+(")"){whiteSpace}+("{")

//findWhile = while{whiteSpace}+("("){whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{variables}+{whiteSpace}+(")"){whiteSpace}+("{")

/*findFor = for{whiteSpace}+("("){varTypes}\s
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{digits}+{whiteSpace}+(";")
            {whiteSpace}+{variables}+{whiteSpace}+{relationalOperators}{whiteSpace}+{digits}+{whiteSpace}+(";")
            {whiteSpace}+({variables}+{counters} | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{digits}+ | 
            {variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+{variables}+{digits}+)
            {whiteSpace}+(")"){whiteSpace}+("{")
*/

findIf = if("("){variables}+{relationalOperators}{variables}+(")")("{")
findStruct = {struct}{spaces}{anyChar}{spaces}+("{")
findFunctions = {functions}\s{variables}+{whiteSpace}+
                    ("("){whiteSpace}+({varTypes}\s {variables}+ | {void} | "")
                    {whiteSpace}+(")"){whiteSpace}+("{")
findInclude = {hash}{include}{whiteSpace}+({system_header}|{program_header})

//Esto no está funcionando
findDeclarations = (({signed} | {unsigned})?\s({short} | {long})?\s{numTypes} | {varTypes})\s{whiteSpace}+(variables)+{whiteSpace}+(";")

nonNumDeclareAssign = ({char}\s{variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+("\""){whiteSpace}+{anyChar}{whiteSpace}+("\"") 
                        | {bool}\s{variables}+{whiteSpace}+{asignationOperators}{whiteSpace}+(true | false)){whiteSpace}+(";")


numDeclareAssign = ({signed} | {unsigned})?\s({short} | {long})?\s
                    {whiteSpace}{numTypes}\s{variables}+{whiteSpace}+{asignationOperators}
                    {whiteSpace}+{digits}+{whiteSpace}+(";")

%%

<YYINITIAL> {

    //Queriendolo hacer con expresiones / De la manera antigua

/*
    {relationalOperators} {
        System.out.println("Relational operator found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");

    }

    {findInclude} {
        System.out.print("import found:\n" + yytext() + " => at (" +yyline + ","+ yycolumn+")");
    }

    {findMain} {
        System.out.println("Main: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")");
        //yybegin(rules);
    }

    {findStruct} {
        System.out.print(" Struct found:\n" + yytext()  + " => at (" +yyline + ","+ yycolumn+")");
    }

    //<rules>{
    {findDeclarations} {
        System.out.println("Declaration: " + yytext() + "\n"  + " => at (" +yyline + ","+ yycolumn+")");
    }

    {findWhile} {
        System.out.println("While found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        yybegin(whileLoops);
    }

    {findFor} {
        System.out.println("For found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
    }

    {findIf} {
        System.out.println("if was found:\n" + yytext()  + " => at (" +yyline + ","+ yycolumn+")");
    }

    {findFunctions} {
        System.out.println("Function found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
    }

    {nonNumDeclareAssign} {
        System.out.println("Bool or char Asignation and declaration: " + yytext() +  " => at (" +yyline + ","+ yycolumn+")");
    }

    {numDeclareAssign} {
        System.out.println("Number declaration found: " + yytext()  + " => at (" +yyline + ","+ yycolumn + ")" );
    }

    {arithmeticOperators} {
        System.out.println("Aritmethic operator found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");

    }
    
    {counters} {
        System.out.println("Increment or decrement found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");

    }
    
    {asignationOperators} {
        System.out.println("Assignation operator found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
    }
*/
    
    
    {commentary} {
        System.out.print("Comentario encontrado: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" + "\n");
        return new Symbol(sym.commentary,yyline,yycolumn,yytext());

    }

    {line_commentary} {
        System.out.print("Comentario en linea encontrado:"  + " => at (" +yyline + ","+ yycolumn+")" +yytext() );
        yybegin(line_comment);
                return new Symbol(sym.line_commentary,yyline,yycolumn,yytext());

    }

    {commentary_start} {
        System.out.print("Comentario encontrado: \n"+ yytext()); yybegin(comment);
                return new Symbol(sym.commentary_start,yyline,yycolumn,yytext());

    } 

    //-----------------------------------------------------------------------------------------------------------------------
    //De la nueva manera / Encontrando cada token

    {colon} {
        System.out.println("colon symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.colon,yyline,yycolumn,yytext());


    }
    {comma} {
        System.out.println("comma symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.comma,yyline,yycolumn,yytext());

    }
    {semicolon} {
        System.out.println("semicolon symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.SEMICOLON);
        return new Symbol(sym.semicolon,yyline,yycolumn,yytext());


    }
    {comma} {
        System.out.println("comma symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.comma,yyline,yycolumn,yytext());

    }
    {period} {
        System.out.println("period symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.period,yyline,yycolumn,yytext());
    }
    {apostrophe} {
        System.out.println("apostrophe symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.apostrophe,yyline,yycolumn,yytext());
    }
    {exclamation} {
        System.out.println("exclamation symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.exclamation,yyline,yycolumn,yytext());
    }

    {question} {
        System.out.println("question symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.question,yyline,yycolumn,yytext());
    }

    {underscore} {
        System.out.println("underscore symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.underscore,yyline,yycolumn,yytext());
    }

    {open_brace} {
        System.out.println("opening brace symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.OPEN_BRACE);
        return new Symbol(sym.open_brace,yyline,yycolumn,yytext());
    }

    {close_brace} {
        System.out.println("closing brace symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.CLOSE_BRACE);
        return new Symbol(sym.close_brace,yyline,yycolumn,yytext());
    }

    {open_bracket} {
        System.out.println("opening bracket symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.OPEN_BRACKET);
        return new Symbol(sym.open_bracket,yyline,yycolumn,yytext());
    }

    {close_bracket} {
        System.out.println("closing bracket symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.CLOSE_BRACKET);
        return new Symbol(sym.close_bracket,yyline,yycolumn,yytext());
    }

    {open_parenthesis} {
        System.out.println("opening parenthesis symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
            return symbol(sym.OPEN_PARENTHESIS);
        return new Symbol(sym.open_parenthesis,yyline,yycolumn,yytext());
    }

    {close_parenthesis} {
        System.out.println("closing parenthesis symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return symbol(sym.CLOSE_PARENTHESIS);
        return new Symbol(sym.close_parenthesis,yyline,yycolumn,yytext());
    }

    {at} {
        System.out.println("at (@) symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.at,yyline,yycolumn,yytext());
    }
    {hash} {
        System.out.println("hash symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.hash,yyline,yycolumn,yytext());
    }
    {percent} {
        System.out.println("percent symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.percent,yyline,yycolumn,yytext());
    }
    {hat} {
        System.out.println("hat symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.hat,yyline,yycolumn,yytext());
    }
    {ampersand} {
        System.out.println("ampersand symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.ampersand,yyline,yycolumn,yytext());
    }

    //Probablemente para aritmetica
    {asterisk} {
        System.out.println("asterisk symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.asterisk,yyline,yycolumn,yytext());
    }

    {slash} {
        System.out.println("slash symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.asterisk,yyline,yycolumn,yytext());

    }

    {plusPlus} {
        System.out.println("plus plus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.plusPlus,yyline,yycolumn,yytext());
    }

    {minusMinus} {
        System.out.println("minus minus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.minusMinus,yyline,yycolumn,yytext());

    }

    {plus} {
        System.out.println("plus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.plus,yyline,yycolumn,yytext());
    }

    {minus} {
        System.out.println("minus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.minus,yyline,yycolumn,yytext());
    }

    {equal} {
        System.out.println("equal symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.equal,yyline,yycolumn,yytext());
    }

    

    {while} {
        System.out.println("while found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.WHILE);
        return new Symbol(sym.while,yyline,yycolumn,yytext());
    }
    

    {for} {
        System.out.println("For found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.FOR);
        return new Symbol(sym.for,yyline,yycolumn,yytext());
    }

    {if} {
        System.out.println("if found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.IF);
        return new Symbol(sym.if,yyline,yycolumn,yytext());

    }

    {int} {
        System.out.println("int found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.INT);
        return new Symbol(sym.int,yyline,yycolumn,yytext());
    }

    {return} {
        System.out.println("return found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.RETURN);
        return new Symbol(sym.return,yyline,yycolumn,yytext());
    }

    {long} {
        System.out.println("long found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.long,yyline,yycolumn,yytext());
    
    }

    {double} {
        System.out.println("double found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.double,yyline,yycolumn,yytext());
    }

    {char} {
        System.out.println("char found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.CHAR);
        return new Symbol(sym.char,yyline,yycolumn,yytext());
    }

    {bool} {
        System.out.println("bool found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.BOOL);
        return new Symbol(sym.bool,yyline,yycolumn,yytext());
    }

    {void} {
        System.out.println("void found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.void,yyline,yycolumn,yytext());
    }

    {signed} {
        System.out.println("signed found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.signed,yyline,yycolumn,yytext());

    }

    {unsigned} {
        System.out.println("unsigned found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.unsigned,yyline,yycolumn,yytext());

    }

    {short} {
        System.out.println("short found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.short,yyline,yycolumn,yytext());
    }

    {long} {
        System.out.println("long found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.long,yyline,yycolumn,yytext());
    }

    {float} {
        System.out.println("float found: " + yytext()  + " => at (" + yyline + "," + yycolumn + ")" );
        return new Symbol(sym.float,yyline,yycolumn,yytext());
    }

    {string} {
        System.out.println("string found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.string,yyline,yycolumn,yytext());

    }

    {null} {
        System.out.println("NULL found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
       // return symbol(sym.NULL);
        return new Symbol(sym.null,yyline,yycolumn,yytext());
    }

    {and} {
        System.out.println("and found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.AND);
        return new Symbol(sym.and,yyline,yycolumn,yytext());
    }

    {or} {
        System.out.println("or found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.OR);
        return new Symbol(sym.or,yyline,yycolumn,yytext());
    }

    {true} {
        System.out.println("true found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.TRUE);
        return new Symbol(sym.true,yyline,yycolumn,yytext());
    }

    {false} {
        System.out.println("false found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.FALSE);
        return new Symbol(sym.false,yyline,yycolumn,yytext());
    }

    {strs} {
        System.out.println("strs found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.string,yyline,yycolumn,yytext());
    }

    {pointer} {
        System.out.println("pointer found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.pointer,yyline,yycolumn,yytext());
    }
    {pointer_reference} {
        System.out.println("pointer reference found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
       // return symbol(sym.STRING);
        return new Symbol(sym.pointer_reference,yyline,yycolumn,yytext());

    }
      {scanf} {
        System.out.println("scanf found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.scanf,yyline,yycolumn,yytext());
    }

    {printf} {
        System.out.println("printf found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.printf,yyline,yycolumn,yytext());
    }

    {greaterThan} {
        System.out.println("greaterThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.greaterThan,yyline,yycolumn,yytext());
    }
    {greaterEqualThan} {
        System.out.println("greaterEqualThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.greaterEqualThan,yyline,yycolumn,yytext());
    }
    {lesserThan} {
        System.out.println("lesserThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.lesserThan,yyline,yycolumn,yytext());
    }
    {lesserEqualThan} {
        System.out.println("lesserEqualThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.lesserEqualThan,yyline,yycolumn,yytext());
    }

    {comparisson} {
        System.out.println("comparisson found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.comparisson,yyline,yycolumn,yytext());
    }
    {different} {
        System.out.println("different found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.different,yyline,yycolumn,yytext());
    }

    {plusPlus} {
        System.out.println("different found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.different,yyline,yycolumn,yytext());
    }

    {plusEquals} {
        System.out.println("plusEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.plusEquals,yyline,yycolumn,yytext());
    }

    {minusEquals} {
        System.out.println("minusEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.minusEquals,yyline,yycolumn,yytext());
    }

    {timesEquals} {
        System.out.println("timesEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.timesEquals,yyline,yycolumn,yytext());
    }

    {divideEquals} {
        System.out.println("divideEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.divideEquals,yyline,yycolumn,yytext());
    }


    <line_comment>{
        {new_line} {
            System.out.print(yytext()+"\n"); yybegin(1);
        }
        . {  } 
        {spaces} {    }
    }
    <comment>{
        {commentary_end} {System.out.print(yytext()+"\n"); yybegin(1);}
        . {  } 
        {spaces} {    }

    }

//}

    <whileLoops> {
        {closing} {
            System.out.println("While end found at line: " + " => at (" +yyline + ","+ yycolumn+")" );
            yybegin(YYINITIAL);
        }
        
        {spaces} { }
        . { }
    }

    {spaces} {    }

    . {    }

}
