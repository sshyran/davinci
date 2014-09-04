/* This ocamlyacc file was machine-generated by the BNF converter */
%{
open Abscacao
open Lexing
%}

%token TOK_else TOK_false TOK_from TOK_fun TOK_if TOK_in TOK_let TOK_newP TOK_pushP TOK_pushSC TOK_rec TOK_takeSC TOK_then TOK_true TOK_yield

%token SYMB1 /* ; */
%token SYMB2 /* ;; */
%token SYMB3 /* = */
%token SYMB4 /* -> */
%token SYMB5 /* ( */
%token SYMB6 /* ) */
%token SYMB7 /* | */
%token SYMB8 /* < */
%token SYMB9 /* > */
%token SYMB10 /* <= */
%token SYMB11 /* >= */
%token SYMB12 /* ! */
%token SYMB13 /* / */
%token SYMB14 /* + */
%token SYMB15 /* * */
%token SYMB16 /* :: */
%token SYMB17 /* - */
%token SYMB18 /* <- */
%token SYMB19 /* @Seq */
%token SYMB20 /* @App */
%token SYMB21 /* @Let */
%token SYMB22 /* @Letrec */
%token SYMB23 /* @Abs */
%token SYMB24 /* @Cond */
%token SYMB25 /* @SelectFrom */
%token SYMB26 /* @From */
%token SYMB27 /* @SelectFromWhere */
%token SYMB28 /* @FromWhere */
%token SYMB29 /* @Equate */
%token SYMB30 /* @CompLT */
%token SYMB31 /* @CompGT */
%token SYMB32 /* @CompLTE */
%token SYMB33 /* @CompGTE */
%token SYMB34 /* @Unquote */
%token SYMB35 /* @Newprompt */
%token SYMB36 /* @Suspend */
%token SYMB37 /* @Release */
%token SYMB38 /* @SuspendSub */
%token SYMB39 /* @Divide */
%token SYMB40 /* @Add */
%token SYMB41 /* @Multiply */
%token SYMB42 /* @Juxtapose */
%token SYMB43 /* @Negate */
%token SYMB44 /* ` */
%token SYMB45 /* ' */
%token SYMB46 /* [ */
%token SYMB47 /* ] */
%token SYMB48 /* $ */
%token SYMB49 /* , */

%token TOK_EOF
%token <string> TOK_Ident
%token <string> TOK_String
%token <int> TOK_Integer
%token <float> TOK_Double
%token <char> TOK_Char
%token <string> TOK_UIdent
%token <string> TOK_LIdent
%token <string> TOK_Wild

%start pExpr pArithmeticExpr pBinding pPattern pVariation pLyst pValue pDuality pSymbol pExpr_list pPattern_list pBinding_list
%type <Abscacao.expr> pExpr
%type <Abscacao.arithmeticExpr> pArithmeticExpr
%type <Abscacao.binding> pBinding
%type <Abscacao.pattern> pPattern
%type <Abscacao.variation> pVariation
%type <Abscacao.lyst> pLyst
%type <Abscacao.value> pValue
%type <Abscacao.duality> pDuality
%type <Abscacao.symbol> pSymbol
%type <Abscacao.expr list> pExpr_list
%type <Abscacao.pattern list> pPattern_list
%type <Abscacao.binding list> pBinding_list


%%
pExpr : expr TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pArithmeticExpr : arithmeticExpr TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pBinding : binding TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pPattern : pattern TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pVariation : variation TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pLyst : lyst TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pValue : value TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pDuality : duality TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pSymbol : symbol TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pExpr_list : expr2_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pPattern_list : pattern_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pBinding_list : binding_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };


expr : expr SYMB1 expr1 { Sequence ($1, $3) } 
  | expr1 {  $1 }
;

expr1 : expr1 expr2_list SYMB2 { Application ($1, $2) } 
  | expr2 {  $1 }
;

expr2 : TOK_let pattern SYMB3 expr2 TOK_in expr3 { Supposition ($2, $4, $6) } 
  | TOK_let TOK_rec pattern SYMB3 expr2 TOK_in expr3 { Recurrence ($3, $5, $7) }
  | expr3 {  $1 }
;

expr3 : TOK_fun pattern SYMB4 expr4 { Abstraction ($2, $4) } 
  | expr4 {  $1 }
;

expr4 : TOK_if expr4 TOK_then expr5 TOK_else expr5 { Condition ($2, $4, $6) } 
  | TOK_from SYMB5 binding_list SYMB6 TOK_yield expr5 { Comprehension ($3, $6) }
  | TOK_from SYMB5 binding_list SYMB6 expr5 { Consolidation ($3, $5) }
  | TOK_from SYMB5 binding_list SYMB7 pattern_list SYMB6 TOK_yield expr5 { Filtration ($3, $5, $8) }
  | TOK_from SYMB5 binding_list SYMB7 pattern_list SYMB6 expr5 { Concentration ($3, $5, $7) }
  | expr5 SYMB3 expr5 { Equation ($1, $3) }
  | expr5 SYMB8 expr5 { ComparisonLT ($1, $3) }
  | expr5 SYMB9 expr5 { ComparisonGT ($1, $3) }
  | expr5 SYMB10 expr5 { ComparisonLTE ($1, $3) }
  | expr5 SYMB11 expr5 { ComparisonGTE ($1, $3) }
  | expr5 {  $1 }
;

expr5 : SYMB12 variation { Reflection $2 } 
  | TOK_newP { Acquisition  }
  | TOK_pushP expr5 expr5 { Suspension ($2, $3) }
  | TOK_takeSC expr5 expr5 { Release ($2, $3) }
  | TOK_pushSC expr5 expr5 { InnerSuspension ($2, $3) }
  | arithmeticExpr { Calculation $1 }
;

arithmeticExpr : arithmeticExpr SYMB13 arithmeticExpr1 { Division ($1, $3) } 
;

arithmeticExpr1 : arithmeticExpr1 SYMB14 arithmeticExpr2 { Addition ($1, $3) } 
;

arithmeticExpr2 : arithmeticExpr2 SYMB15 arithmeticExpr3 { Multiplication ($1, $3) } 
;

arithmeticExpr3 : arithmeticExpr3 SYMB16 arithmeticExpr4 { Juxtaposition ($1, $3) } 
;

arithmeticExpr4 : SYMB17 arithmeticExpr5 { Negation $2 } 
;

arithmeticExpr5 : variation { Mention $1 } 
  | value { Actualization $1 }
  | SYMB5 expr SYMB6 { Aggregation $2 }
;

binding : pattern SYMB18 expr5 { Question ($1, $3) } 
;

pattern : symbol SYMB5 pattern_list SYMB6 { Element ($1, $3) } 
  | variation { Variable $1 }
  | value { Materialization $1 }
  | lyst { Procession $1 }
  | SYMB19 variation { PtnSequence $2 }
  | SYMB20 variation variation { PtnApplication ($2, $3) }
  | SYMB21 variation variation variation { PtnSupposition ($2, $3, $4) }
  | SYMB22 variation variation variation { PtnRecurrence ($2, $3, $4) }
  | SYMB23 variation variation { PtnAbstraction ($2, $3) }
  | SYMB24 variation variation variation { PtnCondition ($2, $3, $4) }
  | SYMB25 variation variation { PtnComprehend ($2, $3) }
  | SYMB26 variation variation { PtnConsolidate ($2, $3) }
  | SYMB27 variation variation variation { PtnFiltration ($2, $3, $4) }
  | SYMB28 variation variation variation { PtnConcentrate ($2, $3, $4) }
  | SYMB29 variation variation { PtnEquation ($2, $3) }
  | SYMB30 variation variation { PtnCompLT ($2, $3) }
  | SYMB31 variation variation { PtnCompGT ($2, $3) }
  | SYMB32 variation variation { PtnCompLTE ($2, $3) }
  | SYMB33 variation variation { PtnCompGTE ($2, $3) }
  | SYMB34 variation variation { PtnReflection ($2, $3) }
  | SYMB35 { PtnAcquisition  }
  | SYMB36 variation variation { PtnSuspension ($2, $3) }
  | SYMB37 variation variation { PtnRelease ($2, $3) }
  | SYMB38 variation variation { PtnInnerSuspend ($2, $3) }
  | SYMB39 variation variation { PtnDivision ($2, $3) }
  | SYMB40 variation variation { PtnAddition ($2, $3) }
  | SYMB41 variation variation { PtnMultiply ($2, $3) }
  | SYMB42 variation variation { PtnJuxtapose ($2, $3) }
  | SYMB43 variation variation { PtnNegate ($2, $3) }
;

variation : uIdent { Atomic $1 } 
  | wild { Abandon $1 }
  | SYMB44 expr SYMB45 { Transcription $2 }
;

lyst : SYMB46 SYMB47 { Empty  } 
  | SYMB46 pattern_list SYMB47 { Enum $2 }
  | SYMB46 pattern_list SYMB7 lyst SYMB47 { Cons ($2, $4) }
  | SYMB46 pattern_list SYMB7 variation SYMB47 { ConsV ($2, $4) }
;

value : duality { BooleanLiteral $1 } 
  | string { StringLiteral $1 }
  | int { IntegerLiteral $1 }
  | float { DoubleLiteral $1 }
  | SYMB48 expr SYMB48 { Reification $2 }
;

duality : TOK_true { Verity  } 
  | TOK_false { Absurdity  }
;

symbol : lIdent { Tag $1 } 
;

expr2_list : expr2 { (fun x -> [x]) $1 } 
  | expr2 expr2_list { (fun (x,xs) -> x::xs) ($1, $2) }
;

pattern_list : pattern { (fun x -> [x]) $1 } 
  | pattern SYMB49 pattern_list { (fun (x,xs) -> x::xs) ($1, $3) }
;

binding_list : /* empty */ { []  } 
  | binding { (fun x -> [x]) $1 }
  | binding SYMB49 binding_list { (fun (x,xs) -> x::xs) ($1, $3) }
;


string : TOK_String { $1 };
int :  TOK_Integer  { $1 };
float : TOK_Double  { $1 };
uIdent : TOK_UIdent { UIdent ($1)};
lIdent : TOK_LIdent { LIdent ($1)};
wild : TOK_Wild { Wild ($1)};


