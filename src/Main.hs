{-# OPTIONS -XRecordWildCards #-}
module Main where

  import Control.Exception (catch,IOException)
  import Control.Monad.Except
  import Data.Char
  import Data.List
  import Data.Maybe
  import Prelude hiding (print, catch)
  import System.Console.Readline
  import System.Environment
  import System.IO hiding (print)


  import Common
  import RealFc
  import RootFinding
  import Integration
  import Plotting
  import Approximation
  import Parse
  import Printer
  
------------------------------------------------------------------------
--- Hasklab Interfaz


  main :: IO ()
  main = do args <- getArgs 
            readevalprint args (S True "" [])

  ioExceptionCatcher :: IOException -> IO (Maybe a)
  ioExceptionCatcher _ = return Nothing

  iprompt :: String
  iprompt = "HL> "


  data State = S { inter :: Bool,       -- True, si estamos en modo interactivo.
                   lfile :: String,     -- Ultimo archivo cargado (para hacer "reload")
                   ve :: NameEnv FReal  -- Entorno con variables globales y su valor  [(Name, FReal)]
                 }

  --  read-eval-print loop
  readevalprint :: [String] -> State -> IO ()
  readevalprint args state@(S {..}) =
    let rec st =             
          do
            mx <- catch
                   (if inter
                    then readline iprompt 
                    else fmap Just getLine)
                    ioExceptionCatcher
            case mx of
              Nothing   ->  return ()
              Just ""   ->  rec st
              Just x    ->
                do
                  when inter (addHistory x)
                  c   <- interpretCommand x -- c :: Command (Quit, help,...)
                  st' <- handleCommand st c -- st' va a ser nothing si era un quit -> se retorna () y termina el main
                                            -- si no era quit, st' va a ser el nuevo estado luego de ejecutar el comando c
                                            -- y se repite todo esto de nuevo (rec st')
                  maybe (return ()) rec st'
    in
      do
        state' <- compileFiles (prelude:args) state 
        when inter $ putStrLn ( "\nMINI HASKLAB\nMétodos Numéricos en Haskell.\n" ++
                               "Escriba :help para recibir ayuda.")
        --  enter loop
        rec state' {inter=True}


------------------------------------------------------------------------

  data Command = CompileFile String
               | Recompile  
               | Browse
               | Quit
               | Command String
               | Help 
               | Noop
               | Numerical_method_command String -- o erróneo
               
------------------------------------------------------------------------
-- Recibe una linea y determina el tipo de comando

  interpretCommand :: String -> IO Command
  interpretCommand x     
    =  if isPrefixOf ":" x then
         do  let  (cmd,t')  =  break isSpace x  
                  t         =  dropWhile isSpace t'  
             --  find matching commands
             let  matching  =  filter (\ (Cmd cs _ _ _) -> any (isPrefixOf cmd) cs) commands
             case matching of
               []  ->  do  putStrLn ("Comando desconocido `" ++ 
                                     cmd                     ++ 
                                     "'. Escriba :help para recibir ayuda.")
                           return Noop
               [Cmd _ _ f _]
                   ->  do  return (f t)  
               _   ->  do  putStrLn ("Comando ambigüo, podría ser " ++ 
                                     concat (intersperse ", " [ head cs | Cmd cs _ _ _ <- matching ]) ++ ".")
                           return Noop
                                                        
       else
         return (Numerical_method_command x) -- Linea de un comando sin :
------------------------------------------------------------------------
-- Ejecuta un comando

  handleCommand :: State -> Command -> IO (Maybe State)
  handleCommand state@(S {..}) cmd
    =  case cmd of
         Quit       ->  when (not inter) (putStrLn "!@#$^&*") >> return Nothing
         Noop       ->  return (Just state)
         Help       ->  putStr (helpTxt commands) >> return (Just state)
         Browse     ->  do  putStr (unlines (map fst ve) )
                            return (Just state)
         CompileFile f  ->  do  state' <- compileFile (state {lfile=f}) f
                                return (Just state')
         Recompile  -> if null lfile 
                        then putStrLn "No hay un archivo cargado.\n" >> 
                             return (Just state) 
                        else handleCommand state (CompileFile lfile)
         Command xs -> do  let xs' = reverse $ dropWhile isSpace (reverse xs) 
                           putStrLn ""
                           putStr (help_string xs')
                           putStrLn ""
                           return (Just state)
         Numerical_method_command xs -> do lane <- parseIO "<interactive>" stmt_parse xs
                                           if isNothing lane 
                                           then (return $ Just state)
                                           else do st' <- handleStmt state (fromJust lane)
                                                   return (Just st')
 
 

------------------------------------------------------------------------
-- Ejecuta un comando relativo a funciones/métodos numéricos


  handleStmt :: State -> Stmt FReal -> IO State  
  handleStmt state st = case st of
      Def f e -> let se = simpl e state
                 in if isNothing se
                    then do {putStrLn "Función interna no definida" ; return state }
                    else  return (state { ve = (f, fromJust se) : quit_lab f (ve state)})
                    
      Plot fs a b step -> do let fs' = func_matching fs (ve state)
                             if isNothing fs' 
                             then do {putStrLn "Función no definida";return state}
                             else do  succes <-  mfPlot (fromJust fs') a b step
                                      when (not succes) (putStrLn "Error en el ploteo.")
                                      return state  
      Disp f -> do let fs = buscar_env f (ve state)
                   if isNothing fs 
                   then do {putStrLn ("Función "++f++" no definida") ; return state }
                   else do let func = fromJust fs
                           putStrLn $ "\nAST:\n" ++ show func ++
                                      "\nSe muestra como : \n"++
                                      printFunc func ++ "\n"
                           return state
                           
      Eval f x -> do let fs = buscar_env f (ve state)
                     if isNothing fs 
                     then do {putStrLn ("Función "++f++" no definida"); return state }
                     else do let func = fromJust fs
                                 res  = eval func x
                             case res of 
                                E xs n -> do putStrLn $ "(Eval) Error: "++xs
                                             return state
                                R ni c code -> do putStrLn $ "\n"++f++"("++show x++")=" ++ show c
                                                  return state
      Derivate f -> do let fs = buscar_env f (ve state)
                       if isNothing fs 
                       then do {putStrLn ("Función "++f++" no definida"); return state }
                       else do let func = fromJust fs
                               putStrLn $ f++"(x)="++ printFunc func
                               let f' = derivate (fromJust fs)
                               putStrLn $ f++"'(x)="++ printFunc f'
                               return (state { ve = ("ans", f') : ve state})
 
 
      HDerivate f x h -> do    let fs = buscar_env f (ve state)
                               if isNothing fs 
                               then do {putStrLn ("Función "++f++" no definida"); return state }
                               else do let func = fromJust fs
                                           ans = hderivate (fromJust fs) x h 
                                       putStrLn $ f++"'("++show x++")="++ show ans 
                                       return state
 
      Compose f g -> do       let fs = buscar_env f (ve state)
                                  gs = buscar_env g (ve state)
                              if isNothing fs 
                              then do {putStrLn ( "Función "++f++" no definida") ; return state }
                              else if isNothing gs
                                   then do {putStrLn ( "Función "++g++" no definida") ; return state }
                                   else do  let func  = fromJust fs
                                                func' = fromJust gs
                                                res  = composition func func'
                                            putStrLn $ f++"."++g++"(x)=" ++ (printFunc res)
                                            return (state { ve = ("ans", res) : ve state})  
  
      Bisection f a b step -> do let fs = buscar_env f (ve state)
                                 if isNothing fs 
                                 then do {putStrLn ("Función "++f++" no definida") ; return state }
                                 else do let func = fromJust fs
                                             res  = bisection func a b step
                                         case res of 
                                            E xs n -> do putStrLn $ "(Bisection) Error: "++xs
                                                         return state
                                            R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                              putStrLn $ "Causa de terminación: "++ cause code
                                                              putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                              xPlot [(func,f)] [(c,seval func c)] a b  ((b - a)/ 1000) 
                                                              return state

      RegulaFalsi f a b delta epsilon maxit -> do  let fs = buscar_env f (ve state)
                                                   if isNothing fs 
                                                   then do {putStrLn ("Función "++f++" no definida") ; return state }
                                                   else do let func = fromJust fs
                                                               res  = regula_falsi func a b delta epsilon maxit
                                                           case res of 
                                                              E xs n -> do putStrLn $ "(Regula_falsi) Error: "++xs
                                                                           return state
                                                              R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                                                putStrLn $ "Causa de terminación: "++ cause code
                                                                                putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                                                xPlot [(func,f)] [(c,seval func c)] a b  ((b - a)/ 1000) 
                                                                                return state
 
      NewtonRaphson f f' p0 delta epsilon maxit -> do let fs = buscar_env f (ve state)
                                                          fs'= buscar_env f' (ve state)
                                                      if isNothing fs 
                                                      then do {putStrLn ( "Función "++f++" no definida") ; return state }
                                                      else if isNothing fs'
                                                           then do {putStrLn ( "Función "++f'++" no definida") ; return state }
                                                           else do let func =  fromJust fs
                                                                       func' = fromJust fs'
                                                                       res  = newton_raphson func func' p0 delta epsilon maxit
                                                                   case res of 
                                                                    E xs n -> do putStrLn $ "(Newton_Raphson) Error: "++xs
                                                                                 return state
                                                                    R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                                                      putStrLn $ "Causa de terminación: "++ cause code
                                                                                      putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                                                      xPlot [(func,f)] [(c,seval func c)] (c-5) (c+5) 0.001
                                                                                      return state                                                                                   

      HNewtonRaphson f p0 delta epsilon h maxit -> do let fs = buscar_env f (ve state)
                                                      if isNothing fs 
                                                      then do {putStrLn ("Función "++f++" no definida") ; return state }
                                                      else do  let  func =  fromJust fs
                                                                    res  = hnewton_raphson func p0 delta epsilon h maxit
                                                               case res of 
                                                                  E xs n -> do putStrLn $ "(HNewton_Raphson) Error: "++xs
                                                                               return state
                                                                  R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                                                    putStrLn $ "Causa de terminación: "++ cause code
                                                                                    putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                                                    xPlot [(func,f)] [(c,seval func c)] (c-5) (c+5) 0.001
                                                                                    return state  
      Secante f f' p0 p1 delta epsilon maxit -> do let fs = buscar_env f (ve state)
                                                       fs'= buscar_env f' (ve state)
                                                   if isNothing fs 
                                                   then do {putStrLn ( "Función "++f++" no definida") ; return state }
                                                   else if isNothing fs'
                                                        then do {putStrLn ( "Función "++f'++" no definida") ; return state }
                                                        else do let func  = fromJust fs
                                                                    func' = fromJust fs'
                                                                    res   = secante func func' p0 p1 delta epsilon maxit
                                                                case res of 
                                                                  E xs n -> do putStrLn $ "(Secante) Error: "++xs
                                                                               return state
                                                                  R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                                                    putStrLn $ "Causa de terminación: "++ cause code
                                                                                    putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                                                    xPlot [(func,f)] [(c,seval func c)] (c-5) (c+5) 0.001
                                                                                    return state                                                                                   

      HSecante  f h p0 p1 delta epsilon maxit -> do let fs = buscar_env f (ve state)
                                                    if isNothing fs 
                                                    then do {putStrLn ("Función "++f++" no definida") ; return state }
                                                    else do  let  func =  fromJust fs
                                                                  res  = hsecante func h p0 p1 delta epsilon maxit
                                                             case res of 
                                                                E xs n -> do putStrLn $ "(HSecante) Error: "++xs
                                                                             return state
                                                                R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                                                  putStrLn $ "Causa de terminación: "++ cause code
                                                                                  putStrLn $ "Número de iteraciones realizadas: "++show ni
                                                                                  xPlot [(func,f)] [(c,seval func c)] (c-5) (c+5) 0.001
                                                                                  return state  
      Trapecio f a b -> do  let fs = buscar_env f (ve state)
                            if isNothing fs 
                            then do {putStrLn ("Función "++f++" no definida") ; return state }
                            else do  let  func = fromJust fs
                                          res  = trapecio func a b
                                     case res of 
                                        E xs n -> do putStrLn $ "(Trapecio) Error: "++xs
                                                     return state
                                        R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                          sfPlot (func,f) a b ((b - a)/ 1000) 
                                                          return state  
                                                          
      Simpson f a b -> do let fs = buscar_env f (ve state)
                          if isNothing fs 
                          then do {putStrLn ("Función "++f++" no definida") ; return state }
                          else do  let  func =  fromJust fs
                                        res  = simpson func a b
                                   case res of 
                                      E xs n -> do putStrLn $ "(Simpson) Error: "++xs
                                                   return state
                                      R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                        sfPlot (func,f) a b ((b - a)/ 1000) 
                                                        return state  
                                                            
      SimpsonC f a b n -> do  let fs = buscar_env f (ve state)
                              if isNothing fs 
                              then do {putStrLn ("Función "++f++" no definida") ; return state }
                              else do  let  func =  fromJust fs
                                            res  = simpson_compuesto func a b n
                                       case res of 
                                          E xs n -> do putStrLn $ "(Simpson Compuesto) Error: "++xs
                                                       return state
                                          R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                            sfPlot (func,f) a b ((b - a)/ 1000) 
                                                            return state  
      TrapecioC f a b n -> do let fs = buscar_env f (ve state)
                              if isNothing fs 
                              then do {putStrLn ("Función "++f++" no definida") ; return state }
                              else do  let  func =  fromJust fs
                                            res  = trapecio_compuesto func a b n
                                       case res of 
                                          E xs n -> do putStrLn $ "(Trapecio Compuesto) Error: "++xs
                                                       return state
                                          R ni c code -> do putStrLn $ "\nResultado: " ++ show c
                                                            sfPlot (func,f) a b ((b - a)/ 1000) 
                                                            return state  



      InterpolacionL f ps -> do let fs = buscar_env f (ve state)
                                if isNothing fs 
                                then do {putStrLn ("Función "++f++" no definida") ; return state }
                                else do let  func =  fromJust fs
                                             ps' = map head (group ps) --por si pusieron puntos repetidos
                                        if (length ps') <= 1  then do putStrLn "(Interpolación de Lagrange) La lista debe contener al menos dos puntos distintos"
                                                                      return state                                           
                                                              else do let pol  = interpolacion_lagrange func ps'
                                                                      if isNothing pol    then do  putStrLn "(Interpolacion de Lagrange) La función no está definida en alguno de los puntos a interpolar"
                                                                                                   return state
                                                                                          else do let pol' = fromJust pol
                                                                                                  putStrLn $ "p(x)=" ++ (printFunc pol')
                                                                                                  let (a,b) = (foldl min (1/0) ps, foldl max (-1/0) ps)
                                                                                                  mfPlot [(func,f),(pol',"ans")] a b ((b - a)/ 1000) 
                                                                                                  return (state { ve = ("ans", pol') : quit_lab "ans" (ve state)})    
      InterpolacionN f ps -> do let fs = buscar_env f (ve state)
                                if isNothing fs 
                                then do {putStrLn ("Función "++f++" no definida") ; return state }
                                else do let  func =  fromJust fs
                                             ps' = map head (group ps) --por si pusieron puntos repetidos
                                        if (length ps') <= 1  then do putStrLn "(Interpolación de Newton) La lista debe contener al menos dos puntos distintos"
                                                                      return state                                           
                                                              else do let pol  = interpolacion_newton func ps'
                                                                      if isNothing pol    then do  putStrLn "(Interpolacion de Newton) La función no está definida en alguno de los puntos a interpolar"
                                                                                                   return state
                                                                                          else do let pol' = fromJust pol
                                                                                                  putStrLn $ "p(x)=" ++ (printFunc pol')
                                                                                                  let (a,b) = (foldl min (1/0) ps, foldl max (-1/0) ps)
                                                                                                  mfPlot [(func,f),(pol',"ans")] a b ((b - a)/ 1000) 
                                                                                                  return (state { ve = ("ans", pol') : quit_lab "ans" (ve state)})  

      Chebyshev f a b n -> do let fs = buscar_env f (ve state)
                              if isNothing fs 
                              then do {putStrLn ("Función "++f++" no definida") ; return state }
                              else do let  func =  fromJust fs
                                           pol  = chebyshev func a b n
                                      if isNothing pol then do  putStrLn $ "(Chebyshev) La función no está definida en todo ["++show a++","++show b++"]"
                                                                return state
                                                       else do  let pol' = fromJust pol
                                                                putStrLn $ "p(x)=" ++ (printFunc pol')
                                                                mfPlot [(func,f),(pol',"ans")] a b ((b - a)/ 1000) 
                                                                return (state { ve = ("ans", pol') : quit_lab "ans" (ve state)})  


      Taylor f a h n -> do  let fs = buscar_env f (ve state)
                            if isNothing fs 
                            then do {putStrLn ("Función "++f++" no definida") ; return state }
                            else do let  func =  fromJust fs
                                         pol  =  taylor func a h n
                                    if isNothing pol then do putStrLn $ "(Taylor) Error: "++f++" no estaba definida en algunas de sus derivadas o no era derivable"
                                                             return state
                                                     else do let pol' = fromJust pol
                                                             putStrLn $ "p(x)=" ++ (printFunc pol')
                                                             mfPlot [(func,f),(pol',"ans")] (a-5) (a+5) 0.0001
                                                             return (state { ve = ("ans", pol') : quit_lab "ans" (ve state)})  
   
  {-BUSCA ALGUNA ETIQUETA EN EL ENTORNO -}
  buscar_env :: String -> [(String,FReal)] -> Maybe FReal
  buscar_env f env = if null env' then Nothing else Just (snd $ env'!!0) 
      where env' = filter (\(id,l) -> id==f) env                              
                                                                                                                                                                                                                     
  {-AUXILIARES PARA PLOT -}                                                 
  func_matching :: [String] -> [(String,FReal)] -> Maybe [(FReal,String)]
  func_matching [] env     = return []
  func_matching (f:fs) env = do es <- func_matching fs env
                                fe <- buscar_env f env
                                return ((fe,f):es)
                                
  {-AUXILIARES PARA DEF -}  
  --luego de parsear una función, esta funcion se encarga de simplificarla y 
  --reemplazar identificadores de funciones por su ley
  -- por ejemplo def sinc(x) = sen x/x
  --             def uso_sinc(x) = sinc (cos x)
  --  luego de parsear y usar replace_labels, quedará uso_sinc(x) = sen(cos x)/(cos x)  
  
    
  simpl :: FReal -> State -> Maybe FReal
  simpl f st =  let sf = simplificar_ceros f    -- Borra *0, +0, 0/algo, etc 
                in replace_labels sf st         -- Reemplaza identificadores de funciones por su definición
                
  replace_labels :: FReal -> State -> Maybe FReal
  replace_labels (FId label exp) st  = do t <- buscar_env label (ve st)   
                                          return (composition t exp)
  replace_labels (FUmin f)   st  = do fs <- replace_labels f st
                                      return (FUmin fs)
  replace_labels (FSin f)    st  = do fs <- replace_labels f st
                                      return (FSin fs)      
  replace_labels (FSinh f)   st  = do fs <- replace_labels f st
                                      return (FSinh fs)          
  replace_labels (FCos f)    st  = do fs <- replace_labels f st
                                      return (FCos fs)     
  replace_labels (FCosh f)   st  = do fs <- replace_labels f st
                                      return (FCosh fs)
  replace_labels (FAcos f)   st  = do fs <- replace_labels f st
                                      return (FAcos fs)     
  replace_labels (FAsin f)   st  = do fs <- replace_labels f st
                                      return (FAsin fs)
  replace_labels (FAtan f)   st  = do fs <- replace_labels f st
                                      return (FAtan fs)
  replace_labels (FTan f)    st  = do fs <- replace_labels f st
                                      return (FTan fs)   
  replace_labels (FLog f)    st  = do fs <- replace_labels f st
                                      return (FLog fs)         
  replace_labels (FSum f g)  st  = do fs <- replace_labels f st
                                      gs <-replace_labels g st
                                      return (FSum fs gs)
  replace_labels (FDif f g)  st  = do fs <- replace_labels f st
                                      gs <-replace_labels g st
                                      return (FDif fs gs)
  replace_labels (FMul f g)  st  = do fs <- replace_labels f st
                                      gs <-replace_labels g st
                                      return (FMul fs gs)
  replace_labels (FCoc f g)  st  = do fs <- replace_labels f st
                                      gs <-replace_labels g st
                                      return (FCoc fs gs)
  replace_labels (FPot f g)  st  = do fs <- replace_labels f st
                                      gs <-replace_labels g st
                                      return (FPot fs gs)           
  replace_labels f st            = return f --var, const
                            
                            
  -- para evitar redefiniciones!                                                 
  quit_lab :: String -> [(String,FReal)] -> [(String,FReal)]
  quit_lab xs []             = []
  quit_lab xs ( (ys,f):xss ) = if xs==ys then xss
                                         else (ys,f):(quit_lab xs xss)                                     
                                                   
------------------------------------------------------------------------
-- Para identificar comandos interactivos y dar ayuda al usuario 
  data InteractiveCommand = Cmd [String] String (String -> Command) String
  

  commands :: [InteractiveCommand]
  commands
    =  [ Cmd [":browse"]      ""        (const Browse) "Ver los nombres en scope",
         Cmd [":load"]        "<file>"  (CompileFile)
                                                       "Cargar un archivo de definiciones",
         Cmd [":reload"]      "<file>"  (const Recompile) "Volver a cargar el último archivo",
         Cmd [":quit"]        ""        (const Quit)   "Salir de Hasklab",
         Cmd [":help"]   ""        (const Help)   "Mostrar esta lista de comandos",
         Cmd [":?"] "<comm>"  (Command) "Información sobre un comando"]
         
------------------------------------------------------------------------     
-- Textos para ayuda al usuario.


  helpTxt :: [InteractiveCommand] -> String
  helpTxt cs
    =  "Lista de comandos:  \n" ++
       "\n" ++
       "INTERFAZ:\n" ++
       (unlines (map (\ (Cmd c a _ d) -> 
                     let  ct = concat (intersperse ", " (map (++ if null a then "" else " " ++ a) c))
                     in   ct ++ replicate ((24 - length ct) `max` 2) ' ' ++ d) cs)
       ) ++      
       "\nGENERALIDADES SOBRE FUNCIONES REALES:\n" ++       
       "def <f_id>(x) = <expr>                    \n" ++
       "plot  [<f_id>,...,<f_id>] <a> <b> <step>  \n" ++
       "disp <f_id>                               \n" ++
       "eval <f_id> <Real> \n" ++
       "derivate <f_id>\n" ++
       "hderivate <f_id> <Real> <h>\n" ++
       "compose <f_id> <f_id>\n"++
       "\nAPROXIMACIÓN DE RAICES EN FUNCIONES REALES:\n" ++
       "bisection <f_id> <a> <b> <delta>          \n" ++
       "regula_falsi <f_id> <a> <b> <delta> <epsilon> <maxit> \n" ++
       "newton_raphson <f_id> <f'_id> <p0> <delta> <epsilon> <maxit>\n" ++
       "hnewton_raphson <f_id> <p0> <delta> <epsilon> <h> <maxit> \n" ++
       "secante <f_id> <f'_id> <p0> <p1> <delta> <epsilon> <maxit>\n"++
       "hsecante <f_id> <h> <p0> <p1> <delta> <epsilon> <maxit>\n"++

       "\nAPROXIMACIÓN DE INTEGRALES DEFINIDAS EN FUNCIONES REALES:\n" ++
       "trapecio <f_id> <a> <b> \n" ++
       "trepecio_compuesto <f_id> <a> <b> <num_subint>\n" ++
       "simpson <f_id> <a> <b> \n" ++
       "simpson_compuesto  <f_id> <a> <b> <num_subint>\n" ++
       "\nPOLINOMIOS DE APROXIMACIÓN:\n" ++
       "taylor <f_id> <a> <h> <n> \n" ++
       "interpolacion_lagrange <f_id> <[Real]>\n" ++
       "interpolacion_newton <f_id> <[Real]>\n"++
       "chebyshev <f_id> <a> <b> <num_nodos>\n" ++
       "\nRecuerde que para utilizar una funcion debe definirla previamente"++
       "\n\nPara ver información detallada y ejemplos de un comando escriba :? <comm>.\n"
     

  help_string :: String -> String
  help_string "def" = ("Sintaxis: def <f_id>(x) = <expr> \n"++
               "Descripción: Agrega el identificador a la lista de funciones definidas,\n"++ 
               "con la ley correspondiente. Toda función debe ser previamente definida \n"++
               "para poder manipularla.\n"++
               "Ejemplo: \n"++
               ">  def f(x) = x*sen x\n" ++
               ">  def g(x) = f(cosh x) / cos (x)\n")
  help_string "plot" = "Sintaxis: plot  [<f_id>,...,<f_id>] <a> <b> <step>   (multiples)    \n"++
                "          plot  <f_id> <a> <b> <step>                (solo una)     \n"++
               "Descripción: Plotea una o más funciones en un intervalo [a,b],       \n"++
               "evaluando la función en puntos equiespaciados a distancia step.      \n"++
               "El identificador debe corresponder a una funcion previamente definida.\n"++
               "La función debe ser contínua en ese intervalo o será mal ploteada. \n"   ++
               "Ejemplo: \n"++
               ">  plot f -5 5 0.01\n" ++
               ">  plot [f,df,g] -10 5.5 0.001\n"
               
  help_string "disp" = "Sintaxis: disp <f_id>                                               \n"++
                 "Descripción: Muestra la ley asociada a un identificador previamente  \n"++
                 "definido, y el AST que le corresponde.                               \n"++
                 "Ejemplo: \n"++
                 "> disp f\n" 
               
  help_string "eval" =  "Sintaxis: eval <f_id> <Real>                                         \n"++
                 "Descripción: Evalúa la función en un punto dado, retornado el valor  \n"++
                 "correspondiente o un mensaje de error si no estuviese definida en ese\n"++
                 "punto.\n"++
                 "El identificador debe corresponder a una funcion previamente definida.\n"++
                 "Ejemplo: \n"++
                 "> eval f 5.12 \n"
                
  help_string "compose" =   "Sintaxis: compose <f_id> <f_id>                           \n"++
                 "Descripción: Halla la función compuesta de dos funciones dadas.  \n"++
                 "El resultado queda guardado en un identificador temporal ans.\n"++
                 "Los identificadores deben corresponder a funciones previamente definida.\n"++
                 "Ejemplo: \n"++
                 "> compose f g \n"                        

  help_string "hderivate" =  "Sintaxis: hderivate <f_id> <Real> <h>                               \n"++
                     "Descripción: Aproxima el valor de la derivada de una función en un   \n"++
                     "punto mediante diferencias finitas. La aproximación es mejor cuando  \n"++
                     "menor es h.\n"++
                     "El identificador debe corresponder a una funcion previamente definida.\n"++
                     "Ejemplo: \n"++
                     "> hderivate f 2.1 0.0001 \n"            
  help_string "derivate" =  "Sintaxis: derivate <f_id>                                \n"++
                     "Descripción: Genera la función derivada de una función argumento.\n"++
                     "La derivada resultante es guardada en un identificador temporal ans \n"++
                     "Ejemplo: \n"++
                     "> derivate f \n"   ++         
                     "> def df(x) = ans (x) \n"   
                        
  help_string "bisection" =   "Sintaxis:    bisection <f_id> <a> <b> <delta>                          \n"++
                              "Descripción: Aproxima el valor de una raíz de la función en el inter-  \n"++
                              "valo [a,b]. La diferencia entre la raíz real y la aproximada será menor\n"++
                              "a la tolerancia delta.\n"                                                 ++
                              "Hipótesis: La función debe ser contínua.\n"                               ++
                              "           f(a) * f(b) <= 0             \n"                               ++
                              "Observaciones: El método siempre converge.\n"                             ++                
                              "Ejemplo: \n"                                                              ++
                              "> bisection f -4 10.2  0.0001 \n"      

  help_string "regula_falsi" =   "Sintaxis:    regula_falsi <f_id> <a> <b> <delta> <epsilon> <maxit>    \n"++
                                 "Descripción: Aproxima el valor de una raíz de la función en el inter-\n" ++
                                 "valo [a,b], en a lo sumo maxit iteraciones.                          \n" ++
                                 "Si x el la aproximación y r es el valor verdadero, entonces, se garan-\n"++
                                 "tiza que si | x - r | <= delta o  | f(x) | <= epsilon entonces el    \n" ++
                                 "método terminará.    \n"                                                 ++
                                 "Hipótesis: La función debe ser contínua.\n"                              ++
                                 "           f(a) * f(b) <= 0             \n"                              ++                      
                                 "Observaciones: El método siempre converge.\n"                            ++                 
                                 "Ejemplo: \n"                                                             ++
                                 "> regula_falsi f -4 10.2 0.0001 0.0001 1000\n"
                         

  help_string "newton_raphson" = "Sintaxis:    newton_raphson <f_id> <f'_id> <p0> <delta> <epsilon> <maxit>    \n"++
                                 "Descripción: Aproxima el valor de una raíz de la función, a partir de\n"++
                                 "una aproximación inicial p0. Se necesita proveer le función derivada,\n"++
                                 "en caso de desconocerla utilizar la función hnewton_raphson.\n"           ++
                                 "Se garantiza que no se harán más de maxit iteraciones, y que si el méto-\n"++
                                 "do converge, la raíz x hallada diferirá a lo sumo en delta de la real; \n"++
                                 "y su imágen en epsilon de 0.\n"++
                                 "Hipótesis: La función debe ser contínua y derivable.\n"++              
                                 "Observaciones: El método converge o diverge dependiendo del p0 elegido.\n"++                
                                 "Ejemplo: \n"++
                                 "> newton_raphson f df 2  0.0001 0.0001 1000\n"  

  help_string "hnewton_raphson" =   "Sintaxis:    hNewton_Raphson <f_id> <p0> <delta> <epsilon> <h> <maxit>    \n"++
                             "Descripción: Aproxima el valor de una raíz de la función, a partir de\n"++
                             "una aproximación inicial p0. Dado que se precisa la función derivada,\n"++
                             "se aproxima usando diferencias finitas con precisión h (menor h, mayor.\n"++
                             "precisión).\n"++
                             "Se garantiza que no se harán más de maxit iteraciones, y que si el méto-\n"++
                             "do converge, la raíz x hallada diferirá a lo sumo en delta de la real; \n"++
                             "y su imágen en epsilon de 0.\n"++
                             "Hipótesis: La función debe ser contínua y derivable.\n"++              
                             "Observaciones: El método converge o diverge dependiendo del p0 elegido.\n"++                
                             "Ejemplo: hnewton_raphson f 2 0.0001 0.0001 0.01 1000 \n"
                             
  help_string "secante" =    "Sintaxis:    secante <f_id> <f'_id> <p0> <p1> <delta> <epsilon> <maxit>    \n"++
                             "Descripción: Aproxima el valor de una raíz de la función, a partir de\n"++
                             "dos aproximacioes iniciales p0 y p1. Se necesita proveer le función derivada,\n"++
                             "en caso de desconocerla utilizar la función hSecante.\n"           ++
                             "Se garantiza que no se harán más de maxit iteraciones, y que si el méto-\n"++
                             "do converge, la raíz x hallada diferirá a lo sumo en delta de la real; \n"++
                             "y su imágen en epsilon de 0.\n"++
                             "Hipótesis: La función debe ser contínua y derivable.\n"++              
                             "Observaciones: El método converge o diverge dependiendo p0 y p1 elegidos.\n"++                
                             "Ejemplo: \n"++
                             "> secante f df 2 3 0.0001 0.0001 1000\n"  

  help_string "hsecante" =   "Sintaxis:    hsecante <f_id> <h> <p0> <p1> <delta> <epsilon> <maxit>    \n"++
                             "Descripción: Aproxima el valor de una raíz de la función, a partir de\n"++
                             "dos aproximacioes iniciales p0 y p1. Dado que se precisa la función derivada,\n"++
                             "se aproxima usando diferencias finitas con precisión h (menor h, mayor.\n"++
                             "precisión).\n"++
                             "Se garantiza que no se harán más de maxit iteraciones, y que si el méto-\n"++
                             "do converge, la raíz x hallada diferirá a lo sumo en delta de la real; \n"++
                             "y su imágen en epsilon de 0.\n"++
                             "Hipótesis: La función debe ser contínua y derivable.\n"++              
                             "Observaciones: El método converge o diverge dependiendo del p0 elegido.\n"++                
                             "Ejemplo: \n"++
                             "> hsecante f  0.0001 1 4 0.0001 0.001 1000\n"  
                                                                                                                                                                                                                        
  help_string "trapecio" =   "Sintaxis:    trapecio <f_id> <a> <b>   \n"++
                             "Descripción: Aproxima el valor la integral definida de una función, entre\n"++
                             "desde a hasta b, utilizando el método del trapecio.\n"++               
                             "Ejemplo: \n"++
                             "> trapecio f -5 2\n"  
  help_string "simpson" =   "Sintaxis:    simpson <f_id> <a> <b> \n"++
                             "Descripción: Aproxima el valor la integral definida de una función, entre\n"++
                             "desde a hasta b, utilizando el método de simpson.\n"++               
                             "Ejemplo: \n"++
                             "> simpson f -5 2\n"  
  help_string "trapecio_compuesto" =   "Sintaxis:    trepecio_compuesto <f_id> <a> <b> <n_subint>   \n"++
                             "Descripción: Aproxima el valor la integral definida de una función, entre\n"++
                             "desde a hasta b, utilizando el método del trapecio compuesto, que consiste\n"++    
                             "en aplicar el método del trapecio en n_subint subintervalos del mismo tamaño.\n"++               
                             "Ejemplo: \n"++
                             "> trapecio_compuesto f -5 2 10\n"  
  help_string "simpson_compuesto" =   "Sintaxis:    simpson_compuesto  <f_id> <a> <b> <n_subint \n"++
                             "Descripción: Aproxima el valor la integral definida de una función, entre\n"++
                             "desde a hasta b, utilizando el método de simpson compuesto, que consiste\n"++    
                             "en aplicar el método de simpson en n_subint subintervalos del mismo tamaño.\n"++               
                             "Ejemplo: \n"++
                             "> simpson_compuesto f -5 10 2\n"  
                                                                                                                                                                                                                        

  help_string "interpolacion_lagrange" = "Sintaxis:    interpolacion_lagrange <f_id> <[Real]>\n"++
                             "Descripción: Genera un polinomio para aproximar la función argumento \n"++
                             "que coincide con ella en todos los puntos provistos en el segundo argumento.\n"++                  
                     "El polinomio es guardado en un identificador temporal ans \n"++
                             "Ejemplo: \n"++
                             "> interpolacion_lagrange f [0,2.5,5,6.7] \n" 
  help_string "interpolacion_newton" = "Sintaxis:    interpolacion_newton <f_id> <[Real]>\n"++
                             "Descripción: Genera un polinomio para aproximar la función argumento \n"++
                             "que coincide con ella en todos los puntos provistos en el segundo argumento.\n"++                  
                     "El polinomio es guardado en un identificador temporal ans \n"++
                             "Ejemplo: \n"++
                             "> interpolacion_newton f [0,2.5,5,6.7] \n" 
  help_string "chebyshev" = "Sintaxis:    chebyshev <f_id> <a> <b> <n>\n"++
                            "Descripción: Genera un polinomio para aproximar la función argumento \n"++
                            "en el intervalo a b, usando n_nodos de interpolación que son seleccio-\n"++       
                            "nados para que la suma del error sea mínima.\n"++                                                 
                            "El polinomio resultante es guardado en un identificador temporal ans \n"++
                            "Ejemplo: \n"++
                            "> chebyshev f -2 4 5 \n"                             
  help_string "taylor"    = "Sintaxis:    taylor <f_id> <a> <h> <n>\n"++
                            "Descripción: Genera el polinomio de taylor de f de grado n alrededor de \n"++
                            "a. El real h es usado para aproximar las n primeras derivadas de f en a.\n"++       
                            "f debe ser contínua y derivable en un entorno de a suficientemente grande.\n"++                                                 
                            "El polinomio resultante es guardado en un identificador temporal ans \n"++
                            "Ejemplo: \n"++
                            "> taylor f 0 0.001 5 \n"                                   
  help_string xs = "Comando inexistente. Ingrese :help para ver la lista de comandos. \n"
       
------------------------------------------------------------------------
-- Manejo de la carga de definiciones desde archivos .mn

  compileFiles :: [String] -> State -> IO State 
  compileFiles [] s      = return s
  compileFiles (x:xs) s  = do s' <- compileFile (s {lfile=x, inter=False})  x
                              compileFiles xs s'

  compileFile :: State -> String -> IO State 
  compileFile state@(S {..}) f = do
      putStrLn ("Abriendo "++f++"...")
      let f'= reverse(dropWhile isSpace (reverse f))
      x     <- catch (readFile f')
                 (\e -> do let err = show (e :: IOException)
                           hPutStr stderr ("No se pudo abrir el archivo " ++ f' ++ ": " ++ err ++"\n")
                           return "")
      stmts <- parseIO f' (stmts_parse) x  
      if isNothing stmts then return state
                         else handle_fold state (fromJust stmts)  

-- esto es para poder redefinir en un mismo scritpt
  handle_fold s []     = return s
  handle_fold s (x:xs) = do  s' <- handleStmt s x
                             handle_fold s' xs                


  compilePhrase :: State -> String -> IO State
  compilePhrase state x =
    do
      x' <- parseIO "<interactive>" stmt_parse x  
      maybe (return state) (handleStmt state) x'


------------------------------------------------------------------------
-- Parseo  

  parseIO :: String -> (String -> ParseResult a) -> String -> IO (Maybe a)
  parseIO f p x = case p x of
                       Failed e  -> do putStrLn (f++": "++e) 
                                       return Nothing
                       Ok r      -> return (Just r)
              
------------------------------------------------------------------------

  prelude :: String
  prelude = "Prelude.mn"
  
------------------------------------------------------------------------
 
