/* This ocamlyacc file was machine-generated by the BNF converter */
%{
open Absdavinci
open Lexing
%}

%token TOK_case TOK_false TOK_for TOK_switch TOK_true

%token SYMB1 /* { */
%token SYMB2 /* } */
%token SYMB3 /* * */
%token SYMB4 /* ( */
%token SYMB5 /* ) */
%token SYMB6 /* | */
%token SYMB7 /* !? */
%token SYMB8 /* !! */
%token SYMB9 /* => */
%token SYMB10 /* <- */
%token SYMB11 /* ?? */
%token SYMB12 /* ?! */
%token SYMB13 /* @ */
%token SYMB14 /* ' */
%token SYMB15 /* [ */
%token SYMB16 /* ] */
%token SYMB17 /* ; */
%token SYMB18 /* , */

%token TOK_EOF
%token <string> TOK_Ident
%token <string> TOK_String
%token <int> TOK_Integer
%token <float> TOK_Double
%token <char> TOK_Char
%token <string> TOK_UIdent
%token <string> TOK_LIdent
%token <string> TOK_Wild

%start pAgent pGuardedAgent pAbstraction pConcretion pBinding pPattern pChannel pSymbol pVariation pInformation pLyst pValue pDuality pAgent_list pGuardedAgent_list pPattern_list pBinding_list
%type <Absdavinci.agent> pAgent
%type <Absdavinci.guardedAgent> pGuardedAgent
%type <Absdavinci.abstraction> pAbstraction
%type <Absdavinci.concretion> pConcretion
%type <Absdavinci.binding> pBinding
%type <Absdavinci.pattern> pPattern
%type <Absdavinci.channel> pChannel
%type <Absdavinci.symbol> pSymbol
%type <Absdavinci.variation> pVariation
%type <Absdavinci.information> pInformation
%type <Absdavinci.lyst> pLyst
%type <Absdavinci.value> pValue
%type <Absdavinci.duality> pDuality
%type <Absdavinci.agent list> pAgent_list
%type <Absdavinci.guardedAgent list> pGuardedAgent_list
%type <Absdavinci.pattern list> pPattern_list
%type <Absdavinci.binding list> pBinding_list


%%
pAgent : agent TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pGuardedAgent : guardedAgent TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pAbstraction : abstraction TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pConcretion : concretion TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pBinding : binding TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pPattern : pattern TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pChannel : channel TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pSymbol : symbol TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pVariation : variation TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pInformation : information TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pLyst : lyst TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pValue : value TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pDuality : duality TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pAgent_list : agent_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pGuardedAgent_list : guardedAgent_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pPattern_list : pattern_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };

pBinding_list : binding_list TOK_EOF { $1 }
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) };


agent : SYMB1 agent_list SYMB2 { Composition $2 } 
  | TOK_switch SYMB1 guardedAgent_list SYMB2 { Superposition $3 }
  | SYMB3 channel { Replication $2 }
  | TOK_for SYMB4 binding_list SYMB5 agent { Reception ($3, $5) }
  | TOK_for SYMB4 binding_list SYMB6 pattern_list SYMB5 agent { Filtration ($3, $5, $7) }
  | variation SYMB7 SYMB4 concretion SYMB5 { Intimation ($1, $4) }
  | variation SYMB8 SYMB4 concretion SYMB5 { Transmission ($1, $4) }
  | value { Actualization $1 }
;

guardedAgent : TOK_case pattern SYMB9 agent { Injection ($2, $4) } 
;

abstraction : SYMB4 variation SYMB5 agent { Applicant ($2, $4) } 
;

concretion : SYMB4 information SYMB5 { Applicand $2 } 
;

binding : pattern SYMB10 channel SYMB11 SYMB4 pattern SYMB5 { Question ($1, $3, $6) } 
  | pattern SYMB10 channel SYMB12 SYMB4 pattern SYMB5 { Interrogation ($1, $3, $6) }
;

pattern : symbol SYMB4 pattern_list SYMB5 { Element ($1, $3) } 
  | variation { Variable $1 }
  | value { Materialization $1 }
  | lyst { Procession $1 }
;

channel : lIdent { Identification $1 } 
  | variation { Nomination $1 }
  | SYMB13 SYMB14 agent SYMB14 { Transcription $3 }
;

symbol : lIdent { Tag $1 } 
;

variation : uIdent { Atomic $1 } 
;

information : variation { Indirection $1 } 
  | agent { Reflection $1 }
;

lyst : SYMB15 SYMB16 { Empty  } 
  | SYMB15 pattern_list SYMB16 { Enum $2 }
  | SYMB15 pattern_list SYMB6 lyst SYMB16 { Cons ($2, $4) }
  | SYMB15 pattern_list SYMB6 variation SYMB16 { ConsV ($2, $4) }
;

value : duality { BooleanLiteral $1 } 
  | string { StringLiteral $1 }
  | int { IntegerLiteral $1 }
  | float { DoubleLiteral $1 }
  | SYMB13 SYMB14 agent SYMB14 { Reification $3 }
;

duality : TOK_true { Verity  } 
  | TOK_false { Absurdity  }
;

agent_list : /* empty */ { []  } 
  | agent { (fun x -> [x]) $1 }
  | agent SYMB17 agent_list { (fun (x,xs) -> x::xs) ($1, $3) }
;

guardedAgent_list : /* empty */ { []  } 
  | guardedAgent { (fun x -> [x]) $1 }
  | guardedAgent SYMB17 guardedAgent_list { (fun (x,xs) -> x::xs) ($1, $3) }
;

pattern_list : pattern { (fun x -> [x]) $1 } 
  | pattern SYMB18 pattern_list { (fun (x,xs) -> x::xs) ($1, $3) }
;

binding_list : /* empty */ { []  } 
  | binding { (fun x -> [x]) $1 }
  | binding SYMB17 binding_list { (fun (x,xs) -> x::xs) ($1, $3) }
;


string : TOK_String { $1 };
int :  TOK_Integer  { $1 };
float : TOK_Double  { $1 };
uIdent : TOK_UIdent { UIdent ($1)};
lIdent : TOK_LIdent { LIdent ($1)};
wild : TOK_Wild { Wild ($1)};


