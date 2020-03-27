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

//Rexeges primarios 
Digit = [0-9]
Letter = [a-zA-Z_]
CharLiteral = \'([:jletterdigit:]| (\\ ([:jletterdigit:]|\\|"'") ) )\'
H = [a-fA-F0-9]
E = [Ee][+-]?{Digit}+
FS = (f|F|l|L)
IS = (u|U|l|L)*
TC = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EC = "//" [^\r\n]* {new_line}
new_line = \r|\n|\r\n
white_space = {new_line} | [ \t\f]


// palabras reservadas
auto ="auto"
break="break"
case="case"
char="char"
const="const"
continue="continue"
default="default"
do="do"
double="double"
else="else"
enum="enum"
extern="extern"
float="float"
for="for"
goto="goto"
if="if"
int="int"
long="long"
register="register"	
return="return"
short="short"
signed="signed"
sizeof="sizeof"
static="static"
struct="struct"
switch="switch"
typedef="typedef"
union="union"
unsigned="unsigned"
void="void"
volatile="volatile"
while="while"
scanf = "scanf"
printf = "printf"

			
// simbolos

ELLIPSIS = "..."			
RIGHT_ASSIGN= ">>=" 			
LEFT_ASSIGN ="<<="			
ADD_ASSIGN= "+="			
SUB_ASSIGN="-="			
MUL_ASSIGN="*="			
DIV_ASSIGN="/="			
MOD_ASSIGN="%="			
AND_ASSIGN="&="			
XOR_ASSIGN="^="			
OR_ASSIGN="|="			
RIGHT_OP=">>"	
LEFT_OP="<<"			
INC_OP="++"			
DEC_OP="--"			 
PTR_OP="->"			 
AND_OP="&&"			 
OR_OP="||"			
LE_OP="<="			
GE_OP=">="			
EQ_OP="=="			
NE_OP="!="			
SEMICOLON =";"			
LCURLY= ("{"|"<%")		
RCURLY= ("}"|"%>")		
COMMA = ","			
COLON =":"			
ASSIGN_OP = "="			
LPARENTHESIS="("			
RPARENTHERSIS=")"			
LBRACKET=("["|"<:")		
RBRACKET=("]"|":>")		
DOT="."			
AMPERSAND="&"			
EXCLAMATION="!"			
TILDE ="~"		
SUB_OP = "-"			
ADD_OP= "+"			
MULT_OP="*"			
DIV_OP="/"			
MOD_OP="%"			
L_OP="<"			
G_OP=">"			
HAT= "^"			
PIPE= "|"		
QUESTION="?"	

IDENTIFIER = {Letter}({Letter}|{Digit})*
CONSTANT =  ( 0[xX]{H}+{IS}? |		
              0{Digit}+{IS}? |
              {Digit}+{IS}?  |
              {CharLiteral}  |
              {Digit}+{E}{FS}? |		
              {Digit}*"."{Digit}+({E})?{FS}? |	
              {Digit}+"."{Digit}*({E})?{FS}? )

STRING_LITERAL = L?\"(\\.|[^\\\"])*\"	
ERROR_COMILLAS_DOBLES = L?'(\\.|[^\\'])+'	
NO_IDEA = [^]			



%%

<YYINITIAL> {

    {auto} {
        System.out.println("auto " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.AUTO,yyline,yycolumn,yytext());
    }			
    {break} {
        System.out.println("break " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.BREAK,yyline,yycolumn,yytext());
    }	
			
    {case} {
        System.out.println("case " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CASE,yyline,yycolumn,yytext());
    }				
    {char} {
        System.out.println("char " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CHAR,yyline,yycolumn,yytext());
    }			
    {const} {
        System.out.println("const " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CONST,yyline,yycolumn,yytext());
    }					
    {continue} {
        System.out.println("continue " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CONTINUE,yyline,yycolumn,yytext());
    }		
    {default} {
        System.out.println("default " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DEFAULT,yyline,yycolumn,yytext());
    }				
    {do} {
        System.out.println("do " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DO,yyline,yycolumn,yytext());
    }	
			
    {double} {
        System.out.println("double " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DOUBLE,yyline,yycolumn,yytext());
    }			
    {else} {
        System.out.println("else " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ELSE,yyline,yycolumn,yytext());
    }			
    {enum} {
        System.out.println("enum " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ENUM,yyline,yycolumn,yytext());
    }	
			
    {extern} {
        System.out.println("extern " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.EXTERN,yyline,yycolumn,yytext());
    }			
    {float} {
        System.out.println("float " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.FLOAT,yyline,yycolumn,yytext());
    }		
			
    {for} {
        System.out.println("for " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.FOR,yyline,yycolumn,yytext());
    }					
    {goto} {
        System.out.println("goto " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.GOTO,yyline,yycolumn,yytext());
    }				
    {if} {
        System.out.println("if " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.IF,yyline,yycolumn,yytext());
    }					
    {int} {
        System.out.println("int " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.INT,yyline,yycolumn,yytext());
    }				
    {long} {
        System.out.println("long " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LONG,yyline,yycolumn,yytext());
    }					
    {register} {
        System.out.println("register " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.REGISTER,yyline,yycolumn,yytext());
    }			
    {return} {
        System.out.println("return " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.RETURN,yyline,yycolumn,yytext());
    }				
    {short} {
        System.out.println("short " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SHORT,yyline,yycolumn,yytext());
    }					
    {signed} {
        System.out.println("signed " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SIGNED,yyline,yycolumn,yytext());
    }			
    {sizeof} {
        System.out.println("sizeof " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SIZEOF,yyline,yycolumn,yytext());
    }			
    {static} {
        System.out.println("static " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.STATIC,yyline,yycolumn,yytext());
    }				
    {struct} {
        System.out.println("struct " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.STRUCT,yyline,yycolumn,yytext());
    }				
    {switch} {
        System.out.println("switch " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SWITCH,yyline,yycolumn,yytext());
    }			
    {typedef} {
        System.out.println("typedef " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.TYPEDEF,yyline,yycolumn,yytext());
    }				
    {union} {
        System.out.println("union " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.UNION,yyline,yycolumn,yytext());
    }					
    {unsigned} {
        System.out.println("unsigned " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.UNSIGNED,yyline,yycolumn,yytext());
    }	
    {void} {
        System.out.println("void " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.VOID,yyline,yycolumn,yytext());
    }			
    {volatile} {
        System.out.println("volatile " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.VOLATILE,yyline,yycolumn,yytext());
    }				
    {while} {
        System.out.println("while " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.WHILE,yyline,yycolumn,yytext());
    }
    {scanf} {
        System.out.println("scanf " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SCANF,yyline,yycolumn,yytext());
    }
    {printf} {
        System.out.println("printf " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.PRINTF,yyline,yycolumn,yytext());
    }



    {ELLIPSIS} {
        System.out.println("ELLIPSIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ELLIPSIS,yyline,yycolumn,yytext());
    }
    {RIGHT_ASSIGN} {
        System.out.println("RIGHT_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.RIGHT_ASSIGN,yyline,yycolumn,yytext());
    }
    {LEFT_ASSIGN} {
        System.out.println("LEFT_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LEFT_ASSIGN,yyline,yycolumn,yytext());
    }
    {ADD_ASSIGN} {
        System.out.println("ADD_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ADD_ASSIGN,yyline,yycolumn,yytext());
    }
    {SUB_ASSIGN} {
        System.out.println("SUB_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SUB_ASSIGN,yyline,yycolumn,yytext());
    }
    {MUL_ASSIGN} {
        System.out.println("MUL_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MUL_ASSIGN,yyline,yycolumn,yytext());
    }
    {DIV_ASSIGN} {
        System.out.println("DIV_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DIV_ASSIGN,yyline,yycolumn,yytext());
    }
    {MOD_ASSIGN} {
        System.out.println("MOD_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MOD_ASSIGN,yyline,yycolumn,yytext());
    }
    {AND_ASSIGN} {
        System.out.println("AND_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.AND_ASSIGN,yyline,yycolumn,yytext());
    }
    {XOR_ASSIGN} {
        System.out.println("XOR_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.XOR_ASSIGN,yyline,yycolumn,yytext());
    }
    {OR_ASSIGN} {
        System.out.println("OR_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.OR_ASSIGN,yyline,yycolumn,yytext());
    }
    {RIGHT_OP} {
        System.out.println("RIGHT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.RIGHT_OP,yyline,yycolumn,yytext());
    }
    {LEFT_OP} {
        System.out.println("LEFT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LEFT_OP,yyline,yycolumn,yytext());
    }
    {INC_OP} {
        System.out.println("INC_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.INC_OP,yyline,yycolumn,yytext());
    }
    {DEC_OP} {
        System.out.println("DEC_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DEC_OP,yyline,yycolumn,yytext());
    }
    {PTR_OP} {
        System.out.println("PTR_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.PTR_OP,yyline,yycolumn,yytext());
    }
    {AND_OP} {
        System.out.println("AND_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.AND_OP,yyline,yycolumn,yytext());
    }
    {OR_OP} {
        System.out.println("OR_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.OR_OP,yyline,yycolumn,yytext());
    }
    {LE_OP} {
        System.out.println("LE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LE_OP,yyline,yycolumn,yytext());
    }
    {EQ_OP} {
        System.out.println("EQ_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.EQ_OP,yyline,yycolumn,yytext());
    }
    {GE_OP} {
        System.out.println("GE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.GE_OP,yyline,yycolumn,yytext());
    }
    {NE_OP} {
        System.out.println("NE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.NE_OP,yyline,yycolumn,yytext());
    }
    {SEMICOLON} {
        System.out.println("SEMICOLON " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SEMICOLON,yyline,yycolumn,yytext());
    }
    {LCURLY} {
        System.out.println("LCURLY " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CURLYL,yyline,yycolumn,yytext());
    }
    {RCURLY} {
        System.out.println("RCURLY " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CURLYR,yyline,yycolumn,yytext());
    }
    {COMMA} {
        System.out.println("COMMA " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COMMA,yyline,yycolumn,yytext());
    }
    {COLON} {
        System.out.println("COLON " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COLON,yyline,yycolumn,yytext());
    }
    {ASSIGN_OP} {
        System.out.println("ASSIGN_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ASSIGN_OP,yyline,yycolumn,yytext());
    }
    {LPARENTHESIS} {
        System.out.println("LPARENTHESIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.PARAL,yyline,yycolumn,yytext());
    }
    {RPARENTHERSIS} {
        System.out.println("RPARENTHERSIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.PARAR,yyline,yycolumn,yytext());
    }
    {LBRACKET} {
        System.out.println("LBRACKET " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SQUAREDL,yyline,yycolumn,yytext());
    }
    {RBRACKET} {
        System.out.println("RBRACKET " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.SQUAREDR,yyline,yycolumn,yytext());
    }
    {DOT} {
        System.out.println("DOT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.POINT,yyline,yycolumn,yytext());
    }
    {AMPERSAND} {
        System.out.println("AMPERSAND " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.ADRESS,yyline,yycolumn,yytext());
    }
    {EXCLAMATION} {
        System.out.println("EXCLAMATION " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.NOT,yyline,yycolumn,yytext());
    }
    {TILDE} {
        System.out.println("TILDE " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.TILDE,yyline,yycolumn,yytext());
    }
    {SUB_OP} {
        System.out.println("SUB_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MINUS,yyline,yycolumn,yytext());
    }
    {ADD_OP} {
        System.out.println("ADD_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.PLUS,yyline,yycolumn,yytext());
    }
    {MULT_OP} {
        System.out.println("MULT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MUL,yyline,yycolumn,yytext());
    }
    {DIV_OP} {
        System.out.println("DIV_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.DIVIDE,yyline,yycolumn,yytext());
    }
    {MOD_OP} {
        System.out.println("MOD_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.MODULUS,yyline,yycolumn,yytext());
    }
    {L_OP} {
        System.out.println("L_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.LESS,yyline,yycolumn,yytext());
    }
    {G_OP} {
        System.out.println("G_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.GREATER,yyline,yycolumn,yytext());
    }
    {HAT} {
        System.out.println("HAT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.XOR,yyline,yycolumn,yytext());
    }
    {PIPE} {
        System.out.println("PIPE " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.OR,yyline,yycolumn,yytext());
    }
    {QUESTION} {
        System.out.println("QUESTION " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.COND,yyline,yycolumn,yytext());
    }

    {IDENTIFIER} {
        System.out.println("IDENTIFIER " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.IDENTIFIER,yyline,yycolumn,yytext());
    }
    {CONSTANT} {
        System.out.println("CONSTANT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.CONSTANT,yyline,yycolumn,yytext());
    }    
    {STRING_LITERAL} {
        System.out.println("STRING_LITERAL " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return new Symbol(sym.STRING_LITERAL,yyline,yycolumn,yytext());
    }
    {ERROR_COMILLAS_DOBLES} {
        System.err.println("Error Lexico, comillas dobles para strings: "+yytext()+" "+(yyline+1)+" : "+(yycolumn+1));
    }
    {NO_IDEA} {
        System.err.println("Error Lexico, token no identificado: "+yytext()+" "+(yyline+1)+" : "+(yycolumn+1));    
    }

    {EC}                    { }
    {TC}                    { }
    {white_space}           { }
    

   <<EOF>> {
        System.out.println("EOF found" );
        return new Symbol(sym.EOF);
    }

}