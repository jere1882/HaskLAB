module Common where

------------------------------------------------------------------------
-- Comandos identificados por el parser de comandos.
    data Stmt i = Def String i          
                | Plot [String] Double Double Double
                | Disp String
                | Derivate String
                | HDerivate String Double Double
                | Compose String String
                | Bisection String Double Double Double
                | Eval String Double
                | RegulaFalsi String Double Double Double Double Int
                | NewtonRaphson String String Double Double Double Int
                | HNewtonRaphson String Double Double Double Double Int
                | Secante String String Double Double Double Double Int
                | HSecante String Double Double Double Double Double Int
                | Trapecio String Double Double 
                | TrapecioC String Double Double Int
                | Simpson String Double Double 
                | SimpsonC String Double Double Int
                | Taylor String Double Double Int 
                | InterpolacionL String [Double]
                | InterpolacionN String [Double]
                | Chebyshev String Double Double Int
        deriving (Show)

    type NameEnv t = [(String,t)]
------------------------------------------------------------------------
-- Funciones de R -> R
    data FReal = FConst Double 
                | FVar           
                | FUmin FReal
                | FSum FReal FReal
                | FDif FReal FReal
                | FMul FReal FReal
                | FCoc FReal FReal
                | FPot FReal FReal  
                | FSin FReal
                | FCos FReal
                | FTan FReal
                | FSinh FReal
                | FCosh FReal
                | FTanh FReal
                | FAsin FReal
                | FAtan FReal
                | FAcos FReal
                | FLog FReal
                | FId String FReal    -- Para parsear algo como f(x) = g(x**2)+2
          deriving (Eq,Show)

------------------------------------------------------------------------
--Mónada para trabajar con métodos numéricos
 
    data Code = Empty | Maxit | Delta | Epsilon | Reached  deriving (Show,Eq)
    data NumMonad e a = E e Int | R Int a Code  deriving Show 


    cause :: Code -> String
    cause Empty   = "?"
    cause Maxit   = "Se alcanzó el número máximo de iteraciones"
    cause Delta   = "Se alcanzó la tolerancia deseada en el eje x"
    cause Epsilon = "Se alcanzó la tolerancia deseada en el eje y"
    cause Reached = "Se halló la raíz exacta*" -- En aritmética de punto flotante.  
    
    instance Monad (NumMonad e) where            
        return x           = R 0 x Empty
        (E e ni) >>= f = E e ni
        (R ni x code)   >>= f = case (f x) of
                                (E e ni)        -> E e ni
                                (R ni' x' code') -> R (ni + ni') x' (if code==Empty then code' else code)
                                

        
    raise :: String -> NumMonad String a
    raise msg = E msg 0
    
    tick :: NumMonad String ()
    tick = R 1 () Empty
    
    set_code :: Code -> NumMonad String ()
    set_code c = R 0 () c
    
    remove :: NumMonad e a -> a
    remove (R _ x _ ) = x
    
------------------------------------------------------------------------
