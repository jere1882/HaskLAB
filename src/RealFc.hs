module RealFc (
       eval,        -- evalua una funcion en un punto
       seval,       -- evaluacion sencilla (sin manejo de errores, etc)
       derivate,    -- calcula la funcion derivada de otra funcion
       simplificar_ceros,
       hderivate,    -- aproxima la derivada de una funcion en un punto
       shderivate,    -- derivacion sencilla (sin manejo de errores, etc)
       composition    -- compone dos funciones
       ) 
       where 
    
import Common

------------------------------------------------------------------------
--Evaluación de una función en un punto

eval :: FReal -> Double -> NumMonad String Double
eval (FConst c)  _  = return c
eval FVar   x       = return x
eval (FSum f g ) x  = do fv <- eval f x
                         gv <- eval g x
                         return (fv + gv)
eval (FDif f g ) x  = do fv <- eval f x
                         gv <- eval g x
                         return (fv - gv)
eval (FMul f g ) x  = do fv <- eval f x
                         gv <- eval g x
                         return (fv * gv)
eval (FCoc f g ) x  = do fv <- eval f x
                         gv <- eval g x
                         if fv==0 && gv==0 then raise "Cero sobre cero"
                         else if gv == 0 then raise "Divisón por cero."    
                         else return (fv / gv)
eval (FPot f g ) x  = do fv <- eval f x
                         gv <- eval g x
                         if (isNaN  $ fv**gv) then raise "Potencia ilegal"  -- por ejemplo (-1)**(0.5) 
                                              else return (fv ** gv)
eval (FSin f)    x  = do fv <- eval f x
                         return (sin fv)
eval (FCos f)    x  = do fv <- eval f x
                         return (cos fv)                         
eval (FTan f)    x  = do fv <- eval f x
                         return (tan fv)        
eval (FSinh f)   x  = do fv <- eval f x
                         return (sinh fv)
eval (FCosh f)   x  = do fv <- eval f x
                         return (cosh fv)         
eval (FTanh f)   x  = do fv <- eval f x
                         return (tanh fv)                  
eval (FLog f)    x  = do fv <- eval f x
                         if (fv<=0) then raise "Log espera argumentos positivos"
                                    else return (log fv)      
eval (FUmin f ) x   = do fv <- eval f x
                         return (-fv)   
eval (FAtan f) x    = do fv <- eval f x
                         return (atan fv)
eval (FAcos f) x    = do fv <- eval f x
                         if (fv < -1 || fv > 1) then raise "Acos sólo está definida en [-1,1]."
                                                else return (acos fv)
eval (FAsin f) x    = do fv <- eval f x
                         if (fv < -1 || fv>1) then raise "Asin sólo está definida en [-1,1]."
                                              else return (asin fv)
                         
------------------------------------------------------------------------

seval :: FReal -> Double -> Double
seval (FConst c)  _  =  c
seval FVar   x       =  x
seval (FSum f g ) x  = (seval f x)  + (seval g x)
seval (FDif f g ) x  = (seval f x) - (seval g x)
seval (FMul f g ) x  = (seval f x) * (seval g x)
seval (FCoc f g ) x  = (seval f x) / (seval g x)
seval (FPot f g ) x  = (seval f x) ** (seval g x)
seval (FSin f)    x  = sin $ seval f x
seval (FCos f)    x  = cos $ seval f x                         
seval (FTan f)    x  = tan  $ seval f x       
seval (FSinh f)   x  = sinh $ seval f x
seval (FCosh f)   x  = cosh $ seval f x       
seval (FTanh f)   x  = tanh $ seval f x                      
seval (FLog f)    x  = log  $ seval f x     
seval (FUmin f ) x   = -(seval f x)   
seval (FAsin f)    x  = asin $ seval f x
seval (FAcos f)    x  = acos $ seval f x                         
seval (FAtan f)    x  = atan  $ seval f x       
------------------------------------------------------------------------
-- Cálculo de la derivada de una función.
derivate :: FReal -> FReal
derivate f = simplificar_ceros (derivate' f)

derivate' :: FReal -> FReal
derivate' (FConst c)   = FConst 0
derivate' (FVar)       = FConst 1
derivate' (FSum f g)   = FSum (derivate' f) (derivate' g)
derivate' (FDif f g)   = FDif (derivate' f) (derivate' g)
derivate' (FMul f g)   = let (f',g') = (derivate' f, derivate' g) in (FSum (FMul f g') (FMul g f'))
derivate' (FCoc f g)   = let (f',g')=(derivate' f, derivate' g) 
                         in FCoc ( FDif (FMul f' g) (FMul g' f) )  (FPot g (FConst 2))
derivate' h@(FPot f g) = let (f',g')=(derivate' f, derivate' g) 
                         in  FMul h  (FSum (FMul g' (FLog f) ) (FMul g (FCoc f' f)))

{- y = f ** g   (Derivación logarítmica)
  ln y = g * ln f
   => derivamos todo
   y'/y = g' ln f + g/f'
   => y' = [g' ln f + g*f'/f ] * f**g  -}

derivate' (FSin f)     = let f'=derivate' f in FMul f' (FCos f)
derivate' (FCos f)     = let f'=derivate' f in FMul f' (FUmin (FSin f))
derivate' (FTan f)     = let f'=derivate' f in FMul f' (FCoc (FConst 1) (FPot (FCos f) (FConst 2) ))
derivate' (FSinh f)    = let f'=derivate' f in FMul f' (FCosh f)
derivate' (FCosh f)    = let f'=derivate' f in FMul f' (FSinh f)
derivate' (FTanh f)    = let f'=derivate' f in FCoc f' (FPot (FCosh f) (FConst 2))
derivate' (FLog f)     = let f'=derivate' f in FMul f' (FCoc (FConst 1) f)
derivate' (FUmin f)    = let f'=derivate' f in FMul (FConst (-1)) f'
derivate' (FAsin f)    = let f'=derivate' f in FCoc f' (FPot (FDif (FConst 1) (FPot f (FConst 2))) (FConst 0.5))
derivate' (FAtan f)    = let f'=derivate' f in FUmin $ FCoc f' (FPot (FDif (FConst 1) (FPot f (FConst 2))) (FConst 0.5))
derivate' (FAcos f)    = let f'=derivate' f in FCoc f' (FSum (FConst 1) (FPot f (FConst 2)))
derivate' _            = error "(Derivate) Error: No se sabe calcular esta derivada."

------------------------------------------------------------------------
-- Simplifica multiplicaciones y sumas triviales.
simplificar_ceros :: FReal -> FReal
simplificar_ceros (FMul f g) = let (sf,sg) = (simplificar_ceros f, simplificar_ceros g)
                               in  if (sf==FConst 0) then (FConst 0)
                                   else if (sg==FConst 0) then (FConst 0)
                                        else (FMul sf sg)
simplificar_ceros (FCoc f g) = let (sf,sg) = (simplificar_ceros f, simplificar_ceros g)
                               in  (FCoc sf sg)  -- no simplifico por cuestiones de 0/0 /= 0  
simplificar_ceros (FSum f g) = let (sf,sg) = (simplificar_ceros f, simplificar_ceros g)
                               in  if (sf==FConst 0) then g
                                   else if (sg==FConst 0) then f
                                        else  (FSum sf sg)
simplificar_ceros (FPot f g) = let (sf,sg) = (simplificar_ceros f, simplificar_ceros g)
                               in  if (sf==FConst 0 && sg==FConst 0) then (FConst 1)
                                   else if (sf==FConst 0) then (FConst 0)
                                   else if (sg==FConst 0) then (FConst 1)
                                        else (FPot sf sg)
simplificar_ceros (FDif f g) = let (sf,sg) = (simplificar_ceros f, simplificar_ceros g)
                               in  if (sf==FConst 0) then (FUmin g)
                                   else if (sg==FConst 0) then f
                                        else (FDif sf sg)                                                                             
simplificar_ceros (FUmin f) = let sf = simplificar_ceros f
                               in  if (sf==FConst 0) then FConst 0
                                   else FUmin sf
simplificar_ceros (FCos f)  = (FCos (simplificar_ceros f))                                   
simplificar_ceros (FSin f)  = (FSin (simplificar_ceros f)) 
simplificar_ceros (FTan f)  = (FTan (simplificar_ceros f)) 
simplificar_ceros (FAcos f) = (FAcos (simplificar_ceros f))                                   
simplificar_ceros (FAsin f) = (FAsin (simplificar_ceros f)) 
simplificar_ceros (FAtan f) = (FAtan (simplificar_ceros f)) 
simplificar_ceros (FCosh f) = (FCosh (simplificar_ceros f)) 
simplificar_ceros (FTanh f) = (FTanh (simplificar_ceros f)) 
simplificar_ceros (FSinh f) = (FSinh (simplificar_ceros f))                                
simplificar_ceros (FLog f)  = (FLog (simplificar_ceros f))                                                                        
simplificar_ceros x = x  --fconst, fvar                               
                                                                  
------------------------------------------------------------------------
-- derivación puntual mediante diferencias finitas

hderivate :: FReal -> Double -> Double -> NumMonad String Double
hderivate f x h =  do fx  <- eval f x
                      fxh <- eval f (x+h)
                      return ((fxh - fx) / h)    
shderivate :: (Double -> Double) -> Double -> Double -> Double
shderivate f x h = (fxh - fx)/h
                    where fx =  f x
                          fxh = f (x+h)
                       
------------------------------------------------------------------------
-- composición de funciones

composition :: FReal -> FReal -> FReal
composition (FConst c)   h = FConst c
composition (FVar)       h = h
composition (FSum f g)   h = FSum (composition f h) (composition g h)
composition (FDif f g)   h = FDif (composition f h) (composition g h)
composition (FMul f g)   h = FMul (composition f h) (composition g h)
composition (FCoc f g)   h = FCoc (composition f h) (composition g h)
composition (FPot f g)   h = FPot (composition f h) (composition g h)
composition (FSin f)     h = FSin (composition f h)
composition (FCos f)     h = FCos (composition f h)
composition (FTan f)     h = FTan (composition f h)
composition (FSinh f)    h = FSinh (composition f h)
composition (FCosh f)    h = FCosh (composition f h)
composition (FTanh f)    h = FTanh (composition f h)
composition (FLog f)     h = FLog (composition f h) 
composition (FUmin f)    h = FUmin (composition f h)
composition (FAsin f)    h = FAsin (composition f h)
composition (FAtan f)    h = FAtan (composition f h)
composition (FAcos f)    h = FAcos (composition f h)
composition _            h = error "composition: aún no definida"

