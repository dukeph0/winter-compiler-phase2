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
%start Program
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
%start prog_start
%% 



int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}