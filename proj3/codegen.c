/*
***********************************************************************
  CODEGEN.C : IMPLEMENT CODE GENERATION HERE
************************************************************************
*/
#include "codegen.h"

// bunch of globals that are useful

int argCounter;
int lastUsedOffset;
// it's a string of a location in the stack in reference to rbp
// -8(%rbp)
char lastOffsetUsed[100];
FILE *fptr;
regInfo *regList, *regHead, *regLast;
varStoreInfo *varList, *varHead, *varLast;
size_t totalVarinStack;

/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO INITIALIZE THE ASSEMBLY FILE WITH FUNCTION DETAILS
************************************************************************
*/

// initializes the assembly file, prints out important stuff we need
// first thing we want to call in a func
void InitAsm(char* funcName) {
    fprintf(fptr, "\n.globl %s", funcName);
    fprintf(fptr, "\n%s:", funcName); 

    // Init stack and base ptr
    fprintf(fptr, "\npushq %%rbp");  
    fprintf(fptr, "\nmovq %%rsp, %%rbp"); 
}

/*
***************************************************************************
   FUNCTION TO WRITE THE RETURNING CODE OF A FUNCTION IN THE ASSEMBLY FILE
****************************************************************************
*/
// last thing we want to call in a func
void RetAsm() {
    fprintf(fptr,"\npopq  %%rbp");
    fprintf(fptr, "\nretq\n");
} 

/*
***************************************************************************
  FUNCTION TO CONVERT OFFSET FROM LONG TO CHAR STRING 
****************************************************************************
*/
void LongToCharOffset() {
     lastUsedOffset = lastUsedOffset - 8;
     snprintf(lastOffsetUsed, 100,"%d", lastUsedOffset);
     strcat(lastOffsetUsed,"(%rbp)");
}

/*
***************************************************************************
  FUNCTION TO CONVERT CONSTANT VALUE TO CHAR STRING
****************************************************************************
*/
// more or less 
// lastUsedOffset keeps track where of your offset in the stack pointer is
// so you can fetch variables easier
void ProcessConstant(Node* opNode) { // pass in a node
     char value[10];
     LongToCharOffset();
     snprintf(value, 10,"%ld", opNode->value); // getting whatever current node's value is
     char str[100];
     snprintf(str, 100,"%d", lastUsedOffset);
     strcat(str,"(%rbp)"); // prints that value next to rbp, with a last used offset
    // when we use local variables, we can know what the current argument is
    // by checking lastusedoffset + rbp
     AddVarInfo("", str, opNode->value, true);
     fprintf(fptr, "\nmovq  $%s, %s", value, str);
}

/*
***************************************************************************
  FUNCTION TO SAVE VALUE IN ACCUMULATOR (RAX)
****************************************************************************
*/
void SaveValInRax(char* name) {
    char *tempReg;
    tempReg = GetNextAvailReg(true);
    if(!(strcmp(tempReg, "NoReg"))) {
        LongToCharOffset();
        fprintf(fptr, "\nmovq %%rax, %s", lastOffsetUsed);
        UpdateVarInfo(name, lastOffsetUsed, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
    else {
        fprintf(fptr, "\nmovq %%rax, %s", tempReg);
        UpdateRegInfo(tempReg, 0);
        UpdateVarInfo(name, tempReg, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
}



/*
***********************************************************************
  FUNCTION TO ADD VARIABLE INFORMATION TO THE VARIABLE INFO LIST
************************************************************************
*/
void AddVarInfo(char* varName, char* location, long val, bool isConst) {
   varStoreInfo* node = malloc(sizeof(varStoreInfo));
   node->varName = varName;
   node->value = val;
   strcpy(node->location,location);
   node->isConst = isConst;
   node->next = NULL;
   node->prev = varLast;
   if(varHead==NULL) {
       varHead = node;
       varLast = node;;
       varList = node;
   } else {
       //node->prev = varLast;
       varLast->next = node;
       varLast = varLast->next;
   }
   varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO FREE THE VARIABLE INFORMATION LIST
************************************************************************
*/
void FreeVarList()
{  
   varStoreInfo* tmp;
   while (varHead != NULL)
    {  
       tmp = varHead;
       varHead = varHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO LOOKUP VARIABLE INFORMATION FROM THE VARINFO LIST
************************************************************************
*/
char* LookUpVarInfo(char* name, long val) {
    varList = varLast;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(varList->isConst == true) {
            if(varList->value == val) return varList->location;
        }
        else {
            if(!strcmp(name,varList->varName)) return varList->location;
        }
        varList = varList->prev;
    }
    varList = varHead;
    return "";
}

/*
***********************************************************************
  FUNCTION TO UPDATE VARIABLE INFORMATION 
************************************************************************
*/
void UpdateVarInfo(char* varName, char* location, long val, bool isConst) {
  
   if(!(strcmp(LookUpVarInfo(varName, val), ""))) {
       AddVarInfo(varName, location, val, isConst);
   }
   else {
       varList = varHead;
       if(varList == NULL) printf("NULL varlist");
       while(varList!=NULL) {
           if(!strcmp(varList->varName,varName)) {
               varList->value = val;
               strcpy(varList->location,location);
               varList->isConst = isConst;
               break;
        }
        varList = varList->next;
       }
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE VARIABLE INFORMATION LIST
************************************************************************
*/
void PrintVarListInfo() {
    varList = varHead;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(!varList->isConst) {
            printf("\t %s : %s", varList->varName, varList->location);
        }
        else {
            printf("\t %ld : %s", varList->value, varList->location);
        }
        varList = varList->next;
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO ADD NEW REGISTER INFORMATION TO THE REGISTER INFO LIST
************************************************************************
*/
void AddRegInfo(char* name, int avail) {

   regInfo* node = malloc(sizeof(regInfo));
   node->regName = name;
   node->avail = avail;
   node->next = NULL; 

   if(regHead==NULL) {
       regHead = node;
       regList = node;
       regLast = node;
   } else {
       regLast->next = node;
       regLast = node;
   }
   regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO FREE REGISTER INFORMATION LIST
************************************************************************
*/
void FreeRegList()
{  
   regInfo* tmp;
   while (regHead != NULL)
    {  
       tmp = regHead;
       regHead = regHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO UPDATE THE AVAILIBILITY OF REGISTERS IN THE REG INFO LIST
************************************************************************
*/
void UpdateRegInfo(char* regName, int avail) {
    while(regList!=NULL) {
        if(regName == regList->regName) {
            regList->avail = avail;
        }
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO RETURN THE NEXT AVAILABLE REGISTER
************************************************************************
*/
char* GetNextAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            if(!noAcc) return regList->regName;
            // if not rax and dont return accumulator set to true, return the other reg
            // if rax and noAcc == true, skip to next avail
            if(noAcc && strcmp(regList->regName, "%rax")) { 
                return regList->regName;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return "NoReg";
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF ANY REGISTER APART FROM OR INCLUDING 
  THE ACCUMULATOR(RAX) IS AVAILABLE
************************************************************************
*/
int IfAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            // registers available
            if(!noAcc) return 1;
            if(noAcc && strcmp(regList->regName, "%rax")) {
                return 1;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return 0;
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF A SPECIFIC REGISTER IS AVAILABLE
************************************************************************
*/
bool IsAvailReg(char* name) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(!strcmp(regList->regName, name)) {
           if(regList->avail == 1) {
               return true;
           } 
        }
        regList = regList->next;
    }
    regList = regHead;
    return false;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE REGISTER INFORMATION
************************************************************************
*/
void PrintRegListInfo() {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        printf("\t %s : %d", regList->regName, regList->avail);
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************

************************************************************************
*/
void CreateRegList() {
    // Create the initial reglist which can be used to store variables.
    // 4 general purpose registers : AX, BX, CX, DX
    // 4 special purpose : SP, BP, SI , DI. 
    // Other registers: r8, r9
    // You need to decide which registers you will add in the register list 
    // use. Can you use all of the above registers?
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ***************************************
    */
   AddRegInfo("%rdi", 1);
   AddRegInfo("%rsi", 1);
   AddRegInfo("%rdx", 1);
   AddRegInfo("%rcx", 1);
   AddRegInfo("%r8", 1);
   AddRegInfo("%r9", 1);
   AddRegInfo("%r10", 1);
   AddRegInfo("%r11", 1);
}

/*
***********************************************************************
  THIS FUNCTION IS MEANT TO GET THE FUNCTION ARGUMENTS FROM STACK
************************************************************************
*/


int PutArgumentsFromStack(NodeList* arguments) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */
    while(arguments!=NULL) {
    /*
     ***********************************************************************
              TODO : YOUR CODE HERE
      THINK ABOUT WHERE EACH ARGUMENT COMES FROM. EXAMPLE WHERE IS THE 
      FIRST ARGUMENT OF A FUNCTION STORED.
     ************************************************************************
     */ 
        arguments = arguments->next;
    }
    return argCounter;
}


/*
*************************************************************************
  THIS FUNCTION IS MEANT TO PUT THE FUNCTION ARGUMENTS ON THE  STACK
**************************************************************************
*/

// whenever we get arguments, we want to push them onto the stack immediately

// we have a list of arguments, where we are in the stack
// we keep track of with last used offset
// so if we have six arguments and we want to push each onto the stack
// we can use lastusedoffset location to assign each one at a time
// arg1 gets put in rbp + lastUsedOffset
// then add 8 to lastused
// then arg2 gets put in rbp + lastUsed...

// %rdi, %rsi, %rdx, %rcx, %r8, and %r9

void putToStack(Node * arg, char * reg)
{
    UpdateRegInfo(reg, 0);
    LongToCharOffset();
    AddVarInfo(arg->name, lastOffsetUsed, INVAL, 0);
    fprintf(fptr, "\nmovq %s, %s", reg, lastOffsetUsed);
}

void PutArgumentsOnStack(NodeList* arguments) {

    size_t i = 1;
    while(arguments!=NULL) {
    /*
    ***********************************************************************
        THINK ABOUT WHERE EACH ARGUMENT COMES FROM. EXAMPLE WHERE IS THE
        FIRST ARGUMENT OF A FUNCTION STORED AND WHERE SHOULD IT BE EXTRACTED
        FROM AND STORED TO..
    ************************************************************************
    */
        Node* arg = arguments->node;
        if (i == 1)
        {
            putToStack(arg, "%rdi");
        }
        if (i == 2)
        {
            putToStack(arg, "%rsi");
        }
        if (i == 3)
        {
            putToStack(arg, "%rdx");

        }
        if (i == 4)
        {
            putToStack(arg, "%rcx");
        }
        if (i == 5)
        {
            putToStack(arg, "%r8");

        }
        if (i == 6)
        {
            putToStack(arg, "%r9");

        }
        i++;
        arguments = arguments->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO PROCESS EACH CODE STATEMENT AND GENERATE 
  ASSEMBLY FOR IT. 
  TIP: YOU CAN MODULARIZE BETTER AND ADD NEW SMALLER FUNCTIONS IF YOU 
  WANT THAT CAN BE CALLED FROM HERE.
 ************************************************************************
 */  

void putVarintoReg(Node *var, char * reg)
{
    char* var_location = LookUpVarInfo(var->name, INVAL);

    // put it into rax
    fprintf(fptr, "\nmovq %s, %s", var_location, reg);
}
void putConstintoReg(Node * Const, char * reg)
{
    fprintf(fptr, "\nmovq $%ld, %s", Const->value, reg);       
}

void userSaveRAX(char* name) 
{
    LongToCharOffset();
    fprintf(fptr, "\nmovq %%rax, %s", lastOffsetUsed);
    UpdateVarInfo(name, lastOffsetUsed, INVAL, false);
    UpdateRegInfo("%rax", 1);   
}

void simpleOperations(Node * expr, Node * left, Node * right)
{
    // movq	-24(%rbp), %rdx
    // movq	-8(%rbp), %rax
    // ___q	%rdx, %rax
    if (left != NULL && left->exprCode == CONSTANT) // left goes into rax
    {
        putConstintoReg(left, "%rax");
    }
    if (left != NULL && left->exprCode == VARIABLE)
    {
        putVarintoReg(left, "%rax");  
    }
    if (right != NULL && right->exprCode == CONSTANT) // right goes into rdx
    {
        putConstintoReg(right, "%rdx");
    }
    if (right != NULL && right->exprCode == VARIABLE)
    {
        putVarintoReg(right, "%rdx");  
    }   
    
    if (expr->opCode == ADD)
    { //addq	%rdx, %rax
        fprintf(fptr, "\naddq %%rdx, %%rax");
    }
    if (expr->opCode == SUBTRACT)
    {
        fprintf(fptr, "\nsubq %%rdx, %%rax");
    }
    if (expr->opCode == BAND)
    {
        fprintf(fptr, "\nand %%rdx, %%rax");
    }
    if (expr->opCode == BOR)
    {
        fprintf(fptr, "\nor %%rdx, %%rax");
    }
    if (expr->opCode == BXOR)
    {
        fprintf(fptr, "\nxor %%rdx, %%rax");
    }
    if (expr->opCode == NEGATE)
    {
        fprintf(fptr, "\nneg %%rax");
    }
    if (expr->opCode == MULTIPLY)
    {
        fprintf(fptr, "\nimulq %%rdx, %%rax");
    }
}
void divideOperations(Node * expr, Node * left, Node * right)
{
    if (left != NULL && left->exprCode == CONSTANT) // left goes into rax
    {
        putConstintoReg(left, "%rax");
    }
    if (left != NULL && left->exprCode == VARIABLE)
    {
        putVarintoReg(left, "%rax");  
    }
    if (right != NULL && right->exprCode == CONSTANT) // right goes into rdx
    {
        putConstintoReg(right, "%rcx");
    }
    if (right != NULL && right->exprCode == VARIABLE)
    {
        putVarintoReg(right, "%rcx");  
    } 
    fprintf(fptr, "\ncqto");
    fprintf(fptr, "\nidivq %%rcx");
    
}
void shiftOperations(Node * expr, Node * left, Node * right)
{
    if (left != NULL && left->exprCode == CONSTANT) // left goes into rax
    {
        putConstintoReg(left, "%rax");
    }
    if (left != NULL && left->exprCode == VARIABLE)
    {
        putVarintoReg(left, "%rax");  
    }
    if (right != NULL && right->exprCode == CONSTANT) // right goes into rdx
    {
        putConstintoReg(right, "%rdx");
        fprintf(fptr, "\nmovl %%edx, %%ecx");
    }
    if (right != NULL && right->exprCode == VARIABLE)
    {
        putVarintoReg(right, "%rdx");
        fprintf(fptr, "\nmovl %%edx, %%ecx");
    }   
    // moving the number of bits needed to shift into ecx to be accessed by cl

    if (expr->opCode == BSHL)
    {
        fprintf(fptr, "\nsalq %%cl, %%rax");
    }
    if (expr->opCode == BSHR)
    {
        fprintf(fptr, "\nsar %%cl, %%rax");
    }
}
void functionCall(Node * funcNode)
{
    NodeList* args = funcNode->arguments;
    size_t i = 1;
    // you are moving your arguments into those six appropriate registers
    // put them into %rdi, rsi, etc.
    // then just print call func->name
    while (args != NULL)
    {
        Node * arg = args->node;
        if (arg->exprCode == CONSTANT)
        {
            if (i == 1) putConstintoReg(arg, "%rdi");
            if (i == 2) putConstintoReg(arg, "%rsi");
            if (i == 3) putConstintoReg(arg, "%rdx");
            if (i == 4) putConstintoReg(arg, "%rcx");
            if (i == 5) putConstintoReg(arg, "%r8");
            if (i == 6) putConstintoReg(arg, "%r9");
        }
        else if (arg->exprCode == VARIABLE)
        {
            if (i == 1) putVarintoReg(arg, "%rdi");
            if (i == 2) putVarintoReg(arg, "%rsi");
            if (i == 3) putVarintoReg(arg, "%rdx");
            if (i == 4) putVarintoReg(arg, "%rcx");
            if (i == 5) putVarintoReg(arg, "%r8");
            if (i == 6) putVarintoReg(arg, "%r9");
        }
        i++;
        args = args->next;
    }
    fprintf(fptr, "\ncall %s", funcNode->left->name);

}

size_t countVar(NodeList *statements)
{
    size_t res = 0;
    while(statements != NULL)
    {
        if (statements->node->stmtCode == ASSIGN) res++;
        statements = statements->next;
        // count the number of assignment statements
    }
    return res;
}

void allocStack()
{
    // add 48 to take parameters into account, can always oversub from rsp
    fprintf(fptr, "\nsubq $%d, %%rsp", 64 + totalVarinStack*8);
    // totalVarinStack - "total number of variables"
}

void resetStack()
{
    // add 48 to take parameters into account, can always oversub from rsp
    fprintf(fptr, "\naddq $%d, %%rsp", 64 + totalVarinStack*8);
}

void ProcessStatements(NodeList* statements) {
    while(statements != NULL) 
    {
        Node* header = statements->node; // the header statement
        // PrintStatement(header);
        // printf("\n");
        if (header->stmtCode == ASSIGN)
        { 
            // can only have assigns to operation: two variables, or constant and a variable
            // or an assignment to a variable

            Node* expr = header->right;  
            // assignment to a variable
            if (expr->exprCode == VARIABLE) // this should be an argument
            { // or a variable that has already been set as an address (temp3 = temp1 + temp2)
                // otherwise, optimizations would have evaluated it and removed it
                
                // location of the var that the header is being set to

                putVarintoReg(expr, "%rax");                
                
                LongToCharOffset();
                // add the new temp variable and its location
                AddVarInfo(header->name, lastOffsetUsed, INVAL, 0);
                
                //movq %rax, -40(%rbp)
                fprintf(fptr, "\nmovq %%rax, %s", lastOffsetUsed);    
            }
            if (expr->exprCode == OPERATION)
            {  
               Node * left = expr->left;
               Node * right = expr->right;
               switch (expr->opCode) {
                case ADD:
                case SUBTRACT:
                case NEGATE:
                case BOR:
                case BAND:
                case BXOR:
                case MULTIPLY:
                    simpleOperations(expr, left, right);  
                    break;
                case DIVIDE: // similar to multiplication, imul and idiv are similar
                    divideOperations(expr, left, right);  
                    break;
                case BSHR:
                case BSHL:
                    shiftOperations(expr, left, right);
                    break;
                case FUNCTIONCALL:
                    functionCall(expr);
                    break;
                default:
                    break;
               }
               userSaveRAX(header->name);
               //    movq	%rax, -32(%rbp) -> save result
            }
            // move the first thing into rax
            // move the second thing into rcx
            // do the operation with that

            // AddVarInfo(header->name, lastOffsetUsed, INVAL, 0);
        }
        else if (header->stmtCode == RETURN)
        {
            Node* expr = header->left;  
            if (expr->exprCode == CONSTANT)
            {
                putConstintoReg(expr, "%rax");
            }
            if (expr->exprCode == VARIABLE)
            {
                putVarintoReg(expr, "%rax");
            }
        }
        statements = statements->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO DO CODEGEN FOR ALL THE FUNCTIONS IN THE FILE
 ************************************************************************
*/
void Codegen(NodeList* worklist) {
    fptr = fopen("assembly.s", "w+");

    if(fptr == NULL) {
        printf("\n Could not create assembly file");
        return; 
    }
    while(worklist != NULL) {
        Node * func = worklist->node;
        
        InitAsm(func->name);
        CreateRegList();
        totalVarinStack = countVar(worklist->node->statements);
        allocStack();

        // don't need to pop off arguments because they will be overwritten
        // by the esp adding 

        PutArgumentsOnStack(func->arguments);
        // PrintVarListInfo(); 


        ProcessStatements(worklist->node->statements); 

        resetStack();
        RetAsm(func->name);
        worklist = worklist->next; 
    }
    fclose(fptr);
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS BELOW THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/


