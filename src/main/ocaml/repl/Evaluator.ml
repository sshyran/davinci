(* -*- mode: Tuareg;-*-  *)
(* Filename:    Evaluator.ml  *)
(* Authors:     lgm                                                     *)
(* Creation:    Thu Aug 21 10:37:32 2014  *)
(* Copyright:   Not supplied  *)
(* Description:  *)
(* ------------------------------------------------------------------------ *)

open Abscacao
open Environments
open Nominals
open Terms
open Values
open Continuations
open Exceptions
open Knot
open Monad

module rec Eval :
  functor ( Value : VALUES ) -> 
    functor ( Env : ENVIRONMENTS ) -> 
      functor ( Cont : CONTINUATIONS ) ->
        functor ( M : MONAD ) ->
sig
  type ident = ReflectiveNominal.nominal 
  type term = ReflectiveTerm.term
  type value = Value( ReflectiveNominal )( ReflectiveTerm )( Env ).value
  type 'a monad = 'a M.monad
  type env = ( ident, value ) Env.env
  type ktn = ( value, term ) Cont( ReflectiveNominal )( Env ).cont
      
  val reduce : term -> env -> ktn -> value monad
  val apply_closure : value -> value -> value
  val bottom : value
  val yunit : value
end =
  functor ( Value : VALUES ) -> 
    functor ( Env : ENVIRONMENTS ) -> 
      functor ( Cont : CONTINUATIONS ) ->
        functor ( M : MONAD ) ->
struct
  module RValue = Value( ReflectiveNominal )( ReflectiveTerm )( Env )
  module RCont = Cont( ReflectiveNominal )( Env )
  type ident = ReflectiveNominal.nominal
  type term = ReflectiveTerm.term
  type value = RValue.value
  type 'a monad = 'a M.monad
  type env = ( ident, value ) Env.env
  type ktn = ( value, term ) RCont.cont

  exception NonFunctionInOpPosition of value
      
  let bottom = RValue.BOTTOM
  let yunit = RValue.UNIT 

  let apply_closure op v =
    raise ( NotYetImplemented "apply_closure" )
  
  let rec reduce t e k =
    match t with 
        (* sequential composition *)
        ReflectiveTerm.Sequence( [] ) ->
          ( M.m_unit yunit ) 
      | ReflectiveTerm.Sequence( thd :: [] ) ->
          (reduce thd e k )
      | ReflectiveTerm.Sequence( thd :: ttl ) ->
          let _ = (reduce thd e k ) in 
          let rec loop ts =
            match ts with
                tshd :: [] -> (reduce tshd e k )
              | tshd :: tstl ->
                  let _ = (reduce tshd e k ) in
                    ( loop tstl )          
          in ( loop ttl )

      (* application *)
      | ReflectiveTerm.Application( op, [] ) ->
          ( M.m_bind
              ( reduce op e k )
              ( fun clsr ->
                match clsr with
                    RValue.Closure( _, _, _ ) ->
                      ( M.m_unit ( apply_closure clsr ReflectiveTerm.UNIT ) )
                  | _ -> raise ( NonFunctionInOpPosition clsr )
              )
          )
      | ReflectiveTerm.Application( op, actls ) ->
          let bind_reduce acc actual =
            ( M.m_bind 
                ( reduce actual e k )
                ( fun a ->  
                  ( M.m_bind acc
                      ( fun clsr ->
                        match clsr with 
                            RValue.Closure( _, _, _ ) -> ( M.m_unit ( apply_closure clsr a ) )
                          | _ -> raise ( NonFunctionInOpPosition clsr )
                      )
                  )
                ) 
            ) in
            ( List.fold_left bind_reduce ( reduce op e k ) actls )
            
      | ReflectiveTerm.Supposition( ptn, pterm, eterm ) ->
          raise ( NotYetImplemented "Supposition" )
      | ReflectiveTerm.Recurrence( ptn, pterm, eterm ) ->
          raise ( NotYetImplemented "Recurrence" )
      | ReflectiveTerm.Abstraction( ptn, eterm ) ->
          raise ( NotYetImplemented "Abstraction" )
      | ReflectiveTerm.Condition( test, tbranch, fbranch ) ->
          raise ( NotYetImplemented "Condition" )
      | ReflectiveTerm.Comprehension( bindings, eterm ) ->
          raise ( NotYetImplemented "Comprehension" )
      | ReflectiveTerm.Consolidation( bindings, eterm ) ->
          raise ( NotYetImplemented "Consolidation" )
      | ReflectiveTerm.Filtration( bindings, conditions, eterm ) ->
          raise ( NotYetImplemented "Filtration" )
      | ReflectiveTerm.Concentration( bindings, conditions, eterm ) ->
          raise ( NotYetImplemented "Concentration" )
      | ReflectiveTerm.Equation( lhs, rhs ) ->
          raise ( NotYetImplemented "Equation" )
      | ReflectiveTerm.ComparisonLT( lhs, rhs ) ->
          raise ( NotYetImplemented "ComparisonLT" )
      | ReflectiveTerm.ComparisonGT( lhs, rhs ) ->
          raise ( NotYetImplemented "ComparisonGT" )
      | ReflectiveTerm.ComparisonLTE( lhs, rhs ) ->
          raise ( NotYetImplemented "ComparisonLTE" )
      | ReflectiveTerm.ComparisonGTE( lhs, rhs ) ->
          raise ( NotYetImplemented "ComparisonGTE" )
      | ReflectiveTerm.Reflection( v ) ->
          raise ( NotYetImplemented "Reflection" )
      | ReflectiveTerm.Acquisition -> 
          raise ( NotYetImplemented "Acquisition" )
      | ReflectiveTerm.Suspension( pterm, eterm ) -> 
          raise ( NotYetImplemented "Suspension" )
      | ReflectiveTerm.Release( pterm, eterm ) -> 
          raise ( NotYetImplemented "Release" )
      | ReflectiveTerm.InnerSuspension( pterm, eterm ) -> 
          raise ( NotYetImplemented "InnerSuspension" )
      | ReflectiveTerm.Calculation( aterm ) -> 
          raise ( NotYetImplemented "Calculuation" )   
end
(* This gives a simple and effective form of reflection for quasiquote *)
and ReflectiveNominal : NOMINALS = NOMINAL( ReflectiveTerm )
and ReflectiveTerm : TERMS = TERM( ReflectiveNominal ) 
