#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
 
     bool CF = 1;
     bool CP = 1;
     bool DA = 1;
     while (DA || CF || CP)
     {
          CF = ConstantFolding(funcdecls);
          CP = ConstProp(funcdecls);
          // printf(CF ? "constant folding has changed\n" : "no change from CF\n");
          // printf(CP ? "constant prop has changed\n" : "no change from CP\n");
          DA = DeadAssign(funcdecls);
     }    
     // changeMade = 
     
     
}
