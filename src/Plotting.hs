module Plotting (
       sfPlot,
       mfPlot,
       xPlot,
       autoPlot
       )
       where 
       
import Common
import RealFc
import Graphics.EasyPlot  -- GNUPLot wrapper

--Auxiliar para detectar errores de evaluación
is_num :: Double -> Bool
is_num x = not $ (isNaN x) || (isInfinite x) 

--Dado un intervalo [a,b] genera una una lista de puntos sp-equiespaciados
gen_domain ::  Double -> Double -> Double -> [Double]                        
gen_domain a b sp= let n_points = round ((b-a)/sp) in [ a + sp * (fromInteger k) | k <- [0..n_points] ]

-- Arma los pares (x,f x) donde x \in domain y la función está definida.
gen_pairs :: FReal -> [Double] -> [(Double,Double)]
gen_pairs f domain = filter (\(x,y) -> is_num y) [ (x, seval f x) | x <- domain ] 
    where seval f x = case (eval f x) of
                        (R _ val _ ) -> val
                        (E _ _ )     -> 1/0
                                                                 
------ single function plot 
sfPlot :: (FReal,String) -> Double -> Double -> Double -> IO Bool
sfPlot (f,s) a b step = plot X11 $ x_label:[ Data2D [Style Lines, Title s] [] (gen_pairs f domain) ]
    where domain = gen_domain a b step
          x_label  = Data2D [Color Black,Style Lines,Title "x label"] [] [ (x,0) | x <- domain] 
                      
----- multiple function plot
mfPlot :: [(FReal,String)] -> Double -> Double -> Double -> IO Bool
mfPlot fs a b step = plot X11 $ x_label:[(Data2D [Style Lines, Title s] [] (gen_pairs f domain)) | (f,s) <- fs]
    where domain = gen_domain a b step
          x_label  = Data2D [Color Black,Style Lines,Title "x label"] [] [ (x,0) | x <- domain ]
              
----- multiple function / points plot

xPlot :: [(FReal,String)] -> [(Double,Double)] -> Double -> Double -> Double -> IO Bool
xPlot fs ps a b step = plot X11 $ x_label:points:[(Data2D [Style Lines, Title s] [] (gen_pairs f domain)) | (f,s) <- fs]
    where domain = gen_domain a b step
          x_label  = Data2D [Color Black,Style Lines,Title "x label"] [] [ (x,0) | x <- domain ]
          points   = Data2D [Color Red,Title "Points"] [] ps

----- auto plot 
autoPlot :: [(FReal,String)] -> IO Bool
autoPlot fs = plot X11 $ x_label:(map (\(f,s) -> (Function2D [Title s] [] (\x -> seval f x)) ) fs)
    where x_label  = Function2D [Color Black,Style Lines,Title "x label"] [] (\x -> 0)

