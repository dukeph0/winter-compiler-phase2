    /* cs152-miniL phase2 */
%{
  #include "stdio.h"
  void yyerror(const char *msg);
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
%% 

  /* write your rules here */
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
%left MINUS
%left PLUS
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

Program:  
{printf("Program -> epsilon\n");}
          | Function Program
          {printf("Program -> Function Program\n);}

Identifier: IDENT
{printf("Identifier -> Ident\n");} | Ident COMMA Identifiers

Identifiers: Identifier COMMA Identifiers
{printf("Identifiers -> Indent\n");} | Identifier COMMA Identifiers


Function: FUNCTION Ident SEMICOLON  BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY
{printf("Function -> Ident SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");}

Functions: function functions
{printf("function -> functions\n");} | function -> functions

Declaration: Identifiers COLON INTEGER
{printf("Declartion -> Identifiers COLON INTEGER\n");} | identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER

Declarations: declaration -> SEMICOLON -> declarations
{printf("declaration -> SEMICOLON -> declarations\n");} | declarations -> SEMICOLON -> declarations | declarations -> epsilon

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}