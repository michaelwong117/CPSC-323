/*
***********************************************************************
  DEADASSIGN.C : IMPLEMENT THE DEAD CODE ELIMINATION OPTIMIZATION HERE
************************************************************************
*/

#include "deadassign.h"

int change;
refVar *last, *head;
bool changeMade = 0;

/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO INITIALIZE HEAD AND LAST POINTERS FOR THE REFERENCED 
  VARIABLE LIST.
************************************************************************
*/

void init()
{ 
    head = NULL;
    last = head;
}

/*
***********************************************************************
  FUNCTION TO FREE THE REFERENCED VARIABLE LIST
************************************************************************
*/

void FreeList()
{
   refVar* tmp;
   while (head != NULL)
    {
       tmp = head;
       head = head->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO IDENTIFY IF A VARIABLE'S REFERENCE IS ALREADY TRACKED
************************************************************************
*/
bool VarExists(char* name) {
   refVar *node;
   node = head;
   while(node != NULL) {
       if(!strcmp(name, node->name)) {
           return true;
       }
       node = node->next;
    }
    return false;
}

/*
***********************************************************************
  FUNCTION TO ADD A REFERENCE TO THE REFERENCE LIST
************************************************************************
*/
void UpdateRefVarList(char* name) {
    // printf("Found %s referenced!\n", name);
    refVar* node = malloc(sizeof(refVar));
    if (node == NULL) return;
    node->name = name;
    node->next = NULL;
    if(head == NULL) {
        last = node;
        head = node;
    }
    else {
        last->next = node;
        last = node;
    }
}

/*
****************************************************************************
  FUNCTION TO PRINT OUT THE LIST TO SEE ALL VARIABLES THAT ARE USED/REFERRED
  AFTER THEIR ASSIGNMENT. YOU CAN USE THIS FOR DEBUGGING PURPOSES OR TO CHECK
  IF YOUR LIST IS GETTING UPDATED CORRECTLY
******************************************************************************
*/
void PrintRefVarList() {
    refVar *node;
    node = head;
    if(node==NULL) {
        printf("\nList is empty"); 
        return;
    }
    while(node != NULL) {
        printf("\t %s", node->name);
        node = node->next;
    }
}

/*
***********************************************************************
  FUNCTION TO UPDATE THE REFERENCE LIST WHEN A VARIABLE IS REFERENCED 
  IF NOT DONE SO ALREADY.
************************************************************************
*/
void UpdateRef(Node* node) {
      if(node->right != NULL && node->right->exprCode == VARIABLE) {
          if(!VarExists(node->right->name)) {
              UpdateRefVarList(node->right->name);
              changeMade = true;
          }
      }
      if(node->left != NULL && node->left->exprCode == VARIABLE) {
          if(!VarExists(node->left->name)) {
              UpdateRefVarList(node->left->name);
              changeMade = true;
          }
      }
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
**********************************************************************************************************************************
*/


/*
********************************************************************
  THIS FUNCTION IS MEANT TO TRACK THE REFERENCES OF EACH VARIABLE
  TO HELP DETERMINE IF IT WAS USED OR NOT LATER
********************************************************************
*/

void TrackRef(Node* funcNode) {
     NodeList* statements = funcNode->statements;
     Node *node;
     while(statements != NULL) {
        /*****************************************
              TODO : YOUR CODE HERE
        *****************************************/        
	    statements = statements->next;
     }
}

void FindReturn(NodeList* statements)
{
  while(statements != NULL) 
  {
    Node* headerStatement = statements->node;
    if (headerStatement->stmtCode == RETURN)
    {
      // PrintStatement(statements->node);
      Node *expression = headerStatement->left;
      if (expression->exprCode == VARIABLE)                                          
      {
        if (!VarExists(expression->name))
        {
          UpdateRefVarList(expression->name);
        }
      }
    }
    statements = statements->next;
  }
}

/*
***************************************************************
  THIS FUNCTION IS MEANT TO DO THE ACTUAL DEADCODE REMOVAL
  BASED ON THE INFORMATION OF TRACKED REFERENCES
****************************************************************
*/
void RemoveDead(NodeList* statements) {
    changeMade = false;
    // printf(changeMade ? "dead assign changeMade is true\n" : "no change from DA\n");
    while(statements != NULL) {
      Node* headerStatement = statements->node;
      // printf("This is the header:\n");
      // PrintStatement(headerStatement);
      // printf("\n");
      if (headerStatement->stmtCode == ASSIGN)
      {
        Node *expression = headerStatement->right; // we know this is an expression
        if (VarExists(headerStatement->name))
        {

          // printf("found connection: %s to ", headerStatement->name);
          // PrintExpression(expression);
          // printf("\n");

          if (expression->exprCode == VARIABLE)                                          
          {
            if (!VarExists(expression->name))
            {
              UpdateRefVarList(expression->name);
              changeMade = true;
            }
          }
          else if (expression->exprCode == OPERATION)                                          
          {
            if (expression->opCode == FUNCTIONCALL)
            {
              NodeList* args = expression->arguments;
              while (args != NULL)
              {
                // check to make sure constprop didn't already replace the arg with a const
                if (args->node->exprCode != CONSTANT && !VarExists(args->node->name))
                {
                  UpdateRefVarList(args->node->name);
                  changeMade = true;
                }
                args = args->next;
              }
            }
            if (expression->left != NULL && expression->left->exprCode == VARIABLE)
            {
              if (!VarExists(expression->left->name))
              {
                UpdateRefVarList(expression->left->name);
                changeMade = true;
              }
            }
            if (expression->right != NULL && expression->right->exprCode == VARIABLE)
            {
              if (!VarExists(expression->right->name))
              {
                UpdateRefVarList(expression->right->name);
                changeMade = true;
              }
            }
            
          }
        }
      }
      // printf("inside statements\n");
      statements = statements->next;
    }
}
// removes all dead code
// returns a pointer to the new head
NodeList * removeDeadCode(NodeList * statements)
{
  NodeList* first = statements;
  NodeList *prev = NULL;
  while (statements != NULL)
  {
    Node* header = statements->node;
    NodeList* curr = statements;

    if (header->stmtCode == ASSIGN)
    {
      // PrintStatement(header);
      // printf("\n");

      // if the first node currently in statements is dead assigned
      if (prev == NULL && (!VarExists(header->name) || header->right->exprCode == CONSTANT))
      {
        FreeStatement(statements->node);
        statements = statements->next;
        first = statements;
        free(curr);
      }
      else if (!VarExists(header->name) || header->right->exprCode == CONSTANT)
      {
        prev->next = statements->next;
        FreeStatement(statements->node);
        statements = statements->next;
        free(curr);
      }
      else
      {
        prev = statements;
        statements = statements->next;
      }

    }
    else
    {
      prev = statements;
      statements = statements->next;
    }
  }
  return first;
}

/*
********************************************************************
  THIS FUNCTION SHOULD ENSURE THAT THE DEAD CODE REMOVAL PROCESS
  OCCURS CORRECTLY FOR ALL THE FUNCTIONS IN THE PROGRAM
********************************************************************
*/
bool DeadAssign(NodeList* worklist) {
  
  while (worklist != NULL)
  {
    FindReturn(worklist->node->statements);
    changeMade = true;
    while (changeMade)
    { // finds what's connected with return
      RemoveDead(worklist->node->statements);
    }
    // printf(changeMade ? "dead assign changeMade is true\n" : "no change from DA\n");
    if (changeMade == false) // no change in the ref variables, can safely remove dead
    {
      worklist->node->statements = removeDeadCode(worklist->node->statements);
    } 
    FreeList();
    worklist = worklist->next;
  }
  // create a reverse copy in trackrev

  return changeMade;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
**********************************************************************************************************************************
*/
 
