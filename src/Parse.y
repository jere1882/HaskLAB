{
module Parse where
import Common
import Data.Char
import Data.Maybe
}

%monad { P } { thenP } { returnP }
%name parseStmt Com
%name parseStmts Defs
%name term Exp
%tokentype { Token }
%lexer {lexer} {TEOF}

%token 
      DEF             { TokenDef }
      PLOT            { TokenPlot }
      DISP            { TokenDisp }
      DERIVATE        { TokenDerivate }
      HDERIVATE       { TokenHDerivate }
      COMPOSE         { TokenCompose }
      BISECTION       { TokenBisection }
      EVAL            { TokenEval } 
      REGULAFALSI     { TokenRegulaFalsi }
      NEWTONRAPHSON   { TokenNewtonRaphson }
      HNEWTONRAPHSON  { TokenHNewtonRaphson }
      SECANTE         { TokenSecante }
      HSECANTE        { TokenHSecante }
      TRAPECIO        { TokenTrapecio }
      TRAPECIOC       { TokenTrapecioc }
      SIMPSON         { TokenSimpson }
      SIMPSONC        { TokenSimpsonc }
      TAYLOR          { TokenTaylor }
      INTERPOLACIONL  { TokenInterpolacionL }
      INTERPOLACIONN  { TokenInterpolacionN }
      CHEBYSHEV       { TokenChebyshev }
      '='             { TokenEquals }
      real            { TokenReal $$ }
      id              { TokenId $$ }
      var             { TokenVar }
      '+'             { TokenPlus }
      '-'             { TokenMinus }
      '*'             { TokenTimes }
      '/'             { TokenDiv }
      '^'             { TokenPower }
      '('             { TokenOB }
      ')'             { TokenCB }
      ','             { TokenComma }
      '['             { TokenOC }      
      ']'             { TokenCC }      
      acos            { TokenAcos } 
      cosh            { TokenCosh }
      cos             { TokenCos }
      asin            { TokenAsin }
      sinh            { TokenSinh }
      sin             { TokenSin }
      atan            { TokenAtan}
      tanh            { TokenTanh }
      tan             { TokenTan }
      log             { TokenLog }

      
%%


Def     : DEF id '(' var ')' '=' Exp          { Def $2 $7 } 

Com     : Def                                           { $1 }
        | DISP id                                       { Disp $2 }
        | PLOT '[' FList ']' Real Real Real             { Plot $3 $5 $6 $7 }
        | PLOT id  Real Real Real                       { Plot [$2] $3 $4 $5 }
        | DERIVATE id                                   { Derivate $2 }
        | HDERIVATE id Real Real                        { HDerivate $2 $3 $4}
        | COMPOSE id id                                 { Compose $2 $3 }
        | BISECTION id Real Real Real                   { Bisection $2 $3 $4 $5}
        | EVAL id Real                                  { Eval $2 $3 } 
        | REGULAFALSI id Real Real Real Real Real       { RegulaFalsi $2 $3 $4 $5 $6 (double2int $7)}
        | NEWTONRAPHSON id id Real Real Real Real       { NewtonRaphson $2 $3 $4 $5 $6 (double2int $7) }
        | HNEWTONRAPHSON id Real Real Real Real Real    { HNewtonRaphson $2 $3 $4 $5 $6 (double2int $7)}
        | SECANTE id id Real Real Real Real Real        { Secante $2 $3 $4 $5 $6 $7 (double2int $8)}
        | HSECANTE id Real Real Real Real Real  Real    { HSecante $2 $3 $4 $5 $6 $7 (double2int $8)}
        | TRAPECIO id Real Real                         { Trapecio $2 $3 $4}
        | TRAPECIOC id Real Real Real                   { TrapecioC $2 $3 $4 (double2int $5)}
        | SIMPSON id Real Real                          { Simpson $2 $3 $4}
        | SIMPSONC id Real Real Real                    { SimpsonC $2 $3 $4 (double2int $5)}
        | TAYLOR id Real Real Real                      { Taylor $2 $3 $4 (double2int $5)} 
        | INTERPOLACIONL id '[' RList ']'               { InterpolacionL $2 $4}
        | INTERPOLACIONN id '[' RList ']'               { InterpolacionN $2 $4}
        | CHEBYSHEV id Real Real Real                   { Chebyshev $2 $3 $4 (double2int $5)}


Real  : '-' real                { (- $2) }
      | '(' Real ')'            { $2 }
      | real                    { $1 }      

RList : Real ',' RList          { $1 : $3 }
      | Real                    { [$1] }

FList   : id ',' FList                 { $1 : $3}
        | id                           { [$1] }


Defs    : Def Defs                     { $1 : $2 }
        |                              { [] }


Exp   : Exp '+' Term           { FSum $1 $3 }
      | Exp '-' Term           { FDif $1 $3 }
      | Term                   { $1 }

Term  : Term '*' Factor         { FMul $1 $3 }
      | Term '/' Factor         { FCoc $1 $3 }
      | '-' Term                { FUmin $2 } 
      | Factor                  { $1 }

Factor : Factor '^' Factor1     { FPot $1 $3 }
       | Factor1                { $1 } 

Factor1 : cosh Factor1          { FCosh $2 }
        | sinh Factor1          { FSinh $2 }
        | tanh Factor1          { FTanh $2 }
        | cos Factor1           { FCos $2 }
        | sin Factor1           { FSin $2 }
        | tan Factor1           { FTan $2 }
        | acos Factor1          { FAcos $2 }
        | asin Factor1          { FAsin $2 }
        | atan Factor1          { FAtan $2 }        
        | log Factor1           { FLog $2 }  
        | Atom                  { $1 }
        
Atom  : real                    { FConst $1 }
      | id '(' Exp ')'          { FId $1 $3 }
      | var                     { FVar }
      | '(' Exp ')'             { $2 }
      
      
{


data ParseResult a = Ok a | Failed String
                     deriving Show                     
type LineNumber = Int
type P a = String -> LineNumber -> ParseResult a

getLineNo :: P LineNumber
getLineNo = \s l -> Ok l

thenP :: P a -> (a -> P b) -> P b
m `thenP` k = \s l-> case m s l of
                         Ok a     -> k a s l
                         Failed e -> Failed e
                         
returnP :: a -> P a
returnP a = \s l-> Ok a

failP :: String -> P a
failP err = \s l -> Failed err

catchP :: P a -> (String -> P a) -> P a
catchP m k = \s l -> case m s l of
                        Ok a     -> Ok a
                        Failed e -> k e s l

happyError :: P a
happyError = \ s i -> Failed $ "Línea "++(show (i::LineNumber))++": Error de parseo\n"++(s)

double2int :: Double -> Int
double2int x = round x

-------------
      
data Token
      = TokenReal Double
      | TokenId String
      | TokenVar
      | TokenPlus
      | TokenMinus
      | TokenTimes
      | TokenDiv
      | TokenPower     
      | TokenOB
      | TokenCB
      | TokenCos
      | TokenSin
      | TokenTan
      | TokenCosh
      | TokenSinh
      | TokenTanh
      | TokenLog
      | TokenAtan
      | TokenAsin
      | TokenAcos
      | TokenDef   
      | TokenEquals
      | TokenPlot
      | TokenDisp
      | TokenDerivate
      | TokenHDerivate
      | TokenCompose
      | TokenBisection
      | TokenHNewtonRaphson 
      | TokenNewtonRaphson 
      | TokenRegulaFalsi
      | TokenSecante
      | TokenHSecante
      | TokenEval
      | TokenCC
      | TokenOC
      | TokenComma
      | TEOF 
      | TokenTrapecio 
      | TokenTrapecioc 
      | TokenSimpson 
      | TokenSimpsonc 
      | TokenTaylor 
      | TokenInterpolacionL 
      | TokenInterpolacionN 
      | TokenChebyshev 
 deriving Show
-----------------------------

lexer cont s = case s of
            [] -> cont TEOF []
            ('\n':s)  ->  \line -> lexer cont s (line + 1)
            (c:cs)
                  | isSpace c -> lexer cont cs
                  | isAlpha c -> lexVar (c:cs) cont
                  | isDigit c -> lexNum (c:cs) cont
            ('-':('-':cs)) -> lexer cont $ dropWhile ((/=) '\n') cs
            ('{':('-':cs)) -> consumirBK 0 0 cont cs    
            ('-':('}':cs)) -> \ line -> Failed $ "Línea "++(show line)++": Comentario no abierto"
            ('^':cs) -> cont TokenPower cs
            ('+':cs) -> cont TokenPlus cs
            ('-':cs) -> cont TokenMinus cs
            ('*':'*':cs) -> cont TokenPower cs
            ('*':cs) -> cont TokenTimes cs
            ('/':cs) -> cont TokenDiv cs
            ('(':cs) -> cont TokenOB cs
            (')':cs) -> cont TokenCB cs
            ('=':cs) -> cont TokenEquals cs
            (',':cs) -> cont TokenComma cs
            ('[':cs) -> cont TokenOC cs
            (']':cs) -> cont TokenCC cs
            unknown -> \line -> Failed $ "Línea "++(show line)++": No se puede reconocer "++(show $ take 10 unknown)++ "..."
            where consumirBK anidado cl cont s = case s of
                                                      ('-':('-':cs)) -> consumirBK anidado cl cont $ dropWhile ((/=) '\n') cs
                                                      ('{':('-':cs)) -> consumirBK (anidado+1) cl cont cs   
                                                      ('-':('}':cs)) -> case anidado of
                                                                         0 -> \line -> lexer cont cs (line+cl)
                                                                         _ -> consumirBK (anidado-1) cl cont cs
                                                      ('\n':cs) -> consumirBK anidado (cl+1) cont cs
                                                      (_:cs) -> consumirBK anidado cl cont cs   
                                    
                                    
lexNum cs cont = cont (TokenReal(read num)) rest'
      where (ent,rest) = span isDigit cs
            (frac,rest') = if (is_point rest) then (span isDigit (tail rest)) else ("0",rest)
            num = ent ++ "." ++ frac
            is_point (x:xs) | x=='.' = True
            is_point _               = False  
              
lexVar cs cont =
   case span (\c -> isAlpha c || c=='_' || c=='\'') cs of
      ("e",rest)    -> cont (TokenReal (2.71828182846)) rest
      ("pi",rest)   -> cont (TokenReal (3.14159265259)) rest
      ("cosh",rest) -> cont TokenCosh rest
      ("sinh",rest) -> cont TokenSinh rest
      ("senh",rest) -> cont TokenSinh rest
      ("tanh",rest) -> cont TokenTanh rest
      ("cos",rest) -> cont TokenCos rest
      ("sin",rest) -> cont TokenSin rest
      ("sen",rest) -> cont TokenSin rest
      ("tan",rest) -> cont TokenTan rest
      ("tg",rest)  -> cont TokenTan rest
      ("acos",rest) -> cont TokenAcos rest
      ("asin",rest) -> cont TokenAsin rest
      ("asen",rest) -> cont TokenAsin rest
      ("atan",rest) -> cont TokenAtan rest
      ("log",rest) -> cont TokenLog rest
      ("ln",rest)  -> cont TokenLog rest
      ("def",rest) -> cont TokenDef  rest
      ("plot",rest) -> cont TokenPlot  rest
      ("disp",rest) -> cont TokenDisp  rest
      ("compose",rest) -> cont TokenCompose rest
      ("eval",rest) -> cont TokenEval  rest      
      ("derivate",rest) -> cont TokenDerivate rest
      ("hderivate",rest) -> cont TokenHDerivate rest      
      ("bisection",rest) -> cont TokenBisection rest
      ("regula_falsi",rest) -> cont TokenRegulaFalsi rest
      ("newton_raphson",rest) -> cont TokenNewtonRaphson  rest
      ("hnewton_raphson",rest) -> cont TokenHNewtonRaphson  rest
      ("secante",rest) -> cont TokenSecante rest
      ("hsecante",rest) -> cont TokenHSecante rest
      ("x",rest) -> cont TokenVar rest
      ("trapecio",rest) -> cont  TokenTrapecio rest
      ("trapecio_compuesto",rest) -> cont  TokenTrapecioc rest
      ("simpson",rest) -> cont  TokenSimpson rest
      ("simpson_compuesto",rest) -> cont  TokenSimpsonc rest
      ("taylor",rest) -> cont  TokenTaylor rest
      ("interpolacion_lagrange",rest) -> cont  TokenInterpolacionL rest
      ("interpolacion_newton",rest) -> cont  TokenInterpolacionN rest
      ("chebyshev",rest) -> cont  TokenChebyshev rest      
      (id,rest)     -> cont (TokenId id)  rest
---------     
stmts_parse s = parseStmts s 1
stmt_parse s = parseStmt s 1
term_parse s = term s 1    

}
