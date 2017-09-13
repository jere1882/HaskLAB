module RootFinding (
       bisection,
       regula_falsi,
       newton_raphson,
       hnewton_raphson,
       secante,
       hsecante
       ) 
    where 
    
import Common
import RealFc


-----------------------------------------------------------------------------------------------------------------------------------
bisection :: FReal -> Double -> Double -> Double -> NumMonad String Double

bisection f a b delta = do fa <- eval f a                                    
                           fb <- eval f b
                           let nits = 1 + round ((log (b-a) - (log delta) )/ (log 2))   
                           if fa==0 then 
                               do { (set_code Reached) ; return a } 
                           else if fb==0 then 
                               do { (set_code Reached) ; return b } 
                           else if fa*fb > 0 then 
                               raise "f(a)*f(b) must be negative"
                           else 
                               bisection' f a b nits 
                  
                        
bisection' f a b it_rest = do let c = (b + a)/2
                              if it_rest==1 then 
                                 do { (set_code Delta) ; return c } 
                              else 
                                 do fa <- eval f a
                                    fb <- eval f b
                                    fc <- eval f c
                                    if fc == 0 then
                                        do { (set_code Reached) ; return c }    
                                    else if fa * fc < 0  then 
                                        do { tick ; bisection' f a c (it_rest - 1)}
                                    else 
                                        do { tick ; bisection' f c b (it_rest - 1)}
     

-----------------------------------------------------------------------------------------------------------------------------------

regula_falsi :: FReal -> Double -> Double -> Double -> Double -> Int -> NumMonad String Double
regula_falsi f a b delta epsilon maxit = do fa <- eval f a                                    
                                            fb <- eval f b                             
                                            if fa==0 then 
                                                do { (set_code Reached) ; return a } 
                                            else if fb==0 then 
                                                do { (set_code Reached) ; return b } 
                                            else if fa*fb > 0 then 
                                                raise "f(a)*f(b) must be negative"
                                            else 
                                                regula_falsi' f a b delta epsilon maxit 

regula_falsi' f a b delta epsilon it_rest = do fa <- eval f a
                                               fb <- eval f b
                                               let c = b - fb * (b-a) / (fb - fa)
                                               fc <- eval f c
                                               if fc == 0 then                            -- Hallamos la raíz exacta
                                                   do { (set_code Reached) ; return c }  
                                               else if it_rest == 0 then                  -- Límite de iteraciones
                                                   do { (set_code Maxit) ; return c }
                                               else if (max (c-a) (b-c))< delta then      -- Tolerancia eje x
                                                   do { (set_code Delta) ; return c } 
                                               else if (abs fc) < epsilon then            -- Tolerancia eje y
                                                   do { (set_code Epsilon) ; return c } 
                                               else if fa * fc < 0  then 
                                                   do { tick ; regula_falsi' f a c delta epsilon (it_rest - 1)}
                                               else 
                                                   do { tick ; regula_falsi' f c b delta epsilon (it_rest - 1)}
                                                                       
-----------------------------------------------------------------------------------------------------------------------------------

newton_raphson :: FReal -> FReal -> Double -> Double -> Double -> Int -> NumMonad String Double
newton_raphson f f' p0 delta epsilon maxit = do f0  <- eval f  p0
                                                f0' <- eval f' p0
                                                let p1 = p0 - f0 / f0'
                                                f1  <- eval f p1
                                                if f1==0 then
                                                  do { (set_code Reached) ; return p1 }   
                                                else if maxit==0 then
                                                  do { (set_code Maxit) ; return p1 }
                                                else if (abs f1) < epsilon then
                                                  do { (set_code Epsilon) ; return p1 } 
                                                else if  abs (p1-p0) < delta then
                                                  do { (set_code Delta) ; return p1 } 
                                                else
                                                  do tick
                                                     newton_raphson f f' p1 delta epsilon (maxit-1)

                                                     
hnewton_raphson :: FReal -> Double -> Double -> Double -> Double -> Int -> NumMonad String Double
hnewton_raphson f p0 delta epsilon h maxit = do f0  <- eval f  p0
                                                f0' <- hderivate f p0 h 
                                                let p1 = p0 - f0 / f0'
                                                f1  <- eval f p1
                                                if f1==0 then
                                                  do { (set_code Reached) ; return p1 }   
                                                else if maxit==0 then
                                                  do { (set_code Maxit) ; return p1 }
                                                else if (abs f1) < epsilon then
                                                  do { (set_code Epsilon) ; return p1 } 
                                                else if  abs (p1-p0) < delta then
                                                  do { (set_code Delta) ; return p1 } 
                                                else
                                                  do tick
                                                     hnewton_raphson f p1 delta epsilon h (maxit-1)                                                        
------------------------------------------------------------------------------------------------------------------------------------


secante :: FReal -> FReal -> Double -> Double -> Double -> Double -> Int -> NumMonad String Double
secante f f' p0 p1 delta epsilon maxit = do f0  <- eval f  p0
                                            f1  <- eval f  p1
                                            f0' <- eval f' p0
                                            f1' <- eval f' p1
                                            let p2 = p1 - f1 * (p1-p0) / (f1 - f0)
                                            f2  <- eval f' p2
                                            if f2==0 then
                                              do { (set_code Reached) ; return p2 }   
                                            else if maxit==0 then
                                              do { (set_code Maxit) ; return p2 }
                                            else if (abs f2) < epsilon then
                                              do { (set_code Epsilon) ; return p2 } 
                                            else if  abs (p2-p1) < delta then
                                              do { (set_code Delta) ; return p2 } 
                                            else
                                              do tick
                                                 secante f f' p1 p2 delta epsilon (maxit-1)  

hsecante :: FReal -> Double -> Double -> Double -> Double -> Double -> Int -> NumMonad String Double
hsecante f h p0 p1 delta epsilon maxit = do f0  <- eval f  p0
                                            f1  <- eval f  p1
                                            f0' <- hderivate f p0 h
                                            f1' <- hderivate f p1 h
                                            let p2 = p1 - f1 * (p1-p0) / (f1 - f0)
                                            f2  <- eval f p2 
                                            if f2==0 then
                                              do { (set_code Reached) ; return p2 }   
                                            else if maxit==0 then
                                              do { (set_code Maxit) ; return p2 }
                                            else if (abs f2) < epsilon then
                                              do { (set_code Epsilon) ; return p2 } 
                                            else if  abs (p2-p1) < delta then
                                              do { (set_code Delta) ; return p2 } 
                                            else
                                              do tick
                                                 hsecante f h p1 p2 delta epsilon (maxit-1)  
                                                 
------------------------------------------------------------------------------------------------------------------------------------
    

