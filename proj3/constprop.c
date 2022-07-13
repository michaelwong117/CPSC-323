/*
********************************************************************************
  CONSTPROP.C : IMPLEMENT THE DOWNSTREAM CONSTANT PROPOGATION OPTIMIZATION HERE
*********************************************************************************
*/

#include "constprop.h"
#include <stdio.h>
#include <stdlib.h>

refConst *lastNode, *headNode;
/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO FREE THE CONSTANTS-ASSOCIATED VARIABLES LIST
************************************************************************
*/
void FreeConstList()
{
   refConst* tmp;
   while (headNode != NULL)
    {
       tmp = headNode;
       headNode = headNode->next;
       free(tmp);
    }
  headNode = NULL;

}

/*
*************************************************************************
  FUNCTION TO ADD A CONSTANT VALUE AND THE ASSOCIATED VARIABLE TO THE LIST
**************************************************************************
*/
void UpdateConstList(char* name, long val) {
    refConst* node = malloc(sizeof(refConst));
    if (node == NULL) return;
    node->name = name;
    node->val = val;
    node->next = NULL;
    if(headNode == NULL) {
        lastNode = node;
        headNode = node;
    }
    else {
        lastNode->next = node;
        lastNode = node;
    }
}

/*
*****************************************************************************
  FUNCTION TO LOOKUP IF A CONSTANT ASSOCIATED VARIABLE IS ALREADY IN THE LIST
******************************************************************************
*/
refConst* LookupConstList(char* name) {
    refConst *node;
    node = headNode; 
    while(node!=NULL){
        if(!strcmp(name, node->name))
            return node;
        node = node->next;
    }
    return NULL;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
**********************************************************************************************************************************
*/

/*
************************************************************************************
  THIS FUNCTION IS MEANT TO UPDATE THE CONSTANT LIST WITH THE ASSOCIATED VARIABLE
  AND CONSTANT VALUE WHEN ONE IS SEEN. IT SHOULD ALSO PROPOGATE THE CONSTANTS WHEN 
  WHEN APPLICABLE. YOU CAN ADD A NEW FUNCTION IF YOU WISH TO MODULARIZE BETTER.
*************************************************************************************
*/
void TrackConst(NodeList* statements) {
    while(statements != NULL) {
      // PrintStatement(statements->node);
      Node* headerStatement = statements->node; // the header statement
      if (headerStatement->stmtCode == ASSIGN)
      {
        Node *expression = headerStatement->right; // we know this is an expression
        
        if (expression->exprCode == CONSTANT)                                          
        {
          refConst *result = LookupConstList(headerStatement->name);

          if (result == NULL) // this constant is not already in the list, update
          {
            // in ConstList: update the variable in headerStatement to = the value in expression
            UpdateConstList(headerStatement->name, expression->value);
          }
        }
        if (expression->exprCode == VARIABLE)                                          
        {
          refConst *result = LookupConstList(expression->name);
          if (result != NULL)
          {
            free(statements->node->right->name);
            statements->node->right->exprCode = CONSTANT;
            statements->node->right->value = result->val;
            // FreeExpression(statements->node->right);
            // statements->node->right = CreateNumber(result->val);
            madeChange = 1;
          }
        }
        if (expression->exprCode == OPERATION)                                          
        {
          if (expression->opCode == FUNCTIONCALL)
          {
            NodeList* args = expression->arguments;
            while (args != NULL)
            {
              refConst *result = LookupConstList(args->node->name);
              if (result != NULL)
              {
                free(args->node->name);
                args->node->exprCode = CONSTANT;
                args->node->value = result->val;
                // args->node = CreateNumber(result->val);
              }
              args = args->next;
            }
          }
          if (expression->left != NULL && expression->left->exprCode == VARIABLE)
          {
            refConst *result = LookupConstList(expression->left->name);
            if (result != NULL)
            {
              free(statements->node->right->left->name);
              statements->node->right->left->exprCode = CONSTANT;
              statements->node->right->left->value = result->val; 
              // FreeExpression(statements->node->right->left);
              // statements->node->right->left = CreateNumber(result->val);
              madeChange = 1;
            }
          }
          if (expression->right != NULL && expression->right->exprCode == VARIABLE)
          {
            refConst *result = LookupConstList(expression->right->name);
            if (result != NULL)
            {
              free(statements->node->right->right->name);
              statements->node->right->right->exprCode = CONSTANT;
              statements->node->right->right->value = result->val;
              // FreeExpression(statements->node->right->right);
              // statements->node->right->right = CreateNumber(result->val);
              madeChange = 1;
            }
          }
        }
      }
      else if (headerStatement->stmtCode == RETURN)
      {
        Node *expression = headerStatement->left;
        if (expression->exprCode == VARIABLE)                                          
        {
          refConst *result = LookupConstList(expression->name);
          if (result != NULL)
          {
            free(statements->node->left->name);
            statements->node->left->exprCode = CONSTANT;
            statements->node->left->value = result->val;
            // FreeExpression(statements->node->left);
            // statements->node->left = CreateNumber(result->val);
            madeChange = 1;
          }
        }
      }
      statements = statements->next;
    }
}


bool ConstProp(NodeList* worklist) {
    madeChange = false;
    while (worklist != NULL)
    {
      TrackConst(worklist->node->statements);
      FreeConstList();
      worklist = worklist->next;
    }

    return madeChange;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
**********************************************************************************************************************************
*/
