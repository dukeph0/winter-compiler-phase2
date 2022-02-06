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

function       {col += yyleng; return FUNCTION;}
beginparams    {col += yyleng; return BEGIN_PARAMS;}
endparams      {col += yyleng; return END_PARAMS;}
beginlocals    {col += yyleng; return BEGIN_LOCALS;}
endlocals      {col += yyleng; return END_LOCALS;}
beginbody      {col += yyleng; return BEGIN_BODY;}
endbody        {col += yyleng; return END_BODY;}
integer        {col += yyleng; return INTEGER;}
array          {col += yyleng; return ARRAY;}
of             {col += yyleng; return OF;}
if             {col += yyleng; return IF;}
then           {col += yyleng; return THEN;}
endif          {col += yyleng; return ENDIF;}
else           {col += yyleng; return ELSE;}
while          {col += yyleng; return WHILE;}
do             {col += yyleng; return DO;}
beginloop      {col += yyleng; return BEGINLOOP;}
endloop        {col += yyleng; return ENDLOOP;}
continue       {col += yyleng; return CONTINUE;}
break          {col += yyleng; return BREAK;}
read           {col += yyleng; return READ;}
write          {col += yyleng; return WRITE;}
not            {col += yyleng; return NOT;}
true           {col += yyleng; return TRUE;}
false          {col += yyleng; return FALSE;}
return         {col += yyleng; return RETURN;}
"-"            {col += yyleng; return SUB;}
"+"            {col += yyleng; return ADD;}
"*"            {col += yyleng; return MULT;}
"/"            {col += yyleng; return DIV;}
"%"            {col += yyleng; return MOD;}
"=="           {col += yyleng; return EQ;}
"<>"           {col += yyleng; return NEQ;}
"<"            {col += yyleng; return LT;}
">"            {col += yyleng; return GT;}
"<="           {col += yyleng; return LTE;}
">="           {col += yyleng; return GTE;}
{IDENTIFIER}+  {col += yyleng; return IDENT;} //yytext should be sent to the .y file
{NUMBER}+      {col += yyleng; return NUMBER;}
{INVALID1}	   {printf("Error at line %d, column %d identifier \"%s\" must begin with a letter\n",row,col,yytext);exit(0);}
{INVALID2}  	{printf("Error at line %d, column %d identifier \"%s\" cannot end with an underscore\n",row,col,yytext);exit(0);}
";"            {col += yyleng; return SEMICOLON;}
":"            {col += yyleng; return COLON;}
","            {col += yyleng; return COMMA;}
"("            {col += yyleng; return R_PAREN;}
")"            {col += yyleng; return L_PAREN;}
"["            {col += yyleng; return R_SQUARE_BRACKET;}
"]"            {col += yyleng; return L_SQUARE_BRACKET;}
":="           {col += yyleng; return ASSIGN;}
{COMMENT}      {col += yyleng;}
[ \t]+         {col += yyleng;}
"\n"           {row++; col = 1;}
.              {printf("Error at line %d, column %d unrecognized symbol \"%s\" in lexer\n",row,col,yytext);exit(0);}
%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
}