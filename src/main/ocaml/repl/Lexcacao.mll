(* This ocamllex file was machine-generated by the BNF converter *)
{
open Parcacao
open Lexing

let symbol_table = Hashtbl.create 64
let _ = List.iter (fun (kwd, tok) -> Hashtbl.add symbol_table kwd tok)
                  [("|-", SYMB1);(":", SYMB2);("|=", SYMB3);(":!", SYMB4);(":?", SYMB5);(";", SYMB6);(";;", SYMB7);("=", SYMB8);("->", SYMB9);("(", SYMB10);(")", SYMB11);("|", SYMB12);("<", SYMB13);(">", SYMB14);("<=", SYMB15);(">=", SYMB16);("!", SYMB17);("/", SYMB18);("+", SYMB19);("*", SYMB20);("::", SYMB21);("-", SYMB22);("<-", SYMB23);("@Seq", SYMB24);("@App", SYMB25);("@Let", SYMB26);("@Letrec", SYMB27);("@Abs", SYMB28);("@Cond", SYMB29);("@SelectFrom", SYMB30);("@From", SYMB31);("@SelectFromWhere", SYMB32);("@FromWhere", SYMB33);("@Equate", SYMB34);("@CompLT", SYMB35);("@CompGT", SYMB36);("@CompLTE", SYMB37);("@CompGTE", SYMB38);("@Unquote", SYMB39);("@Newprompt", SYMB40);("@Suspend", SYMB41);("@Release", SYMB42);("@SuspendSub", SYMB43);("@Divide", SYMB44);("@Add", SYMB45);("@Multiply", SYMB46);("@Juxtapose", SYMB47);("@Negate", SYMB48);("`", SYMB49);("'", SYMB50);("[", SYMB51);("]", SYMB52);("<<", SYMB53);(">>", SYMB54);("&", SYMB55);("=>", SYMB56);("~", SYMB57);(":pwd", SYMB58);(":cd", SYMB59);(":exit", SYMB60);(":type", SYMB61);(":desugar", SYMB62);(":parse", SYMB63);(",", SYMB64)]

let resword_table = Hashtbl.create 21
let _ = List.iter (fun (kwd, tok) -> Hashtbl.add resword_table kwd tok)
                  [("F", TOK_F);("T", TOK_T);("bool", TOK_bool);("else", TOK_else);("false", TOK_false);("float", TOK_float);("from", TOK_from);("fun", TOK_fun);("if", TOK_if);("in", TOK_in);("int", TOK_int);("let", TOK_let);("newP", TOK_newP);("pushP", TOK_pushP);("pushSC", TOK_pushSC);("rec", TOK_rec);("string", TOK_string);("takeSC", TOK_takeSC);("then", TOK_then);("true", TOK_true);("yield", TOK_yield)]


let unescapeInitTail (s:string) : string =
  let rec unesc s = match s with
      '\\'::c::cs when List.mem c ['\"'; '\\'; '\''] -> c :: unesc cs
    | '\\'::'n'::cs  -> '\n' :: unesc cs
    | '\\'::'t'::cs  -> '\t' :: unesc cs
    | '\"'::[]    -> []
    | c::cs      -> c :: unesc cs
    | _         -> []
  (* explode/implode from caml FAQ *)
  in let explode (s : string) : char list =
      let rec exp i l =
        if i < 0 then l else exp (i - 1) (s.[i] :: l) in
      exp (String.length s - 1) []
  in let implode (l : char list) : string =
      let res = String.create (List.length l) in
      let rec imp i = function
      | [] -> res
      | c :: l -> res.[i] <- c; imp (i + 1) l in
      imp 0 l
  in implode (unesc (List.tl (explode s)))

let incr_lineno (lexbuf:Lexing.lexbuf) : unit =
    let pos = lexbuf.lex_curr_p in
        lexbuf.lex_curr_p <- { pos with
            pos_lnum = pos.pos_lnum + 1;
            pos_bol = pos.pos_cnum;
        }
}

let l = ['a'-'z' 'A'-'Z' '\192' - '\255'] # ['\215' '\247']    (*  isolatin1 letter FIXME *)
let c = ['A'-'Z' '\192'-'\221'] # ['\215']    (*  capital isolatin1 letter FIXME *)
let s = ['a'-'z' '\222'-'\255'] # ['\247']    (*  small isolatin1 letter FIXME *)
let d = ['0'-'9']                (*  digit *)
let i = l | d | ['_' '\'']          (*  identifier character *)
let u = ['\000'-'\255']           (* universal: any character *)
let rsyms =    (* reserved words consisting of special symbols *)
            "|-" | ":" | "|=" | ":!" | ":?" | ";" | ";;" | "=" | "->" | "(" | ")" | "|" | "<" | ">" | "<=" | ">=" | "!" | "/" | "+" | "*" | "::" | "-" | "<-" | "@Seq" | "@App" | "@Let" | "@Letrec" | "@Abs" | "@Cond" | "@SelectFrom" | "@From" | "@SelectFromWhere" | "@FromWhere" | "@Equate" | "@CompLT" | "@CompGT" | "@CompLTE" | "@CompGTE" | "@Unquote" | "@Newprompt" | "@Suspend" | "@Release" | "@SuspendSub" | "@Divide" | "@Add" | "@Multiply" | "@Juxtapose" | "@Negate" | "`" | "'" | "[" | "]" | "<<" | ">>" | "&" | "=>" | "~" | ":pwd" | ":cd" | ":exit" | ":type" | ":desugar" | ":parse" | ","

rule token = 
    parse "//" (_ # '\n')*  { token lexbuf } (* Toss single line comments *)
        | "/*" ((u # ['*']) | '*' (u # ['/']))* ('*')+ '/' { token lexbuf } 

        | "(*" ((u # ['*']) | '*' (u # [')']))* ('*')+ ')' { token lexbuf } 

        | l i* {let id = lexeme lexbuf in try Hashtbl.find resword_table id with Not_found -> TOK_Ident id}
        | rsyms {let id = lexeme lexbuf in try Hashtbl.find symbol_table id with Not_found -> failwith ("internal lexer error: reserved symbol " ^ id ^ " not found in hashtable")}
        | d+ {let i = lexeme lexbuf in TOK_Integer (int_of_string i)}
        | d+ '.' d+ ('e' ('-')? d+)? {let f = lexeme lexbuf in TOK_Double (float_of_string f)}
        | '\"' ((u # ['\"' '\\' '\n']) | ('\\' ('\"' | '\\' | '\'' | 'n' | 't')))* '\"' {let s = lexeme lexbuf in TOK_String (unescapeInitTail s)}
        | [' ' '\t'] {token lexbuf}
        | '\n' {incr_lineno lexbuf; token lexbuf}
        | eof { TOK_EOF }
