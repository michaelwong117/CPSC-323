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

string_t *input;

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
    macros->capacity = 10;
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

void destroyMacro(Macro * m)
{
    destroyString(m->name);
    destroyString(m->value);
    free(m);
    m = NULL;
}

// returns a pointer to the macro with a matching name
Macro* findMacro(MacroList *macros, string_t * name)
{
    for (int i = 0; i < macros->size; i++)
    {
        // if (macros->data[i]->name->data != NULL)
        if (macros->data[i] != NULL)
        {
            if (stringCompare(name, macros->data[i]->name) == 0)
            {
                return macros->data[i];
            }
        }
        
    }
    return NULL;
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
        addChartoString(NAME, curr);

        if (*idx == str_in->size) exit(-1);
        else
        {
            *idx = *idx + 1;
            curr = str_in->data[*idx];
        }

    }  
    *idx = *idx + 1; // moves from '}' to '{'   
    return NAME;
}
// getArg always starts with curr = '{' meaning str_in->data[*idx] = '{'
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

    while (braces > 0)
    {
        // in the first instance, this goes from { to first arg char

        *idx = *idx + 1;
        curr = str_in->data[*idx];

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
    } 
    return VALUE;    
}

typedef struct aug_state_t 
{
    state_t state;
    bool expansion; // whether or not we're expanding (1: need to process #)
                    // or just processing regular input (0)
    string_t *macroNAME; // the name of the macro if we're processing one
    
} aug_state_t;
// str_in is the current string we're ticking, c is the char we're at in the SM
// idx is where in str_in char c is, and lvl is the level of recursion we're at
void tick(string_t* str_in, char c, int* idx, int lvl)
{
    // static makes the variable retain its value between multiple function calls
    static aug_state_t state = {
        .state=plaintext, 
        .expansion=0, 
        .macroNAME=NULL};
    // static state_t state = plaintext; // will not assign multiple times
    switch (state.state)
    {
        case plaintext:
        if (c == '\\')
        {
            state.state = escape;
            // for cases where an escape character ends the FILE
            // can't end for higher cases of recursion because 
            // you don't know the next char when you go back: 
            // if you're at base level of recursion and encounter,
            // print the escape character
            if (*idx == str_in->size - 1 && lvl == 1)
            {
                printf("%c", c);
            }
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
            destroyString(state.macroNAME); // destroys past name
            state.macroNAME = createString(100);
            addChartoString(state.macroNAME, c);
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
            if (strcmp(state.macroNAME->data, "def") == 0)
            {
                string_t* NAME = get_alnumArg(str_in, idx);
                string_t* VALUE = getArg(str_in, idx);

                Macro *m = createMacro(NAME, VALUE);
                addMacro(macros, m);
            
                // printf("%s\n", NAME->data);
                // printf("%s\n", VALUE->data);

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
                    destroyMacro(macroMATCH); // destroy the macro and free name and value
                    destroyString(NAME); // free NAME, diff ownership from macro's name and value

                    // idx would normally go from } to next {
                    // in this case, only one argument, so decrement index
                    // ex: for \undef{MACRO} want to end on '}' in order to 
                    // process everything else in plaintext
                    *idx = *idx - 1;
                    state.state = plaintext;
                }

                
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

                // macroNAME is testMacro
                // macroVALUE is some text #
                // customVALUE is \macroFragment

                Macro * macroMATCH = findMacro(macros, state.macroNAME);

                if (macroMATCH != NULL)
                {
                    string_t * macroVALUE = macroMATCH->value;
                    string_t * customVALUE = getArg(str_in, idx);
                    // printf("%s\n", macroVALUE->data);
                    // printf("%s\n", customVALUE->data);

                    string_t * expandedVALUE = createString(10);

                    for (int i = 0; i < macroVALUE->size; i++)
                    {
                        // replace hash within macroVALUE
                        if (macroVALUE->data[i] == '#')
                        {
                            for (int j = 0; j < customVALUE->size; j++)
                            {
                                addChartoString(expandedVALUE, customVALUE->data[j]);
                            }
                        }
                        else addChartoString(expandedVALUE, macroVALUE->data[i]);
                    }
                    // printf("%s\n", expandedVALUE->data);

                    // the macro has been expanded, go back to plaintext
                    state.state = plaintext; 

                    int new_idx = 0;
                    while (new_idx < expandedVALUE->size)
                    {
                        tick(expandedVALUE, expandedVALUE->data[new_idx], &new_idx, lvl+1);
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

    input = createString(100);

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
            commentRemoval(in_file);
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
        commentRemoval(in_file);
    }

    // printf("%s", input->data);

    macros = createMacroList();

    int idx = 0;
    int recursion_lvl = 1;

    while (idx < input->size)
    {  
        tick(input, input->data[idx], &idx, recursion_lvl);
        idx++;
    }
    /** 

    If there's an expansion 
    Tick from the start of that expansion 

    Have to detect: okay, have an expansion now, tick on that
    before we go back to the beginning of the loop

    **/
    
}