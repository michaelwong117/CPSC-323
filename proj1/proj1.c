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
    argument,

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
    if (m == NULL) return;
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

typedef struct aug_state_t 
{
    state_t state;
    string_t *macroNAME; // the name of the macro if we're processing one
    int arg_num; // number of arguments
    int arg_count;
    int braces;
    state_arg stateArg;
    string_t *arg1;
    string_t *arg2;
    string_t *arg3;

    // if you see an opening and a closing brace: braces are balanced
    // that's one argument
    // you also want to check if your arg counter is equal to the target # of arguments
    // once you got enough arguments, that's when you want to process, recursion everything

    // every time you get one argument, store it inside of a string (don't expand it yet)
    // when you're doing processing, at the very end, now you have strings of arguments
    // now you can expand

    // for those edge cases, the idea is you want to make sure your state stays consistent
    // if you go up one level of recursion, and you go into state argument, you have to make
    // sure you stay in state argument

    // have to stay in state argument as you fall back in level of recursion

    // during the processing then you can check for errors

    // you want to keep the state between recursive levels

    // when you go up and down levels of recursion,
    // when you go up a level, set it to plaintext, when you come down, make
    // sure you preserve state


    
} aug_state_t;

string_t *output_global; // global string for output

void expand(aug_state_t * state, string_t *output, int lvl);


// str_in is the current string we're ticking, c is the char we're at in the SM
// idx is where in str_in char c is, and lvl is the level of recursion we're at
// output is which string we're saving to
void tick(string_t* str_in, char c, int* idx, int lvl, string_t *output)
{
    // static makes the variable retain its value between multiple function calls
    static aug_state_t state = {
        .state=plaintext, 
        .macroNAME=NULL,
        .braces=0,
        .arg1=NULL,
        .arg2=NULL,
        .arg3=NULL};
    // printf("state = %d\n", state.state);
    // printf("%s\n", str_in->data);
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
            // printf("starting macro name %s\n", state.macroNAME->data);
            state.state = argument;
            state.braces = 1; //1 bc first brace not counted in the arg state
            state.stateArg = plain_arg;
            state.arg_count = 0;
            
            if (strcmp(state.macroNAME->data, "def") == 0)
            {
                state.arg_num = 2;
            }
            
            else if (strcmp(state.macroNAME->data, "undef") == 0)
            {
                state.arg_num = 1;
                    
            }
            else if (strcmp(state.macroNAME->data, "ifdef") == 0)
            {
                state.arg_num = 3;
            }
            else if (strcmp(state.macroNAME->data, "if") == 0)
            {
                state.arg_num = 3;
      
            }
            else if (strcmp(state.macroNAME->data, "include") == 0)
            {
                state.arg_num = 1;    
            }   
            else if (strcmp(state.macroNAME->data, "expandafter") == 0)
            {
                state.arg_num = 2;
            }
            else // found a custom macro case
            {
                Macro * macroMATCH = findMacro(macros, state.macroNAME);

                if (macroMATCH != NULL)
                {
                    state.arg_num = 1;
                }
                else
                {
                    fprintf(stderr,"undefined macro name\n");
                    exit(-1); // undefined macro
                }
                
            } 
            if (state.arg_num >= 1)
            {
                state.arg1 = createString(10);
            }
            if (state.arg_num >= 2)
            {
                state.arg2 = createString(10);
            }
            if (state.arg_num == 3)
            {
                state.arg3 = createString(10);
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
            break;
        case argument:
        switch (state.stateArg)
        { // process all the arguments with brace in and no regards to alnum
          // finetune later
            case plain_arg:
            if (state.braces == 0 && c != '{')
            {
                fprintf(stderr,"looking for { in next argument\n");
                exit(-1);
            }
            if (c == '\\') state.stateArg = escape_char;
            else if (c == '}')
            {
                state.braces--;
                if (state.braces == 0)
                {
                    state.arg_count++;
                    if (state.arg_count == state.arg_num)
                    {
                        expand(&state, output, lvl);
                    }
                    break; // break so we don't add the ending brace
                }
            }
            if (c == '{') 
            {
                if (state.braces == 0) // we're beginning the second or third arg
                { 
                    // don't add beginning braces  
                } 
                else // add braces into the string
                {
                    if (state.arg_count == 0)
                    {
                        addChartoString(state.arg1, c);
                    }
                    else if (state.arg_count == 1) addChartoString(state.arg2, c);
                    else if (state.arg_count == 2) addChartoString(state.arg3, c);
                }
                state.braces++;  
            }
            else // not beginning or ending braces, just add the character
            {
                if (state.arg_count == 0)
                {
                    addChartoString(state.arg1, c);
                }
                else if (state.arg_count == 1) addChartoString(state.arg2, c);
                else if (state.arg_count == 2) addChartoString(state.arg3, c);
                if (*idx == str_in->size - 1 && lvl == 1)
                {
                    fprintf(stderr,"couldn't find end of argument\n");
                    exit(-1);
                }
            }
            
                break;
        case escape_char:
        if (state.arg_count == 0) addChartoString(state.arg1, c);
        else if (state.arg_count == 1) addChartoString(state.arg2, c);
        else if (state.arg_count == 2) addChartoString(state.arg3, c);
        state.stateArg = plain_arg;
            break;
        }
        
    }      
            
}

void expand(aug_state_t * state, string_t *output, int lvl)
{
    if (strcmp(state->macroNAME->data, "def") == 0)
    {
        string_t* NAME = state->arg1;
        for (int i = 0; i < NAME->size; i++)
        {
            if(!isalnum(NAME->data[i]))
            {
                fprintf(stderr,"non alphanumeric char in macro name\n");
                exit(-1);
            } 
        }
        if (NAME->size == 0)
        {
            fprintf(stderr,"non alphanumeric char (empty!) in macro name\n");
            exit(-1);
        }
        string_t* VALUE = state->arg2;

        // printf("%s\n", NAME->data);
        // printf("%s\n", VALUE->data);

        Macro * macroMATCH = findMacro(macros, NAME);
        if (macroMATCH != NULL)
        {
            fprintf(stderr,"trying to redefine an already defined macro\n");
            exit(-1);  
        }

        Macro *m = createMacro(NAME, VALUE);
        addMacro(macros, m);

        state->state = plaintext;
    }
    else if (strcmp(state->macroNAME->data, "undef") == 0)
    {
        string_t * NAME = state->arg1;
        for (int i = 0; i < NAME->size; i++)
        {
            if(!isalnum(NAME->data[i]))
            {
                destroyString(NAME);
                fprintf(stderr,"non alphanumeric char in macro name\n");
                exit(-1);
            } 
        }
        if (NAME->size == 0)
        {
            destroyString(NAME);
            fprintf(stderr,"non alphanumeric char (empty!) in macro name\n");
            exit(-1);
        }
        
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
            state->state = plaintext;
        }
    }
    else if (strcmp(state->macroNAME->data, "ifdef") == 0)
    {
        string_t * NAME = state->arg1;
        string_t * THEN = state->arg2;
        string_t * ELSE = state->arg3;
        // printf("%s\n", COND->data);
        // printf("%s\n", THEN->data);
        // printf("%s\n", ELSE->data);

        for (int i = 0; i < NAME->size; i++)
        {
            if(!isalnum(NAME->data[i]))
            {
                destroyString(NAME);
                destroyString(THEN);
                destroyString(ELSE);
                fprintf(stderr,"non alphanumeric char in macro name\n");
                exit(-1);
            } 
        }
        if (NAME->size == 0)
        {
            destroyString(NAME);
            destroyString(THEN);
            destroyString(ELSE);
            fprintf(stderr,"non alphanumeric char (empty!) in macro name\n");
            exit(-1);
        }

        state->state = plaintext;

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
    else if (strcmp(state->macroNAME->data, "if") == 0)
    {
        string_t * COND = state->arg1;
        string_t * THEN = state->arg2;
        string_t * ELSE = state->arg3;
        // printf("%s\n", COND->data);
        // printf("%s\n", THEN->data);
        // printf("%s\n", ELSE->data);
        state->state = plaintext;
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
    else if (strcmp(state->macroNAME->data, "include") == 0)
    {
        string_t* PATH = state->arg1;

        FILE *in_file = fopen(PATH->data, "r");
        
        if (in_file == NULL) 
        {   
            destroyString(PATH);
            fprintf(stderr,"Could not open file\n");
            exit(-1); // must include stdlib.h 
        } 
        string_t * expandedFILE = createString(10);
        commentRemoval(in_file, expandedFILE);
        fflush(in_file);
        fclose(in_file);

        state->state = plaintext;
        
        int new_idx = 0;
        while (new_idx < expandedFILE->size)
        {
            tick(expandedFILE, expandedFILE->data[new_idx], &new_idx, lvl+1, output);
            new_idx++;
        }

        destroyString(PATH);
        destroyString(expandedFILE);    
    }   
    else if (strcmp(state->macroNAME->data, "expandafter") == 0)
    {

        string_t* BEFORE = state->arg1; 
        string_t* AFTER = state->arg2;
        // printf("%s\n", BEFORE->data);
        // printf("%s\n", AFTER->data);
        
        string_t* expandedAFTER = createString(10);
        state->state = plaintext;
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
        state->state = plaintext;
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
    else
    {
        Macro * macroMATCH = findMacro(macros, state->macroNAME);
        if (macroMATCH != NULL)
        {
            string_t * macroVALUE = macroMATCH->value;
            string_t * customVALUE = state->arg1;
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
                    addChartoString(expandedVALUE, macroVALUE->data[i]);
                    stateA = plain_arg;
                        break;   
                }  
                
            }
            // printf("%s\n", expandedVALUE->data);
            state->state = plaintext; 
            int new_idx = 0;
            while (new_idx < expandedVALUE->size)
            {
                tick(expandedVALUE, expandedVALUE->data[new_idx], &new_idx, lvl+1, output);
                new_idx++;
            }
            destroyString(customVALUE);
            destroyString(expandedVALUE);

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