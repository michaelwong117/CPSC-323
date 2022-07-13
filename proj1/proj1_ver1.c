#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "proj1.h"


// how does expansion work??
// expansion has to be quite similar to this, except for the case
// when there is an argument #
// if the only difference between how a state machine for regular input
// and macros is the hashtag #, have a flag that says hi, i'm in a macro
// and so if you're in a macro you process hashtags 

// if it's custom, go back to plaintext with expansion flag
// this needs to handle the # case
// # is only in the case of a custom macro

// otherwise we know it's built-in
// we have the macro name, # args, and the args
// call handle function

// for a definition, all that does is string compare, it's a def
// then just assign your values in the macrolist

// if it's something like an if, see if the first arg is an empty string
// depending on whether or not it is, push values onto stack and move back
// to plaintext


// if it's an include macro, read the filenmae, open that file
// remove comments
// push its contents onto the stack

// \expandafter{BEFORE}{AFTER}
// have to process the AFTER, but then put the text of BEFORE
// tick could be putting the AFTER string into the intermediary buffer
// (meaning the result string)
// once you've finished processing after, you can go back
// to putting stuff on the output buffer

typedef enum state_c
{
    plain,
    c_escape,
    comment,
    space_newline,


} state_c;

typedef enum state_t
{
    plaintext,
    escape,
    macro,
    argument,

} state_t;

typedef struct string_t
{
    char * data;
    size_t size;
    size_t capacity;
} string_t;

string_t* createString(size_t capacity)
{
    string_t* str = (string_t * ) malloc(sizeof(string_t));
    str->capacity = capacity;
    str->size = 0;
    str->data = (char *) malloc(str->capacity * sizeof(char));

    return str;
}

void destroyString(string_t * str)
{
    if (str == NULL) return;
    free(str->data);
    free(str);
}

void addString(string_t *string, char in)
{
    string->data[string->size] = in;
    string->size++;

    // we are at string capacity, double size
    if (string->size == string->capacity)
    {
        string->capacity *= 2;
        string->data = (char *) realloc(string->data, sizeof(char) * string->capacity);
    }
}

// A structure to represent a "string" stack
// insert strings backwards into the stack
typedef struct Stack 
{
    size_t size;
    size_t capacity;
    char * array;
} Stack;

Stack* createStack(size_t capacity)
{
    Stack* stack = (Stack * ) malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->size = 0;
    stack->array = (char *) malloc(stack->capacity * sizeof(char));

    return stack;
}

int isEmpty(Stack* stack)
{
    return stack->size == 0;
}

void push(Stack* stack, char c)
{
    stack->array[stack->size] = c;
    stack->size++;
    if (stack->size == stack->capacity)
    {
        stack->capacity *= 2;
        stack->array = (char *) realloc(stack->array, sizeof(char) * stack->capacity);
    }
}
char pop(Stack* stack)
{
    return stack->array[--stack->size];
}

void destroyStack(Stack* stack)
{
    if (stack == NULL) return;
    free(stack->array);
    free(stack);
}

string_t *input;

Stack *stack;

void commentRemoval(FILE *in_file) // put cleaned file to global var input
{
    state_c state = plain; // remove comments first via state machine

    char in = fgetc(in_file);

    while (in != EOF)
    {
        switch (state) // without breaks, flows over wo regard for state
        {

            // already encountered a newline after the comment,
            // looking for first non-blank, non-tab char
            case space_newline: 
            if (!isblank(in))
            {
                state = plain; // doesn't move to next char yet
            }
            else
            {
                in = fgetc(in_file);
            }
                break;

            case c_escape: // escapes whatever comes after it
            // even if it's a %, add escaped % to string, not a comment
            state = plain;
            // add escaped % to string, not a comment
            addString(input, in);

            in = fgetc(in_file);

                break; 

            case plain:
            if (in == '%')
            {
                state = comment;
            }
            else
            {
                if (in == '\\')
                {
                    state = c_escape;
                }
                // process plain text! (also don't remove escapes yet)
                addString(input, in);
            }
            in = fgetc(in_file);
                break;

            case comment:
            if (in == '\n')
            {
                state = space_newline;
            }
            in = fgetc(in_file); 
                break;

        }
    }
}

// this is for custom macros only: otherwise strcmp against "\def, \ifdef",...
typedef struct Macro 
{
    string_t *name;
    string_t *value;
} Macro;


typedef struct MacroList
{
    Macro **data;
    size_t size;
    size_t capacity;
} MacroList;

MacroList* createMacroList()
{
    MacroList* macros = (MacroList *) malloc(sizeof(MacroList));
    macros->capacity = 100;
    macros->size = 0;
    macros->data = (Macro **) malloc(macros->capacity * sizeof(Macro *));

    return macros;

}

void addMacro(MacroList* macros, Macro* m)
{
    macros->data[macros->size] = m;
    macros->size++;
    // we are at capacity, double size
    if (macros->size == macros->capacity)
    {
        macros->capacity *= 2;
        macros->data = (Macro **) realloc(macros->data, macros->capacity * sizeof(Macro *));
    }
}

Macro* createMacro(string_t * name, string_t * value)
{
    Macro* macro = (Macro *) malloc(sizeof(Macro));
    macro->name = name;
    macro->value = value;

    return macro;
}


string_t* findMacro(MacroList *macros, string_t * name)
{
    for (int i = 0; i < macros->size; i++)
    {
        if (strcmp(name->data, macros->data[i]->name->data) == 0)
        {
            return macros->data[i]->value;
        }
    }
    return NULL;
}


MacroList *macros;

void readDef()
{
    string_t * NAME = createString(100);

    char curr = pop(stack);

    while (curr != '}')
    {
        if(!isalnum(curr))
        {
            //non alphanum macro name: WARN, DIE
            exit(-1);
        }
        addString(NAME, curr);

        if (stack->size == 0) exit(-1);
        else curr = pop(stack);
    } 
    
    printf("%s\n", NAME->data);

    // Reading VALUE now
    string_t * value = createString(100);

    curr = pop(stack); // {ARGUMENT}{VALUE}

    if (curr != '{') // if it's not starting the value argument, error
    {
        exit(-1);
    }
    int braces = 1;

    // \valid{this arg {{ is }} balanced}

    while (braces > 0)
    {
        // in the first instance, this goes from { to first arg char

        curr = pop(stack);
        if (curr == '{')
        {
            braces++;
        }
        else if (curr == '}')
        {
            braces--;
            if (braces == 0) break;
        }
        
        addString(value, curr);
    } 

    printf("%s\n", value->data);

    Macro *m = createMacro(NAME, value);

    addMacro(macros, m);
}

string_t * getNextName()
{
    string_t * NAME = createString(100);

    char curr = pop(stack);

    while (curr != '}')
    {
        if(!isalnum(curr))
        {
            //non alphanum macro name: WARN, DIE
            exit(-1);
        }
        addString(NAME, curr);

        if (stack->size == 0) exit(-1);
        else curr = pop(stack);
    }
    return NAME;
}
string_t * getNextArg() // can be alphanumeric or non-alphanumeric (also brace-balances)
{
    string_t * value = createString(100);

    char curr = pop(stack); // {ARGUMENT}{VALUE}

    if (curr != '{') // if it's not starting the value argument, error
    {
        exit(-1);
    }
    int braces = 1;

    // \valid{this arg {{ is }} balanced}

    while (braces > 0)
    {
        // in the first instance, this goes from { to first arg char

        curr = pop(stack);
        if (curr == '{')
        {
            braces++;
        }
        else if (curr == '}')
        {
            braces--;
            if (braces == 0) break;
        }
        
        addString(value, curr);
    }
    printf("%s\n", value);
    return value;
}

void expand(string_t * macroValue)
{   
    printf("%s\n", macroValue);
    string_t * arg = getNextArg();

    // printf("%s\n", arg->data);

    // int idx = value->size-1;
    // while (idx >= 0)
    // {
    //     if (value->data[idx] != '#')
    //     {
    //         push(stack, value->data[idx]);
    //     }
    //     else
    //     {

    //     }
    // }
}

typedef struct aug_state_t 
{
    state_t state;
    bool expansion; // whether or not we're expanding (1: need to process #)
                    // or just processing regular input (0)
    bool after; // whether or not we're processing the input in a buffer string
                // so we can append it to BEFORE before going to output
                // you can have nested expandafters, so just using a buffer won't work
                // a flag could handle one layer of expandafter
                // will have to  use recursion
    string_t * macro_name; // the name of the macro if we're processing one
    size_t args_c; // number of arguments
    // string_t **args;
    
} aug_state_t;


// once you know you're in a macro, build a parser to get the argument
// for the macro, and if relevant build a parser to get the macro value
void tick(char c)
{
    // static makes the variable retain its value between multiple function calls
    static aug_state_t state = {.state=plaintext, .expansion=0, .macro_name=NULL};
    // static state_t state = plaintext; // will not assign multiple times
    switch (state.state)
    {
        case plaintext:
        if (c == '\\')
        {
            state.state = escape;
        }
        else
        {
            printf("%c", c);
        }
            break;
        case escape:
        if (isalnum(c))
        {
            state.state = macro;
            // repush the same character to front
            // so it can get captured by the macro
            destroyString(state.macro_name); // destroys past name
            state.macro_name = createString(100);
            addString(state.macro_name, c);
        }
        else if (c == '\\' || c == '#' || c == '%' || c == '{'|| c == '}')
        {
            printf("%c", c);    
            state.state = plaintext;
        }
        else // non alphanumeric character that is not \, #, %, {, }
        { // treat escapes as normal characters
            printf("\\%c", c);
            state.state = plaintext;
        }
            break;
        case macro:
        if (c == '{')
        {
            state.state = argument;
            if (strcmp(state.macro_name->data, "def") == 0)
            {
                readDef();
                state.state = plaintext;
            }
            // undef
            // if
            // ...
            else // found a custom macro case
            {
                /**
                 * \def{testMacro}{some text #}
                 * \def{macroFragment}{goes #}
                 * \testMacro{\macroFragment}{here}
                **/

                // macro_name is testMacro
                // macroValue is some text #
                string_t * macroValue = findMacro(macros, state.macro_name);
                if (macroValue != NULL)
                {
                    expand(macroValue);
                    // expand(state.macro_name, find);
                    // printf("Found %s\n", state.macro_name->data);
                }
                else
                {
                    exit(-1); // undefined macro
                }
            }         
        }
        else if(isalnum(c))
        {
            addString(state.macro_name, c);
        }
        else
        {
            exit(-1); // non alphanumeric char in macro name
        }
    }      
            
}

int main(int argc, char*argv[])
{ 
    if (argc < 2)
    {
        // also handle stdin case here
        fprintf(stderr,"missing files\n");
        exit(-1);
    }

    FILE *in_file  = fopen(argv[1], "r");

    if (in_file == NULL) 
    {   
        fprintf(stderr,"Could not open %s\n", argv[1]);
        exit(-1); // must include stdlib.h 
    } 

    input = createString(100);
    macros = createMacroList();

    commentRemoval(in_file);

    // you have to read the argvs backwards because the last character
    // of the last argument's file to be the first character you push
    
    // printf("%s", input->data);
    // printf("%d\n", input->size);

    stack = createStack(100);

    int idx = input->size-1;

    while (idx >= 0) // anytime I need to expand, push into the stack backwards
    {
        push(stack, input->data[idx]);
        idx--;
    }
    while (stack->size > 0)
    {
        tick(pop(stack));
    }
}