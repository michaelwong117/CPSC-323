#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "proj1.h"

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

} state_t;

typedef enum state_arg
{
    plain_arg,
    escape_char,

} state_arg;

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
    str->data = (char *) calloc(str->capacity, sizeof(char)); // calloc to init \0

    return str;
}

void destroyString(string_t * str)
{
    if (str == NULL) return;
    free(str->data);
    free(str);
}

void addChartoString(string_t *string, char in)
{
    string->data[string->size] = in;
    string->size++;

    // we are at string capacity - 1 (for \0 char), double size
    if (string->size == string->capacity - 1)
    {
        string->capacity *= 2;
        string->data = (char *) realloc(string->data, sizeof(char) * string->capacity);
    }
    string->data[string->size] = '\0';

}
void removeCharfromString(string_t *string)
{
    string->data[string->size] = '\0';
    string->size--;
}


// 0 if they're the same, 1 otherwise
bool stringCompare(string_t *s1, string_t *s2) 
{
    if (s1->size != s2->size) return 1;

    for (int i = 0; i < s1->size; i++)
    {
        if (s1->data[i] != s2->data[i]) return 1;
    }
    return 0;
}

string_t *input_global;

void commentRemoval(FILE *in_file, string_t *input) // put cleaned file to global var input
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
            addChartoString(input, in);

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
                addChartoString(input, in);
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
    struct Macro* next;
} Macro;

// linked list of Macros
typedef struct MacroList
{
    Macro *head; 
    size_t size;
} MacroList;

MacroList* createMacroList()
{
    MacroList* macros = (MacroList *) malloc(sizeof(MacroList));
    macros->size = 0;
    macros->head = NULL;
    return macros;
}

void addMacro(MacroList* macros, Macro* m)
{
    if (macros->head == NULL) macros->head = m;
    else
    {
        m->next = macros->head; // set m->next to be the prev head
        macros->head = m; // set head now to be the new macro m
    }
    macros->size++;
}

Macro* createMacro(string_t * name, string_t * value)
{
    Macro* macro = (Macro *) malloc(sizeof(Macro));
    macro->name = name;
    macro->value = value;
    macro->next = NULL;
    return macro;
}

void destroyMacro(Macro * m)
{
    destroyString(m->name);
    destroyString(m->value);
    free(m);
}

// returns a pointer to the macro with a matching name
Macro* findMacro(MacroList *macros, string_t * name)
{
    Macro * curr = macros->head;
    for (int i = 0; i < macros->size; i++)
    {
        if (strcmp(curr->name->data, name->data) == 0)
        {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}
void findDeleteMacro(MacroList *macros, string_t * name)
{
    if (macros == NULL || macros->head == NULL) return;
    Macro * curr = macros->head;
    if (stringCompare(curr->name, name) == 0)
    {
        macros->head = macros->head->next;
        destroyMacro(curr);
        macros->size--;
        return;
    }
    while (curr->next != NULL)
    {
        if (stringCompare(curr->next->name, name) == 0)
        {
            Macro *to_delete = curr->next;
            curr->next = curr->next->next;
            destroyMacro(to_delete);
            macros->size--;
            return;
        }
        curr = curr->next;
    }
    return;
}
MacroList *macros;
// starts with str_in->data[*idx] = '{' 
// ends with str_in->data[*idx] = next '{'
string_t* get_alnumArg(string_t* str_in, int *idx)
{
    string_t * NAME = createString(10);
    
    *idx = *idx + 1; // don't start c from {
    char curr = str_in->data[*idx];

    while (curr != '}')
    {
        if(!isalnum(curr))
        {
            //non alphanum macro name
            fprintf(stderr,"non alphanumeric char in macro name\n");
            exit(-1);
        }
        else
        {
            addChartoString(NAME, curr);
            *idx = *idx + 1;
            if (*idx == str_in->size)
            { // don't need to worry about recursion level because
              // tick recursively expands 
                fprintf(stderr,"didn't reach end of argument\n");
                exit(-1);
            }
            curr = str_in->data[*idx];
        }
    }  
    *idx = *idx + 1; // moves from '}' to '{'   
    return NAME;
}
// getArg always starts with curr = '{' meaning str_in->data[*idx] = '{'
// breaks when encounters last },, that's where str_in[idx] is pointing to
// the last character will always be }, but after exiting tick function
// the index gets incremented and so it goes to the next char
// unless you call getArg multiple times in a row
string_t* getArg(string_t* str_in, int *idx)
{
    string_t * VALUE = createString(10);

    char curr = str_in->data[*idx];

    // printf("%c\n", curr);

    if (curr != '{') // if it's not starting the value argument, error
    {
        fprintf(stderr, "not an argument\n");
        exit(-1);
    }
    int braces = 1;

    state_arg state = plain_arg; 

    while (braces > 0)
    {
        // in the first instance, this goes from { to first arg char

        *idx = *idx + 1;

        if (*idx == str_in->size)
        { // don't need to worry about recursion level because
            // tick recursively expands 
            fprintf(stderr,"imbalanced braces in argument\n");
            exit(-1);
        }
        curr = str_in->data[*idx];

        switch (state) 
        { // regardless, adds characters, just doesn't treat escaped braces as braces
            case plain_arg:
            if (curr == '\\') state = escape_char;
            
            if (curr == '{')
            {
                braces++;
            }
            else if (curr == '}')
            {
                braces--;
                if (braces == 0) break;
            }
            addChartoString(VALUE, curr);
            
                break;

            case escape_char: // add character regardless, just don't count braces
            addChartoString(VALUE, curr);
            state = plain_arg;
                break;
        }

        
    } 
    // printf("the last character is %c\n", str_in->data[*idx]);
    return VALUE;    
}

typedef struct aug_state_t 
{
    state_t state;
    bool expansion; // whether or not we're expanding (1: need to process #)
                    // or just processing regular input (0)
    string_t *macroNAME; // the name of the macro if we're processing one
    
} aug_state_t;

string_t *output_global; // global string for output

// str_in is the current string we're ticking, c is the char we're at in the SM
// idx is where in str_in char c is, and lvl is the level of recursion we're at
// output is which string we're saving to
void tick(string_t* str_in, char c, int* idx, int lvl, string_t *output)
{
    // static makes the variable retain its value between multiple function calls
    static aug_state_t state = {
        .state=plaintext, 
        .expansion=0, 
        .macroNAME=NULL};
    // static state_t state = plaintext; // will not assign multiple times
    // printf("state = %d\n", state.state);
    // printf("char = %c\n", c);
    switch (state.state)
    {
        case plaintext:
        if (c == '\\')
        {
            state.state = escape;
        }
        addChartoString(output, c);
        
            break;
        case escape:
        if (isalnum(c))
        {
            removeCharfromString(output); // remove the escape
            state.state = macro;
            destroyString(state.macroNAME); // destroys past name
            state.macroNAME = createString(100);
            addChartoString(state.macroNAME, c);
        }
        else if (c == '\\' || c == '#' || c == '%' || c == '{'|| c == '}')
        {
            removeCharfromString(output); // remove the escape
            addChartoString(output, c);
            state.state = plaintext;
        }
        else // non alphanumeric character that is not \, #, %, {, }
        { // treat escapes as normal characters and keep escape in
            addChartoString(output, c);
            state.state = plaintext;
        }
            break;
        case macro:
        if (c == '{')
        {
            if (strcmp(state.macroNAME->data, "def") == 0)
            {
                string_t* NAME = get_alnumArg(str_in, idx);
                string_t* VALUE = getArg(str_in, idx);

                Macro * macroMATCH = findMacro(macros, NAME);
                if (macroMATCH != NULL)
                {
                    fprintf(stderr,"trying to redefine an already defined macro\n");
                    exit(-1);  
                }

                // printf("%s\n", NAME->data);
                // printf("%s\n", VALUE->data);

                Macro *m = createMacro(NAME, VALUE);
                addMacro(macros, m);
            
                state.state = plaintext;
            }
            else if (strcmp(state.macroNAME->data, "undef") == 0)
            {
                string_t * NAME = get_alnumArg(str_in, idx);
                Macro * macroMATCH = findMacro(macros, NAME);
                if (macroMATCH == NULL)
                {
                    fprintf(stderr,"undefining an undefined macro name\n");
                    exit(-1); // undefined macro
                }
                else // else the macro you want to undefine exists
                {
                    findDeleteMacro(macros, NAME); // destroy the macro and free name and value
                    destroyString(NAME); // free NAME, diff ownership from macro's name and value

                    // idx would normally go from } to next { in get_alnumArg
                    // in this case, only one argument, so decrement index
                    // ex: for \undef{MACRO} want to end on '}' in order 
                    // to process everything else in plaintext

                    *idx = *idx - 1;
                    state.state = plaintext;
                }
            }
            else if (strcmp(state.macroNAME->data, "ifdef") == 0)
            {
                string_t * NAME = get_alnumArg(str_in, idx);
                string_t * THEN = getArg(str_in, idx);
                *idx = *idx + 1;
                string_t * ELSE = getArg(str_in, idx);
                // printf("%s\n", COND->data);
                // printf("%s\n", THEN->data);
                // printf("%s\n", ELSE->data);
                state.state = plaintext;

                Macro * macroMATCH = findMacro(macros, NAME);

                if (macroMATCH == NULL)
                {
                    int new_idx = 0;
                    while (new_idx < ELSE->size)
                    {
                        tick(ELSE, ELSE->data[new_idx], &new_idx, lvl+1, output);
                        new_idx++;
                    }
                    // printf("%s\n", ELSE->data);
                }
                else
                {
                    int new_idx = 0;
                    while (new_idx < THEN->size)
                    {
                        tick(THEN, THEN->data[new_idx], &new_idx, lvl+1, output);
                        new_idx++;
                    }
                    // printf("%s\n", THEN->data);
                }
                destroyString(NAME);
                destroyString(THEN);
                destroyString(ELSE);

            }
            else if (strcmp(state.macroNAME->data, "if") == 0)
            {
                string_t * COND = getArg(str_in, idx);
                *idx = *idx + 1;
                string_t * THEN = getArg(str_in, idx);
                *idx = *idx + 1;
                string_t * ELSE = getArg(str_in, idx);
                // printf("%s\n", COND->data);
                // printf("%s\n", THEN->data);
                // printf("%s\n", ELSE->data);
                state.state = plaintext;
                if (COND->size == 0)
                {
                    int new_idx = 0;
                    while (new_idx < ELSE->size)
                    {
                        tick(ELSE, ELSE->data[new_idx], &new_idx, lvl+1, output);
                        new_idx++;
                    }
                    // printf("%s\n", ELSE->data);
                }
                else
                {
                    int new_idx = 0;
                    while (new_idx < THEN->size)
                    {
                        tick(THEN, THEN->data[new_idx], &new_idx, lvl+1, output);
                        new_idx++;
                    }
                    // printf("%s\n", THEN->data);
                }
                destroyString(COND);
                destroyString(THEN);
                destroyString(ELSE);

            }
            else if (strcmp(state.macroNAME->data, "include") == 0)
            {
                string_t* PATH = getArg(str_in, idx);

                FILE *in_file = fopen(PATH->data, "r");

                if (in_file == NULL) 
                {   
                    destroyString(PATH);
                    fprintf(stderr,"Could not open %s\n", PATH->data);
                    exit(-1); // must include stdlib.h 
                } 
                string_t * expandedFILE = createString(10);
                commentRemoval(in_file, expandedFILE);
                fflush(in_file);
                fclose(in_file);
                
                int new_idx = 0;
                while (new_idx < expandedFILE->size)
                {
                    tick(expandedFILE, expandedFILE->data[new_idx], &new_idx, lvl+1, output);
                    new_idx++;
                }

                destroyString(PATH);
                destroyString(expandedFILE);

            
            }   
            else if (strcmp(state.macroNAME->data, "expandafter") == 0)
            {

                /**
                 * \def{B}{buffalo}
                 * \expandafter{\B{}}{\undef{B}\def{B}{bison}}
                 * BEFORE = \B{}
                 * AFTER = \undef{B}\def{B}{bison}
                **/
                string_t* BEFORE = getArg(str_in, idx);
                *idx = *idx + 1;
                string_t* AFTER = getArg(str_in, idx);
                // printf("%s\n", BEFORE->data);
                // printf("%s\n", AFTER->data);
                
                string_t* expandedAFTER = createString(10);
                state.state = plaintext;
                int new_idx = 0;
                while (new_idx < AFTER->size)
                {
                    tick(AFTER, AFTER->data[new_idx], &new_idx, lvl+1, expandedAFTER);
                    new_idx++;
                }
                // printf("%s\n", expandedAFTER->data);
                int after_idx = 0;
                while (after_idx < expandedAFTER->size)
                {
                    addChartoString(BEFORE, expandedAFTER->data[after_idx]);
                    after_idx++;
                }
                // printf("%s\n", BEFORE->data);
                state.state = plaintext;
                int before_idx = 0;
                while (before_idx < BEFORE->size)
                {
                    tick(BEFORE, BEFORE->data[before_idx], &before_idx, lvl+1, output);
                    before_idx++;
                }
                
                destroyString(BEFORE);
                destroyString(AFTER);
                destroyString(expandedAFTER);
            }
            else // found a custom macro case
            {
                Macro * macroMATCH = findMacro(macros, state.macroNAME);

                if (macroMATCH != NULL)
                {
                    string_t * macroVALUE = macroMATCH->value;
                    string_t * customVALUE = getArg(str_in, idx);
                    // printf("%s\n", macroVALUE->data);
                    // printf("%s\n", customVALUE->data);

                    string_t * expandedVALUE = createString(10);
                    

                    state_arg stateA = plain_arg;

                    for (int i = 0; i < macroVALUE->size; i++)
                    {
                        // printf("state = %d\n", stateA);
                        // printf("char = %c\n", macroVALUE->data[i]);
                        switch (stateA)
                        {
                            case plain_arg:
                            if (macroVALUE->data[i] == '\\')
                            {
                                stateA = escape_char;
                            }
                            // replace hash within macroVALUE
                            if (macroVALUE->data[i] == '#')
                            {
                                for (int j = 0; j < customVALUE->size; j++)
                                {
                                    addChartoString(expandedVALUE, customVALUE->data[j]);
                                }
                            }
                            else addChartoString(expandedVALUE, macroVALUE->data[i]);
                                break;
                            case escape_char:
                            // don't need to do this processing: it will be done it tick
                            // keep the escapes and special values in: all you need
                            // to worry about is the \#

                            // if (macroVALUE->data[i] == '\\' || macroVALUE->data[i] == '#' ||  
                            // macroVALUE->data[i] == '%' || macroVALUE->data[i] == '{'|| macroVALUE->data[i] == '}')
                            // {   // remove the previous escape
                            //     // removeCharfromString(expandedVALUE);            
                            // } // then add the character: if it wasn't one of the special
                            //   // keep the escape with the input
                            addChartoString(expandedVALUE, macroVALUE->data[i]);
                            stateA = plain_arg;
                                break;   
                        }
                           
                        
                    }
                    // printf("%s\n", expandedVALUE->data);

                    // the macro has been expanded, go back to plaintext
                    state.state = plaintext; 

                    int new_idx = 0;
                    while (new_idx < expandedVALUE->size)
                    {
                        tick(expandedVALUE, expandedVALUE->data[new_idx], &new_idx, lvl+1, output);
                        new_idx++;
                    }

                    destroyString(customVALUE);
                    destroyString(expandedVALUE);

                    // printf("Found %s\n", state.macroNAME->data);
                }
                else
                {
                    fprintf(stderr,"undefined macro name\n");
                    exit(-1); // undefined macro
                }
            }         
        }
        else if(isalnum(c))
        {
            addChartoString(state.macroNAME, c);
            // for cases where a macro is unfinished at the EOF
            if (*idx == str_in->size - 1 && lvl == 1)
            {
                fprintf(stderr,"no argument found at EOF\n");
                exit(-1);
            }
        }
        else
        {
            fprintf(stderr,"non alphanumeric char found in macro name\n");
            exit(-1); // non alphanumeric char in macro name
        }
    }      
            
}

int main(int argc, char*argv[])
{ 

    input_global = createString(100);
    output_global = createString(100);

    if (argc >= 2)
    {
        for (int i = 1; i < argc; i++)
        {
            FILE *in_file = fopen(argv[i], "r");
            if (in_file == NULL) 
            {   
                fprintf(stderr,"Could not open %s\n", argv[i]);
                exit(-1); // must include stdlib.h 
            } 
            commentRemoval(in_file, input_global);
            fflush(in_file);
            fclose(in_file);

        }
    }
    else if (argc < 2)
    {
        // no files given, stdin
        FILE *in_file = stdin;
        if (in_file == NULL)
        {
            fprintf(stderr,"Could not open stdin\n");
            exit(-1); // must include stdlib.h 
        }
        commentRemoval(in_file, input_global);
    }

    // printf("%s", input->data);

    macros = createMacroList();

    int idx = 0;
    int recursion_lvl = 1;

    while (idx < input_global->size)
    {  
        tick(input_global, input_global->data[idx], &idx, recursion_lvl, output_global);
        idx++;
    }
    for (int i = 0; i < output_global->size; i++)
    {
        printf("%c", output_global->data[i]);
    }
    /** 

    If there's an expansion 
    Tick from the start of that expansion 

    Have to detect: okay, have an expansion now, tick on that
    before we go back to the beginning of the loop

    **/
    
}