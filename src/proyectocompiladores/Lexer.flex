package proyectocompiladores;
import java_cup.runtime.*;


%%
%unicode
%class Lexer
%line
%column
%int
%type java_cup.runtime.Symbol
%standalone
%cup
%full

/*
%{   
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
*/

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
letters = [a-zA-Z]
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
identifier = {letters}({letters}|{digits})*

system_header = {start_system_include}+{standard_libraries}+{end_system_include}
program_header = (\")+{anyChar}+(\")
varTypes = {int} | {double} | {float} | {long} | {char} | {bool} 
numTypes = {int} | {double} | {float}
nonNumTypes = {char} | {bool}
functions = {void} | {int} | {double} | {float} | {long} | {char} | {bool}
pointer = {varTypes}({spaces}|{whiteSpace}){asterisk}{identifier}
pointer_reference = {ampersand}{identifier}
comment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
line_comment ="//" [^\r\n]* {new_line}
str = {quote} [^\"\'\`]+ {quote}
strs = {quote}{anyChar}{quote}

%%

<YYINITIAL> {

    /*{main} {
        System.out.println("MAIN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MAIN,yyline,yycolumn,yytext());
    }*/

    {comment} {
        System.out.println("Normal comment found found:\n " + yytext() + "\n => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COMMENT,yyline,yycolumn,yytext());
    }

    {line_comment} {
        System.out.println("Line comment found found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LINE_COMMENT,yyline,yycolumn,yytext());
    }

    {colon} {
        System.out.println("colon symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COLON,yyline,yycolumn,yytext());
    }

    {comma} {
        System.out.println("comma symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COMMA,yyline,yycolumn,yytext());

    }
    {semicolon} {
        System.out.println("semicolon symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.SEMICOLON);
        return new Symbol(sym.SEMICOLON,yyline,yycolumn,yytext());


    }

    {period} {
        System.out.println("period symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.PERIOD,yyline,yycolumn,yytext());
    }
    {apostrophe} {
        System.out.println("apostrophe symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.APOSTROPHE,yyline,yycolumn,yytext());
    }
    {exclamation} {
        System.out.println("exclamation symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.EXCLAMATION,yyline,yycolumn,yytext());
    }

    {question} {
        System.out.println("question symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.QUESTION,yyline,yycolumn,yytext());
    }

    {underscore} {
        System.out.println("underscore symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.UNDERSCORE,yyline,yycolumn,yytext());
    }

    {open_brace} {
        System.out.println("opening brace symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.OPEN_BRACE);
        return new Symbol(sym.OPEN_BRACE,yyline,yycolumn,yytext());
    }

    {close_brace} {
        System.out.println("closing brace symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.CLOSE_BRACE);
        return new Symbol(sym.CLOSE_BRACE,yyline,yycolumn,yytext());
    }

    {open_bracket} {
        System.out.println("opening bracket symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.OPEN_BRACKET);
        return new Symbol(sym.OPEN_BRACKET,yyline,yycolumn,yytext());
    }

    {close_bracket} {
        System.out.println("closing bracket symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.CLOSE_BRACKET);
        return new Symbol(sym.CLOSE_BRACKET,yyline,yycolumn,yytext());
    }

    {open_parenthesis} {
        System.out.println("opening parenthesis symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
            //return symbol(sym.OPEN_PARENTHESIS);
        return new Symbol(sym.OPEN_PARENTHESIS,yyline,yycolumn,yytext());
    }

    {close_parenthesis} {
        System.out.println("closing parenthesis symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        //return symbol(sym.CLOSE_PARENTHESIS);
        return new Symbol(sym.CLOSE_PARENTHESIS,yyline,yycolumn,yytext());
    }

    {at} {
        System.out.println("at (@) symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.AT,yyline,yycolumn,yytext());
    }
    {hash} {
        System.out.println("hash symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.HASH,yyline,yycolumn,yytext());
    }
    {percent} {
        System.out.println("percent symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.MOD,yyline,yycolumn,yytext());
    }
    {hat} {
        System.out.println("hat symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.HAT,yyline,yycolumn,yytext());
    }
    {ampersand} {
        System.out.println("ampersand symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.AMPERSAND,yyline,yycolumn,yytext());
    }

    {asterisk} {
        System.out.println("asterisk symbol found: " + yytext() + " => at (" + yyline +"," + yycolumn +")");
        return new Symbol(sym.TIMES,yyline,yycolumn,yytext());
    }

    {slash} {
        System.out.println("slash symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.DIVIDE,yyline,yycolumn,yytext());

    }

    {plusPlus} {
        System.out.println("plus plus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.PLUSPLUS,yyline,yycolumn,yytext());
    }

    {minusMinus} {
        System.out.println("minus minus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.MINUSMINUS,yyline,yycolumn,yytext());

    }

    {plus} {
        System.out.println("plus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.PLUS,yyline,yycolumn,yytext());
    }

    {minus} {
        System.out.println("minus symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.MINUS,yyline,yycolumn,yytext());
    }

    {equal} {
        System.out.println("equal symbol found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.EQUALS,yyline,yycolumn,yytext());
    }
    //Probablemente para aritmetica

    {while} {
        System.out.println("while found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.WHILE);
        return new Symbol(sym.WHILE,yyline,yycolumn,yytext());
    }
    

    {for} {
        System.out.println("For found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.FOR);
        return new Symbol(sym.FOR,yyline,yycolumn,yytext());
    }

    {if} {
        System.out.println("if found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.IF);
        return new Symbol(sym.IF,yyline,yycolumn,yytext());

    }

    {int} {
        System.out.println("int found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.INT);
        return new Symbol(sym.INT,yyline,yycolumn,yytext());
    }

    {return} {
        System.out.println("return found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.RETURN);
        return new Symbol(sym.RETURN,yyline,yycolumn,yytext());
    }

    {long} {
        System.out.println("long found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.LONG,yyline,yycolumn,yytext());
    
    }

    {double} {
        System.out.println("double found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.DOUBLE,yyline,yycolumn,yytext());
    }

    {char} {
        System.out.println("char found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.CHAR);
        return new Symbol(sym.CHAR,yyline,yycolumn,yytext());
    }

    {bool} {
        System.out.println("bool found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.BOOL);
        return new Symbol(sym.BOOL,yyline,yycolumn,yytext());
    }

    {void} {
        System.out.println("void found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.VOID,yyline,yycolumn,yytext());
    }

    {signed} {
        System.out.println("signed found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.SIGNED,yyline,yycolumn,yytext());

    }

    {unsigned} {
        System.out.println("unsigned found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.UNSIGNED,yyline,yycolumn,yytext());

    }

    {short} {
        System.out.println("short found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.SHORT,yyline,yycolumn,yytext());
    }

    {long} {
        System.out.println("long found: " + yytext()  + " => at (" + yyline + ","+ yycolumn+")" );
        return new Symbol(sym.LONG,yyline,yycolumn,yytext());
    }

    {float} {
        System.out.println("float found: " + yytext()  + " => at (" + yyline + "," + yycolumn + ")" );
        return new Symbol(sym.FLOAT,yyline,yycolumn,yytext());
    }

    {string} {
        System.out.println("string found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.STRING,yyline,yycolumn,yytext());

    }

    {null} {
        System.out.println("NULL found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
       // return symbol(sym.NULL);
        return new Symbol(sym.NULL,yyline,yycolumn,yytext());
    }

    {and} {
        System.out.println("and found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.AND);
        return new Symbol(sym.AND,yyline,yycolumn,yytext());
    }

    {or} {
        System.out.println("or found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.OR);
        return new Symbol(sym.OR,yyline,yycolumn,yytext());
    }

    {true} {
        System.out.println("true found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.TRUE);
        return new Symbol(sym.TRUE,yyline,yycolumn,yytext());
    }

    {false} {
        System.out.println("false found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.FALSE);
        return new Symbol(sym.FALSE,yyline,yycolumn,yytext());
    }

    {strs} {
        System.out.println("strs found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.STRING,yyline,yycolumn,yytext());
    }

    {pointer} {
        System.out.println("pointer found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        //return symbol(sym.STRING);
        return new Symbol(sym.POINTER,yyline,yycolumn,yytext());
    }
    {pointer_reference} {
        System.out.println("pointer reference found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
       // return symbol(sym.STRING);
        return new Symbol(sym.POINTERREFERENCE,yyline,yycolumn,yytext());

    }

    {scanf} {
        System.out.println("scanf found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.SCANF,yyline,yycolumn,yytext());
    }

    {printf} {
        System.out.println("printf found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.PRINTF,yyline,yycolumn,yytext());
    }

    {greaterThan} {
        System.out.println("greaterThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.GREATERTHAN,yyline,yycolumn,yytext());
    }

    {greaterEqualThan} {
        System.out.println("greaterEqualThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.GREATEREQUALTHAN,yyline,yycolumn,yytext());
    }
    {lesserThan} {
        System.out.println("lesserThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.LESSERTHAN,yyline,yycolumn,yytext());
    }

    {lesserEqualThan} {
        System.out.println("lesserEqualThan found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.LESSEREQUALTHAN,yyline,yycolumn,yytext());
    }

    {comparisson} {
        System.out.println("comparisson found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.COMPARISSON,yyline,yycolumn,yytext());
    }
    {different} {
        System.out.println("different found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.DIFFERENT,yyline,yycolumn,yytext());
    }

    {plusEquals} {
        System.out.println("plusEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.PLUSEQUALS,yyline,yycolumn,yytext());
    }

    {minusEquals} {
        System.out.println("minusEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.MINUSEQUALS,yyline,yycolumn,yytext());
    }

    {timesEquals} {
        System.out.println("timesEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.TIMESEQUALS,yyline,yycolumn,yytext());
    }

    {divideEquals} {
        System.out.println("divideEquals found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.DIVIDEEQUALS,yyline,yycolumn,yytext());
    }

    {identifier} {
        System.out.println("ID found: " + yytext()  + " => at (" +yyline + ","+ yycolumn+")" );
        return new Symbol(sym.ID,yyline,yycolumn,yytext());
    }
   <<EOF>> {
        System.out.println("EOF found" );
        return new Symbol(sym.EOF);
    }

/*
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
*/
//}
/*
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
*/

}