/*
   CONSTFOLDING.C : THIS FILE IMPLEMENTS THE CONSTANT FOLDING OPTIMIZATION
*/

#include "constfolding.h"
/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL 
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO 
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/                                                                                                          
bool madeChange = 0;

/*
******************************************************************************************
FUNCTION TO CALCULATE THE CONSTANT EXPRESSION VALUE 
OBSERVE THAT THIS IMPLEMENTATION CONSIDERS ADDITIONAL OPTIMIZATIONS SUCH AS:
1.  IDENTITY MULTIPLY = 1 * ANY_VALUE = ANY_VALUE - AVOID MULTIPLICATION CYCLE IN THIS CASE
2.  ZERO MULTIPLY = 0 * ANY_VALUE = 0 - AVOID MULTIPLICATION CYCLE
3.  DIVIDE BY ONE = ORIGINAL_VALUE - AVOID DIVISION CYCLE
4.  SUBTRACT BY ZERO = ORIGINAL_VALUE - AVOID SUBTRACTION
5.  MULTIPLICATION BY 2 = ADDITION BY SAME VALUE [STRENGTH REDUCTION]
******************************************************************************************
*/
long CalcExprValue(Node* node)  // need to handle the binary logical expressions
{
     long result;
     Node *leftNode, *rightNode;
     leftNode = node->left;
     rightNode = node->right; 
     switch(node->opCode){ // we know this is an operation
     // MAKE SURE ALL THE OPERATION CASES ARE HANDLED
         case MULTIPLY: 
             if(leftNode->value == 1) { // just optimizations for the multiply case
                 result = rightNode->value;
             } 
             else if(rightNode->value == 1) {
                 result = leftNode->value;
             }
             else if(leftNode->value == 0 || rightNode->value == 0) {
                 result = 0;
             }
             else if(leftNode->value == 2) {
                 result = rightNode->value + rightNode->value;
             }              
             else if(rightNode->value == 2) {
                 result = leftNode->value + leftNode->value;
             }
             else {
                 result = leftNode->value * rightNode->value;
                 // if it's a multiplication, the left node value * the right node value
             }
             break;
         case DIVIDE:
             if(rightNode->value == 1) {
                 result = leftNode->value;
             }
             else {
                 result = leftNode->value / rightNode->value;
             }
             break;
         case ADD:
             result = leftNode->value + rightNode->value;
             break;
         case SUBTRACT:
             result = leftNode->value - rightNode->value;
             break;
         case NEGATE:
             result = -leftNode->value;
             break;
         case BOR:
             result = leftNode->value | rightNode->value;
             break;
         case BAND: 
             result = leftNode->value & rightNode->value;
             break;
         case BXOR: 
             result = leftNode->value ^ rightNode->value;
             break;
         case BSHR:
             result = leftNode->value >> rightNode->value;
             break;
         case BSHL:
             result = leftNode->value << rightNode->value;
             break;
         // what about FUNCTIONCALL? 
         default:
             break;
     }
     return result;
}

/*
*****************************************************************************************************
THIS FUNCTION IS MEANT TO PROCESS THE CANDIDATE STATEMENTS AND PERFORM CONSTANT FOLDING 
WHEREVER APPLICABLE.
******************************************************************************************************
*/
long ConstFoldPerStatement(Node* ){
    long result;

    /*
    *************************************************************************************
          TODO: YOUR CODE HERE
    **************************************************************************************
    */                                                                                                         
    return result;
}


/*
*****************************************************************************************************
THIS FUNCTION IS MEANT TO IDENTIFY THE STATEMENTS THAT ARE ACTUAL CANDIDATES FOR CONSTANT FOLDING
AND CALL THE APPROPRIATE FUNCTION FOR THE IDENTIFIED CANDIDATE'S CONSTANT FOLDING
******************************************************************************************************
*/
void ConstFoldPerFunction(Node* funcNode) {
      Node *rightNode, *leftNode;
      NodeList* statements = funcNode->statements;
      while(statements != NULL) {
          Node *assignStatement = statements->node;
        //   printf("%d\n", assignStatement->stmtCode);

          if (assignStatement->stmtCode == ASSIGN) // can't be return statement, must be assign
          {
                Node *expression = statements->node->right; // we know this is an expression
                // we want to check what type of expression it is (i.e., is it an operation)
                if (expression->exprCode == OPERATION)                                          
                {
                    if (expression->opCode == NEGATE &&
                        expression->left->exprCode == CONSTANT &&
                        expression->right == NULL) // special case: expression->right is NULL in NEGATE
                    {
                        long val = -expression->left->value;
                        // take the right child, free it, and insert your new one.
                        FreeOperation(statements->node->right); // will not free referenced statement
                        statements->node->right = CreateNumber(val); // create a node with this value
                        madeChange = 1;
                    }
                    else if (expression->left->exprCode == CONSTANT && 
                        expression->right->exprCode == CONSTANT) // both expressions are constants
                    {
                        long val = CalcExprValue(expression);
                        // take the right child, free it, and insert your new one.
                        FreeOperation(statements->node->right); // will not free referenced statement
                        statements->node->right = CreateNumber(val); // create a node with this value
                        madeChange = 1;
                    }
                    // else one of the left or right is a variable or func, can't fold
                }  
        
            }
            statements = statements->next;
    }                                                                                                                       
}
     
/*
*****************************************************************************************************
THIS FUNCTION ENSURES THAT THE CONSTANT FOLDING OPTIMIZATION IS DONE FOR EVERY FUNCTION IN THE PROGRAM
******************************************************************************************************
*/

bool ConstantFolding(NodeList* list) {
    madeChange = false;
    while(list != NULL) {
        // going through a list of nodes
        // just had it call constfoldperfunction on each list node
        ConstFoldPerFunction(list->node);
	    list = list->next;
    }
    return madeChange;
}

/*
****************************************************************************************************************************
 END OF CONSTANT FOLDING
*****************************************************************************************************************************
*/                
