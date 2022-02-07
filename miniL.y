    /* cs152-miniL phase2 */
%{
  #include "stdio.h"
  void yyerror(const char *msg);
  extern int yylex(); //To read in the yylex from the .lex
  extern int row, col;
%}

%union{
  /* put your types here */
  char* ident_val;
  int num_val;
}

%error-verbose
%locations

/* %start program */
%start prog_start
%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token READ
%token WRITE
%right NOT
%token TRUE
%token FALSE
%token RETURN
%left SUB
%left ADD
%left MULT
%left DIV
%left MOD
%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE
%token <num_val> NUMBER
%token <ident_val> IDENT
%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%left ASSIGN

%%
  /* write your rules here */
/*Start*/
prog_start:  Functions {printf("prog_start -> functions\n");}
            | {printf("prog_start -> epsilon\n");}
;
/*Identifier and Identifiers*/
Identifier: IDENT {printf("Identifier -> IDENT\n");} 
;
Identifiers: Identifier COMMA Identifiers
{printf("Identifiers -> identifier COMMA identifier\n");} | Identifier {printf("Identifiers -> identifier\n");} 
;
/*Function and Functions*/
Function: FUNCTION IDENT SEMICOLON  BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY
{printf("function -> IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");}
;
Functions: Function Functions
{printf("function -> functions\n");} | {printf("functions -> epsilon\n");}
;
/*Declartion and Declarations*/
Declaration: Identifiers COLON INTEGER
{printf("declartion -> identifiers COLON INTEGER\n");} | Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER{printf("declartion -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
;
Declarations: Declaration SEMICOLON Declarations
{printf("declarations -> declaration SEMICOLON declarations\n");} | {printf("declarations -> epsilon\n");}
;
/*Statement and Statements*/
Statement:    Variable ASSIGN Expression {printf("statement -> variable ASSIGN expression\n");}
              | IF BoolExpr THEN Statements ENDIF {printf("statement -> IF boolexpr THEN statments ENDIF\n");}
              | IF BoolExpr THEN Statements ELSE Statements ENDIF {printf("statement -> IF boolexpr THEN statments ELSE statements ENDIF\n");}
              | WHILE BoolExpr BEGINLOOP Statements ENDLOOP {printf("statement -> WHILE boolexpr BEGINLOOP statements ENDLOOP\n");}
              | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr {printf("statement -> DO BEGINLOOP statements ENDLOOP WHILE boolexpr\n");}
              | READ Variables {printf("statement -> READ variables\n");}
              | WRITE Variables {printf("statement -> WRITE variables\n");}
              | CONTINUE {printf("statement -> CONTINUE\n");}
              | RETURN Expression {printf("statement -> RETURN\n");}
;
Statements:   Statement SEMICOLON Statements {printf("statements -> statement SEMICOLON statements\n");}
              | {printf("statements -> epsilon\n");}
;
/*BoolExpr*/
/* Comparison */
Comp:   EQ {printf("comp -> EQ\n");}
        | NEQ {printf("comp -> NEQ\n");}
        | LT {printf("comp -> LT\n");}
        | GT {printf("comp -> GT\n");}
        | LTE {printf("comp -> LTE\n");}
        | GTE {printf("comp -> GTE\n");}
;
/* Expression and Expressions*/
Expression:   MultiplicativeExpr {printf("expression-> multiplicativeexpr\n");}
              | Expression SUB MultiplicativeExpr {printf("expression-> expression SUB multiplicativeexpr\n");}
              | Expression ADD MultiplicativeExpr {printf("expression-> expression ADD multiplicativeexpr\n");}
;
Expressions:   Expression {printf("expressions -> expression\n");}
              | Expression COMMA Expressions {printf("expressions-> expression COMMA expressions\n");}
              | {printf("expressions-> epsilon\n");}
;
/*Multiplicative Expression*/
MultiplicativeExpr:   Term {printf("multiplicativeexpr -> term\n");}
                      | Term DIV Term {printf("multiplicativeexpr -> term DIV term\n");}
                      | Term MULT Term{printf("multiplicativeexpr -> term MULT term\n");}
                      | Term MOD Term {printf("multiplicativeexpr -> term MOD term\n");}
;
/* Term */
Term:   Variable {printf("term -> variable\n");}
        | NUMBER {printf("term -> NUMBER\n");}
        | L_PAREN Expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}
        | SUB Variable {printf("term -> SUB variable\n");}
        | SUB NUMBER {printf("term -> SUB NUMBER\n");}
        | SUB L_PAREN Expression R_PAREN {printf("term -> SUB L_PAREN expression\n");}
        | IDENT L_PAREN Expressions R_PAREN {printf("term -> IDENT L_PAREN expressions R_PAREN\n");}
;
/*Variable and Variables*/
Variable:   IDENT {printf("variable -> IDENT\n");}
            | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("variable -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
;
Variables:  Variable {printf("variables -> variable\n");}
            | Variable COMMA Variables {printf("variables -> variable COMMA variables\n");}
;

%%
int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
    printf("Error at line %d, column %d unrecognized symbol \"%s\" \n",row,col,msg);
}