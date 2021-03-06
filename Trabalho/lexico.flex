

/*
 * @author Daniel Amarante - 13201876-3 - daniel.amarante2@gmail.com
 * @author Matthias Nunes - 08105058-5 - matthiasnunes@gmail.com
 * @author Pedro Kühn - 10200237-5 - pedrohk@gmail.com
 */



%%

%byaccj
%integer
%line
%char
%caseless 
%ignorecase

%{
  private Parser yyparser;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
    yyline = 1;
  }

  public int getLine() {
      return yyline;
  }

%}

WHITE_SPACE = [\n\r\ \t\b\012]
ID          = {LETTER}+({LETTER}|{NUM}|"_")* 
LETTER      = [a-zA-Z]
NUM         = [0-9]+
LITERAL     = "\""[^\"]*"\""

%%


"PROGRAM"   {return Parser.PROGRAM;}
"FUNCTION"	{return Parser.FUNCTION;}
"PROCEDURE"	{return Parser.PROCEDURE;}

"VAR"       {return Parser.VAR;}      
"INTEGER"   {return Parser.INTEGER;}
"BOOLEAN"   {return Parser.BOOLEAN;}   
"REAL"	    {return Parser.REAL;}

"BEGIN"     {return Parser.BEGIN;}
"END"       {return Parser.END;}
"IF"        {return Parser.IF;}
"THEN"      {return Parser.THEN;}
"ELSE"      {return Parser.ELSE;}
"WHILE"     {return Parser.WHILE;}
"DO"        {return Parser.DO;}
"READLN"    {return Parser.READLN;}
"WRITELN"   {return Parser.WRITELN;}


":="        {return Parser.ASSIGN;}
"DIV"       {return Parser.DIV;}
"MOD"       {return Parser.MOD;}
"AND"       {return Parser.AND;}
"OR"        {return Parser.OR;}
"NOT"       {return Parser.NOT;}
"<="        {return Parser.LEQ;}
"<"         {return Parser.LE;}
">"         {return Parser.GR;}
">="        {return Parser.GEQ;}
"="         {return Parser.EQ;}
"<>"        {return Parser.NEQ;}

"TRUE"      {return Parser.TRUE;}
"FALSE"     {return Parser.FALSE;}

":"|
";"|
"."|
","|
"("|
")"|
"+"|
"-"|
"*"    {return yytext().charAt(0);} 

{LITERAL} { yyparser.yylval = new ParserVal(yytext());
            return Parser.LITERAL; 
          }


{ID}      { yyparser.yylval = new ParserVal(yytext());
            return Parser.ID; 
          }

{NUM}     { yyparser.yylval = new ParserVal(Integer.parseInt(yytext())); 
            return Parser.NUM; 
          }

"{"[^.]*"}"   { }	
{WHITE_SPACE}+    { }
.      {System.out.println("Erro lexico: caracter inválido: <" + yytext() + ">");}
