module Integration (
	   trapecio,
	   trapecio_compuesto,
	   simpson,
	   simpson_compuesto
       ) 
    where 
    
import Common
import RealFc



------------------------------------------------------------------------
--AUXILIAR

subdivide :: Double -> Double -> Int -> [Double]
subdivide a b n = [ a + h * (fromIntegral k) | k <- [0..n] ]
	where h = (b-a)/(fromIntegral n)

------------------------------------------------------------------------

trapecio :: FReal -> Double -> Double -> NumMonad String Double    
trapecio f a b = do fa <- eval f a
                    fb <- eval f b
                    let h = b-a 
                    return ((fb+fa)*h/2)

trapecio_compuesto :: FReal -> Double -> Double -> Int -> NumMonad String Double 
trapecio_compuesto f a b n = let points = subdivide a b n in trapecio_compuesto' f points


trapecio_compuesto' :: FReal -> [Double] -> NumMonad String Double 
trapecio_compuesto' f ps | length ps < 2  = return 0
trapecio_compuesto' f (pn:pn':ps)          = do tn    <- trapecio f pn pn'
                                                trest <- trapecio_compuesto' f (pn':ps)  
                                                return (tn + trest)

simpson :: FReal -> Double -> Double -> NumMonad String Double    
simpson f a b  = do fa <- eval f a
                    fb <- eval f b
                    let h = (b-a)/2
                        c = a+h
                    fc <- eval f c                   
                    return (h/3 * (fa + 4 * fb + fc) )                                        
                    
simpson_compuesto :: FReal -> Double -> Double -> Int -> NumMonad String Double 
simpson_compuesto f a b n = let points = subdivide a b n in simpson_compuesto' f points
                    
                    
simpson_compuesto' :: FReal -> [Double] -> NumMonad String Double 
simpson_compuesto' f ps | length ps < 2  = return 0
simpson_compuesto' f (pn:pn':ps)         = do tn    <- simpson f pn pn'
                                              trest <- simpson_compuesto' f (pn':ps)  
                                              return (tn + trest)
