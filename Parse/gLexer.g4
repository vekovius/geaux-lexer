
lexer grammar gLexer;

@header {
   package Parse.antlr_build;
}


@members {
   StringBuilder sb;

   //Need to translate escape sequences to ints (maybe chars too) (for strings)
   private int stringToInt(String target) {
      // TODO: Implement me!
      return 0;
   }
}

fragment ALPHA 
   : [A-Za-z]
   ;
fragment DIGIT
   : [0-9]
   ;

fragment ALNUM
   : [A-Za-z_0-9]
   ;

fragment IDENTIFIER_START
   : [A-Za-z_]
   ; 

fragment HEXADECIMAL
   : [0-9A-Fa-f]
   ;

fragment ESC_SEQ
   :	'\\' ['"\\abfnrtv?]		//other escape sequences
   |	'\\' [0-7]+			//octal escape sequences
   | 	'\\' 'x' HEXADECIMAL+		//hexidecimal escape sequences
   ;

//Whitespace
WS : [ \t\r\n]+ -> skip ;

// Comments
LINE_COMMENT
   : '//' ~[\r\n]* -> skip
   ;

BLOCK_COMMENT
   : '/*' .*? '*/' -> skip
   ;

// Keywords
VAR      
   : 
   'var'
   ;
FUN      
   : 
   'fun'
   ;
WHILE    
   : 
   'while'
   ;
CONST    
   : 
   'const'
   ;
STRING   
   : 
   'string'
   ;
VOID     
   : 
   'void'
   ;
RETURN   
   : 
   'return'
   ;
IF       
   : 
   'if'
   ;
ELSE     
   : 
   'else'
   ;
BREAK    
   : 
   'break'
   ;
INT      
   : 
   'int'
   ;
TYPEDEF  
   : 
   'typedef'
   ;
STRUCT   
   : 
   'struct'
   ;
UNION    
   : 
   'union'
   ;

// Operators (mult-char first)
AND   
   : 
   '&&'
   ;
OR     
   : 
   '||'
   ;
ARROW    
   : 
   '->'
   ;

LT       
   : 
   '<'
   ;
STAR     
   : 
   '*'
   ;
PLUS     
   : 
   '+'
   ;
TILDE    
   : 
   '~'
   ;
ASSIGN   
   : 
   '='
   ;
DOT      
   : 
   '.'
   ;

// Punctuators
LBRACE   
   : 
   '{'
   ;
RBRACE   
   : 
   '}'
   ;
COMMA 
   : 
   ','
   ;
LPAREN   
   : 
   '('
   ;
RPAREN   
   : 
   ')'
   ;
BITWISEAND   
   : 
   '&'
   ;
BITWISEOR   
   : 
   '|'
   ;
BANG  
   : 
   '!'
   ;
SEMI  
   : 
   ';'
   ;
COLON 
   : 
   ':'
   ;
LBRACK   
   : 
   '['
   ;
RBRACK   
   : 
   ']'
   ;

//need to expand to include octal & hexidecimal
INTEGER_CONSTANT : DIGIT+ ;

STRING_LITERAL : '"'(ESC_SEQ | ~["\\\n\r])*'"' ; 

// Identifier
IDENTIFIER : IDENTIFIER_START ALNUM* ;

// Fallback
ERROR_CHAR : . ;
