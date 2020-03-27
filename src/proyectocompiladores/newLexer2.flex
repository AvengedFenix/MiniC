package proyectocompiladores;
import java_cup.runtime.*;
import java.lang.String;



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

%{
    private Symbol symbol(int sym) {
		Symbol data = new Symbol(sym, yycolumn, yyline);
		return data;
	}

	private Symbol symbol(int sym, String val) {
        Object P = val;
		Symbol data = new Symbol(sym, yycolumn, yyline);
		data.value = new Symbol(sym, yycolumn, yyline, P);
		return data;
	}

	private Symbol symbol(int sym, Object val,int buflength) {
        return new Symbol(sym, yycolumn, yyline, val);
	}
%}
//Rexeges primarios 
Digit = [0-9]
Letter = [a-zA-Z_]
CharLiteral = \'([:jletterdigit:]| (\\ ([:jletterdigit:]|\\|"'") ) )\'
H = [a-fA-F0-9]
E = [Ee][+-]?{Digit}+
FS = (f|F|l|L)
IS = (u|U|l|L)*
TC = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EC = "//" [^\r\n]* {_line}
_line = \r|\n|\r\n
white_space = {_line} | [ \t\f]


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
SEMICOLON ="\;"			
LCURLY= ("{"|"<%")		
RCURLY= ("}"|"%>")		
COMMA = ","			
COLON =":"			
ASSIGN_OP = ("=")			
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

{EC}                    { }
{TC}                    { }
{white_space}           { }

//<YYINITIAL> {

    {auto} {
        //System.out.println("auto " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.AUTO,yytext());
    }			
    {break} {
        //System.out.println("break " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.BREAK,yytext());
    }	
			
    {case} {
        //System.out.println("case " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CASE,yytext());
    }				
    {char} {
        //System.out.println("char " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CHAR,yytext());
    }			
    {const} {
        //System.out.println("const " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CONST,yytext());
    }					
    {continue} {
        //System.out.println("continue " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CONTINUE,yytext());
    }		
    {default} {
        //System.out.println("default " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DEFAULT,yytext());
    }				
    {do} {
        //System.out.println("do " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DO,yytext());
    }	
			
    {double} {
        //System.out.println("double " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DOUBLE,yytext());
    }			
    {else} {
        //System.out.println("else " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ELSE,yytext());
    }			
    {enum} {
        //System.out.println("enum " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ENUM,yytext());
    }	
			
    {extern} {
        //System.out.println("extern " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.EXTERN,yytext());
    }			
    {float} {
        //System.out.println("float " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.FLOAT,yytext());
    }		
			
    {for} {
        System.out.println("for " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.FOR,yytext());
    }					
    {goto} {
        System.out.println("goto " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.GOTO,yytext());
    }				
    {if} {
        System.out.println("if " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.IF,yytext());
    }					
    {int} {
        System.out.println("int " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.INT,yytext());
    }				
    {long} {
        System.out.println("long " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.LONG,yytext());
    }					
    {register} {
        System.out.println("register " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.REGISTER,yytext());
    }			
    {return} {
        System.out.println("return " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.RETURN,yytext());
    }				
    {short} {
        System.out.println("short " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SHORT,yytext());
    }					
    {signed} {
        System.out.println("signed " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SIGNED,yytext());
    }			
    {sizeof} {
        System.out.println("sizeof " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SIZEOF,yytext());
    }			
    {static} {
        System.out.println("static " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.STATIC,yytext());
    }				
    {struct} {
        System.out.println("struct " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.STRUCT,yytext());
    }				
    {switch} {
        System.out.println("switch " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SWITCH,yytext());
    }			
    {typedef} {
        System.out.println("typedef " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.TYPEDEF,yytext());
    }				
    {union} {
        System.out.println("union " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.UNION,yytext());
    }					
    {unsigned} {
        System.out.println("unsigned " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.UNSIGNED,yytext());
    }	
    {void} {
        System.out.println("void " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.VOID,yytext());
    }			
    {volatile} {
        System.out.println("volatile " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.VOLATILE,yytext());
    }				
    {while} {
        System.out.println("while " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.WHILE,yytext());
    }
    {scanf} {
        System.out.println("scanf " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SCANF,yytext());
    }
    {printf} {
        System.out.println("printf " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.PRINTF,yytext());
    }



    {ELLIPSIS} {
        System.out.println("ELLIPSIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ELLIPSIS,yytext());
    }
    {RIGHT_ASSIGN} {
        System.out.println("RIGHT_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.RIGHT_ASSIGN,yytext());
    }
    {LEFT_ASSIGN} {
        System.out.println("LEFT_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.LEFT_ASSIGN,yytext());
    }
    {ADD_ASSIGN} {
        System.out.println("ADD_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ADD_ASSIGN,yytext());
    }
    {SUB_ASSIGN} {
        System.out.println("SUB_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SUB_ASSIGN,yytext());
    }
    {MUL_ASSIGN} {
        System.out.println("MUL_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.MUL_ASSIGN,yytext());
    }
    {DIV_ASSIGN} {
        System.out.println("DIV_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DIV_ASSIGN,yytext());
    }
    {MOD_ASSIGN} {
        System.out.println("MOD_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.MOD_ASSIGN,yytext());
    }
    {AND_ASSIGN} {
        System.out.println("AND_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.AND_ASSIGN,yytext());
    }
    {XOR_ASSIGN} {
        System.out.println("XOR_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.XOR_ASSIGN,yytext());
    }
    {OR_ASSIGN} {
        System.out.println("OR_ASSIGN " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.OR_ASSIGN,yytext());
    }
    {RIGHT_OP} {
        System.out.println("RIGHT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.RIGHT_OP,yytext());
    }
    {LEFT_OP} {
        System.out.println("LEFT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.LEFT_OP,yytext());
    }
    {INC_OP} {
        System.out.println("INC_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.INC_OP,yytext());
    }
    {DEC_OP} {
        System.out.println("DEC_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DEC_OP,yytext());
    }
    {PTR_OP} {
        System.out.println("PTR_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.PTR_OP,yytext());
    }
    {AND_OP} {
        System.out.println("AND_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.AND_OP,yytext());
    }
    {OR_OP} {
        System.out.println("OR_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.OR_OP,yytext());
    }
    {LE_OP} {
        System.out.println("LE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.LE_OP,yytext());
    }
    {EQ_OP} {
        System.out.println("EQ_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.EQ_OP,yytext());
    }
    {GE_OP} {
        System.out.println("GE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.GE_OP,yytext());
    }
    {NE_OP} {
        System.out.println("NE_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.NE_OP,yytext());
    }
    {SEMICOLON} {
        System.out.println("SEMICOLON " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SEMI,yytext());
    }
    {LCURLY} {
        System.out.println("LCURLY " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CURLYL,yytext());
    }
    {RCURLY} {
        System.out.println("RCURLY " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CURLYR,yytext());
    }
    {COMMA} {
        System.out.println("COMMA " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.COMMA,yytext());
    }
    {COLON} {
        System.out.println("COLON " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.COLON,yytext());
    }
    {ASSIGN_OP} {
        System.out.println("ASSIGN_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ASSIGN,yytext());
    }
    {LPARENTHESIS} {
        System.out.println("LPARENTHESIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.PARAL,yytext());
    }
    {RPARENTHERSIS} {
        System.out.println("RPARENTHERSIS " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.PARAR,yytext());
    }
    {LBRACKET} {
        System.out.println("LBRACKET " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SQUAREDL,yytext());
    }
    {RBRACKET} {
        System.out.println("RBRACKET " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.SQUAREDR,yytext());
    }
    {DOT} {
        System.out.println("DOT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.POINT,yytext());
    }
    {AMPERSAND} {
        System.out.println("AMPERSAND " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.ADRESS,yytext());
    }
    {EXCLAMATION} {
        System.out.println("EXCLAMATION " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.NOT,yytext());
    }
    {TILDE} {
        System.out.println("TILDE " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.TILDE,yytext());
    }
    {SUB_OP} {
        System.out.println("SUB_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.MINUS,yytext());
    }
    {ADD_OP} {
        System.out.println("ADD_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.PLUS,yytext());
    }
    {MULT_OP} {
        System.out.println("MULT_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.MUL,yytext());
    }
    {DIV_OP} {
        System.out.println("DIV_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.DIVIDE,yytext());
    }
    {MOD_OP} {
        System.out.println("MOD_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.MODULUS,yytext());
    }
    {L_OP} {
        System.out.println("L_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.LESS,yytext());
    }
    {G_OP} {
        System.out.println("G_OP " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.GREATER,yytext());
    }
    {HAT} {
        System.out.println("HAT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.XOR,yytext());
    }
    {PIPE} {
        System.out.println("PIPE " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.OR,yytext());
    }
    {QUESTION} {
        System.out.println("QUESTION " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.COND,yytext());
    }

    {IDENTIFIER} {
        System.out.println("IDENTIFIER " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.IDENTIFIER,yytext());
    }
    {CONSTANT} {
        System.out.println("CONSTANT " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.CONSTANT,yytext());
    }    
    {STRING_LITERAL} {
        System.out.println("STRING_LITERAL " + yytext() + " => at (" + yyline +"," + yycolumn +")");
                return  Symbol(sym.STRING_LITERAL,yytext());
    }
    {ERROR_COMILLAS_DOBLES} {
        System.err.println("Error Lexico, comillas dobles para strings: "+yytext()+" "+(yyline+1)+" : "+(yycolumn+1));
    }
    {NO_IDEA} {
        System.err.println("Error Lexico, token no identificado: "+yytext()+" "+(yyline+1)+" : "+(yycolumn+1));    
    }    
    
   <<EOF>> {
        System.out.println("EOF found" );
        return  Symbol(sym.EOF);
    } 
    c

//}