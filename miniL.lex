   /* cs152 - miniL phase1 */
   /* Team: WinterCompiler */
   /* Members: Duke Pham -  dpham073 and Alejandra Avitia-Davila - aavit004 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   int col = 1, row = 1;
%}

   /* some common rules */
   /* Constraints : Identifier has to start with a letter and can't end with an underscore */
   /*               All reserved words are lowercase */
   /*               Whitespaces can be blank,tabs or newlines */
   /*               Comments are by ## and extend to the end of the curr line */
   /*               Functions takse in some const num and return a single scalar results. NO ref params. Must include main that takes no args and returns nothing */
NUMBER         [0-9]
SPACE          " "
COMMENT        ##.*
LETTER         [a-zA-Z]
IDENTIFIER     ({LETTER}({LETTER}|{NUMBER}|"_")*({NUMBER}|{LETTER}))|{LETTER}*
INVALID1       ({NUMBER}|"_")+{IDENTIFIER}*
INVALID2       {IDENTIFIER}"_"

%%
   /* specific lexer rules in regex - FROM OUTPUT FORMAT FOR LEX ANALYZER PDF*/

function       {printf("FUNCTION\n");col += yyleng;}
beginparams    {printf("BEGIN_PARAMS\n");col += yyleng;}
endparams      {printf("END_PARAMS\n");col += yyleng;}
beginlocals    {printf("BEGIN_LOCALS\n");}col += yyleng;
endlocals      {printf("END_LOCALS\n");col += yyleng;}
beginbody      {printf("BEGIN_BODY\n");col += yyleng;}
endbody        {printf("END_BODY\n");col += yyleng;}
integer        {printf("INTEGER\n");col += yyleng;}
array          {printf("ARRAY\n");col += yyleng;}
of             {printf("OF\n");col += yyleng;}
if             {printf("IF\n");col += yyleng;}
then           {printf("THEN\n");col += yyleng;}
endif          {printf("ENDIF\n");col += yyleng;}
else           {printf("ELSE\n");col += yyleng;}
while          {printf("WHILE\n");col += yyleng;}
do             {printf("DO\n");col += yyleng;}
beginloop      {printf("BEGINLOOP\n");col += yyleng;}
endloop        {printf("ENDLOOP\n");col += yyleng;}
continue       {printf("CONTINUE\n");col += yyleng;}
break          {printf("BREAK\n");col += yyleng;}
read           {printf("READ\n");col += yyleng;}
write          {printf("WRITE\n");col += yyleng;}
not            {printf("NOT\n");col += yyleng;}
true           {printf("TRUE\n");col += yyleng;}
false          {printf("FALSE\n");col += yyleng;}
return         {printf("RETURN\n");col += yyleng;}
"-"            {printf("MINUS\n");col += yyleng;}
"+"            {printf("PLUS\n");col += yyleng;}
"*"            {printf("MULT\n");col += yyleng;}
"/"            {printf("DIV\n");col += yyleng;}
"%"            {printf("MOD\n");col += yyleng;}
"=="           {printf("EQ\n");col += yyleng;}
"<>"           {printf("NEQ\n");col += yyleng;}
"<"            {printf("LT\n");col += yyleng;}
">"            {printf("GT\n");col += yyleng;}
"<="           {printf("LTE\n");col += yyleng;}
">="           {printf("GTE\n");col += yyleng;}
{IDENTIFIER}+  {printf("IDENT %s\n", yytext);col += yyleng;}
{NUMBER}+      {printf("NUMBER %s\n", yytext);col += yyleng;}
{INVALID1}	   {printf("Error at line %d, column %d identifier \"%s\" must begin with a letter\n",row,col,yytext);exit(0);}
{INVALID2}  	{printf("Error at line %d, column %d identifier \"%s\" cannot end with an underscore\n",row,col,yytext);exit(0);}
";"            {printf("SEMICOLON\n");col += yyleng;}
":"            {printf("COLON\n");col += yyleng;}
","            {printf("COMMA\n");col += yyleng;}
"("            {printf("L_PAREN\n");col += yyleng;}
")"            {printf("R_PAREN\n");col += yyleng;}
"["            {printf("L_SQUARE_BRACKET\n");col += yyleng;}
"]"            {printf("R_SQUARE_BRACKET\n");col += yyleng;}
":="           {printf("ASSIGN\n");col += yyleng;}
{COMMENT}      {col += yyleng;}
[ \t]+         {col += yyleng;}
"\n"           {row++; col = 1;}
.              {printf("Error at line %d, column %d unrecognized symbol \"%s\" \n",row,col,yytext);exit(0);}
%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
}