module Printer (
       printFunc
       )
       where

    import Common
    import RealFc
    
         
    printFunc FVar        = "x"     
    printFunc (FConst c)  = let (int,frac) = divide c
                            in if frac=="0" then int
                                            else show c
    printFunc (FSum f g)  = printFunc f ++ "+" ++ printFunc g
    printFunc (FDif f g)  = if noPar g then printFunc f ++ "-" ++printFunc g
                                       else printFunc f ++ "-(" ++ printFunc g ++ ")"
    printFunc (FMul f g)  = if noPar f && noPar g then printFunc f ++ " . " ++ printFunc g
                            else if noPar f then printFunc f ++ ".(" ++ printFunc g ++ ")"
                            else if noPar g then ("(" ++ printFunc f ++ ")." ++ printFunc g)
                            else "(" ++ printFunc f ++ ").(" ++ printFunc g ++ ")"
    printFunc (FCoc f g)  = if noPar f && noPar g then printFunc f ++ "/" ++printFunc g
                            else if noPar f then printFunc f ++ "/(" ++ printFunc g ++ ")"
                            else if noPar g then "(" ++ printFunc f ++ ")/" ++ printFunc g
                            else "(" ++ printFunc f ++ ")/(" ++ printFunc g ++ ")"
                            
    printFunc (FPot f g)  = if noPar f && noPar g then printFunc f ++ "^" ++printFunc g
                            else if noPar f then printFunc f ++ "^(" ++ printFunc g ++ ")"
                            else if noPar g then "(" ++ printFunc f ++ ")^" ++ printFunc g
                            else "(" ++ printFunc f ++ ")^(" ++ printFunc g ++ ")"   
    printFunc (FCos f)    =  "cos(" ++ printFunc f ++ ")"
    printFunc (FSin f)    =  "sin(" ++ printFunc f ++ ")"
    printFunc (FTan f)    =  "tan(" ++ printFunc f ++ ")"
    printFunc (FCosh f)   =  "cosh(" ++ printFunc f ++ ")"
    printFunc (FSinh f)   =  "sinh(" ++ printFunc f ++ ")"
    printFunc (FTanh f)   =  "tanh(" ++ printFunc f ++ ")"       
    printFunc (FLog f)    =  "log(" ++ printFunc f ++ ")"
    printFunc (FAsin f)   =  "asin(" ++ printFunc f ++ ")"
    printFunc (FAcos f)   =  "acos(" ++ printFunc f ++ ")"
    printFunc (FAtan f)   =  "atan(" ++ printFunc f ++ ")"
    printFunc (FUmin f)   =  if noPar f then "-"++printFunc f
                                        else "-("++printFunc f++")"
    printFunc (FId xs f)    = xs++"("++printFunc f++")" -- nunca se va a llamar.

    divide :: Double -> (String,String)
    divide n = let (int,frac) = break (\c->c=='.') (show n)
               in (int, if null frac then "" else tail frac)

    -- funcion para ver cuando puedo obviar paréntesis
    noPar (FSum _ _ )  = False
    noPar (FMul _ _ )  = False
    noPar (FDif _ _ )  = False
    noPar (FPot _ _ )  = False
    noPar (FUmin _ )   = False
    noPar (FCoc _ _ )  = False
    noPar _            = True
 
