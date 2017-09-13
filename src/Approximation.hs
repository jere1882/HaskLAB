module Approximation (
       taylor,
       interpolacion_lagrange,
       interpolacion_newton,
       chebyshev,
       ) 
    where 
    
import Common
import RealFc
import Data.Maybe

------------------------------------------------------------------------
--para detectar errores
no_num :: Double -> Bool
no_num x = (isNaN x) || (isInfinite x) 

fact 0 = 1
fact n = n * fact (n-1)
------------------------------------------------------------------------
-- calcula el polinomio de taylor de orden n de f 
taylor :: FReal -> Double -> Double -> Int -> Maybe FReal
taylor f a h n = gen_taylor (\x -> seval f x) a 0 n h

-- generamos el polinomio a partir de los términos de menor grado, empezando por el t. idpte
gen_taylor f a k n h | k == n     =  if no_num fa then Nothing else Just k_term
                     | otherwise  =  if no_num fa then Nothing else if isNothing k1_term then Nothing
                                                                                         else Just $ FSum (k_term) (fromJust k1_term) 
    where  fa = f a
           dfk_a  = fa/(fromIntegral (fact k)) 
           k_term = FMul (FConst dfk_a) (FPot (FDif (FVar) (FConst a)) (FConst (fromIntegral k)))
           k1_term = (gen_taylor (\x -> shderivate f x h ) a (k+1) n h )

-- El único error que puede ocurrir es que la función no esté definida en alguna de sus derivadas.
-- Como acá preciso usar funciones de haskell (Double -> Double), que propagan errores con NaN e Infinity,
-- Utilizo no_num para detectarlos y devolver nothing.

------------------------------------------------------------------------
isError :: NumMonad a b -> Bool
isError (E _ _ ) = True
isError _        = False

interpolacion_lagrange :: FReal -> [Double] -> Maybe FReal
-- Dada una función y (n+1) puntos (x,f x); podemos aproximarla por
-- el polinomio de grado <=n que pasa por esos (n+1) puntos.
interpolacion_lagrange f xs = if null errors then Just $ gen_lag lj ys' (length xs -1) else Nothing
    where ys  = [ eval f x | x <- xs ]
          errors = filter isError ys
          ys' = map (\(R _ x _) -> x) ys
          lj = \j -> coef_lagrange j 0 (length xs - 1) xs -- lj j es el polinomio coeficiente de lagrange j-ésimo
          
          
coef_lagrange j k n xs | k == n && n /= j     = kfact
                       | j == n && k == (n-1) = kfact
                       | k == j               = coef_lagrange j (k+1) n xs
                       | otherwise            = FMul kfact  (coef_lagrange j (k+1) n xs)
                  where kfact = FMul (FConst  (1/(xs!!j - xs!!k))  ) (FDif (FVar)  (FConst (xs!!k)))


gen_lag lj ys k | k == 0    = k_term
                | otherwise = FSum k_term (gen_lag lj ys (k-1))
            where k_term = FMul (FConst $ ys!!k) (lj k)


------------------------------------------------------------------------

interpolacion_newton :: FReal -> [Double] -> Maybe FReal
interpolacion_newton f xs = if null errors then Just $ gen_newton ds xs n else Nothing
    where n = (length xs) -1
          ys = [eval f x | x <- xs ]
          errors = filter isError ys
          ys' = map (\(R _ x _) -> x) ys
          ds = [ dif_div f xs ys' 0 j | j <- [0..n] ]
          
gen_newton ds xsP 0 =  (FConst $ ds!!0)
gen_newton ds xs k =  FSum (FMul (FConst $ ds!!k) (coef_n xs k 0) ) (gen_newton ds xs (k-1))

coef_n :: [Double] -> Int -> Int -> FReal --coef xs j k = (x-xs!!0) (x-xs!!1) ... (x-xs!!(j-1)) 
coef_n xs j k | j-1 == k  = factor 
              | otherwise = FMul factor (coef_n xs j (k+1))
                where factor = (FDif (FVar) (FConst $ xs!!k))
              
                
dif_div :: FReal -> [Double] -> [Double] -> Int -> Int -> Double
dif_div f xs ys i j | i == j     =  ys !! i 
                    | i > j      = error "Algo mal en dif_fiv"  -- no debería ocurrir nunca
                    | otherwise  = let k = j-i in ((dif_div f xs ys (i+1) (i+k)) - (dif_div f xs ys i (i+k-1)) )/ (xs!!(i+k) - xs!!i)

------------------------------------------------------------------------


chebyshev :: FReal -> Double -> Double -> Int -> Maybe FReal
-- Aproximación de una función f en [a,b] utilizando como nodos de inter
-- polación las n+1 raíces del polinomio mónico o normalizado de Chebyshov
-- de grado n+1. Esto minimiza el error de  |f(x) - Pn (x)|
chebyshev f a b n = if null errors then interpolacion_newton f nodos else Nothing
    where nodos =  [ let i' = fromIntegral i in (a+b)/2 + (b-a)/2 * cos (pi*(2*i'+1)/(2*n'+2)) | i <- [0..n] ]
          n' = fromIntegral n
          errors = filter no_num nodos
          

------------------------------------------------------------------------




