
------------ MODULE clock ----------
VARIABLE clock
vars == << clock >>
Inv == clock \in {0, 1}  
Init == clock \in {0, 1}  
Tick == 
    IF clock == 0
      THEN clock' = 1
      ELSE clock' = 0

Spec == 
    /\ Init
    /\ [][Tick]_vars
    /\ WF_vars(Tick)

(* https://segmentfault.com/a/1190000040865237 *)
