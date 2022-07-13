#include <process.h>

int uprocess(const CMD *cmdList, bool bg);

typedef struct stack_t
{
    char **data;
    size_t cap;
} Stack;

Stack* stack = NULL;
int top = 0;

void initStack()
{
    stack = malloc(sizeof(Stack));
    stack->data = malloc(sizeof(char *) * 1000);
    stack->cap = 1000;
}

void addStack(char * dir)
{
    stack->data[top] = dir;
    top++;
    if (top == stack->cap)
    {
        stack->cap *= 2;
        stack->data = (char **) realloc(stack->data, sizeof(char *) * stack->cap);
    }
}

int setStatus(int status)
{
    char str[10];
    sprintf(str, "%d", status);
    setenv("?", str, 1); // setting status of ? before exiting
    return status; // return the status as an int
}

void reap(const CMD *cmdList)
{
    int status;
    pid_t pid;
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0)
    {
        fprintf(stderr, "Completed: %d (%d)\n", pid, setStatus(STATUS(status)));
    }
}

void openCheck(int open_ret) // error check for open() function
{   
    if (open_ret < 0)
    {
        perror("Bad Open");
        exit(setStatus(errno));
    }
}
void mkstempCheck(int fd)
{
    if (fd == -1) 
    {
        perror("Bad mkstemp");
        exit(setStatus(errno));
    }
}

void redirect(const CMD *cmdList)
{
    int in, out;
    if (cmdList->fromType == RED_IN)
    {  
        in = open(cmdList->fromFile, O_RDONLY); 
        openCheck(in);
        dup2(in, STDIN_FILENO);
        close(in);
    }
    else if (cmdList->fromType == RED_IN_HERE)
    {
        char temp_file[] = "temp_XXXXXX";
        int fd1 = mkstemp(temp_file);
        mkstempCheck(fd1);
        write(fd1, cmdList->fromFile, strlen(cmdList->fromFile));
        close(fd1);

        int fd2 = open(temp_file, O_RDONLY);
        openCheck(fd2);
        dup2(fd2, STDIN_FILENO);
        close(fd2);

        unlink(temp_file);

        // lseek(fd, 0, SEEK_SET);
    }
    if (cmdList->toType == RED_OUT)
    {
        out = open(cmdList->toFile, O_WRONLY | O_TRUNC | O_CREAT, S_IRUSR | S_IRGRP | S_IWGRP | S_IWUSR);
        openCheck(out);
        dup2(out, STDOUT_FILENO);
        close(out);
    }
    else if (cmdList->toType == RED_OUT_APP)
    {
        out = open(cmdList->toFile, O_WRONLY | O_APPEND | O_CREAT, S_IRUSR | S_IRGRP | S_IWGRP | S_IWUSR);
        openCheck(out);
        dup2(out, STDOUT_FILENO);
        close(out);
    }
}

pid_t callFork()
{
    pid_t ret = fork();
    if (ret < 0)
    {
        perror("Bad fork");
        exit(setStatus(errno));
    }
    return ret;
}
void getLocal(const CMD *cmdList)
{
    for (int i = 0; i < cmdList->nLocal; i++)
    {
        setenv(cmdList->locVar[i], cmdList->locVal[i], 1);
    }
}

int chdir_check(char * arg)
{
    int res = chdir(arg);
    if (res < 0)
    {
        perror("Bad chdir");
        exit(setStatus(errno));
    }
    return res;
}

void handle_cd(int argc, char **argv)
{
    if (argc > 0)
    {
        if (strcmp(argv[0], "cd") == 0)
        {
            if (argc == 1)
            {
                chdir(getenv("HOME"));
            }
            else if (argc == 2)
            {
                chdir(argv[1]);
            }
        }
    }
}

char * getcwd_check()
{
    char * res = getcwd(NULL, 0);
    if (res == NULL)
    {
        perror("Bad getcwd");
        exit(setStatus(errno));
    }
    return res;
}

int handle_push_pop(int argc, char **argv)
{
    if (strcmp(argv[0], "pushd") == 0)
    {
        if (argc == 2)
        {
            char * dir = getcwd_check();
            chdir_check(argv[1]);
            addStack(dir);
            // get new current wd
            char * curr = getcwd_check();
            printf("%s", curr);
            free(curr);

            for (int i = top-1; i >= 0; i--) printf(" %s", stack->data[i]);
            printf("\n");
            return 0;
        }
        else
        {
            perror("Bad pushd");
            return 1;
        }
    }
    else if (strcmp(argv[0], "popd") == 0)
    {
        if (argc == 1)
        {
            if (top == 0)
            {
                perror("stack directory is empty");
                return EXIT_FAILURE;
            }
            chdir_check(stack->data[--top]);
            free(stack->data[top]);

            char * curr = getcwd_check();
            printf("%s", curr);
            free(curr);

            for (int i = top-1; i >= 0; i--) printf(" %s", stack->data[i]);
            printf("\n");

            return 0;
        }
        else
        {
            perror("Bad popd");
            return EXIT_FAILURE;
        }
    }
    else
    {
        perror("Not real built-in");
        return 0;
    }
}

bool is_built_in(char * cmd)
{
    if (strcmp(cmd, "pushd") == 0) return true;
    if (strcmp(cmd, "popd") == 0) return true;
    return false;
}

int handle_simple(const CMD *cmdList, bool bg, bool subcmd)
{
    // printf("command %s has bg: %d\n", cmdList->argv[0], bg);
    int status;

    if (cmdList->argc > 0 && is_built_in(cmdList->argv[0]))
    {
        return handle_push_pop(cmdList->argc, cmdList->argv);
    }

    pid_t pid = callFork();

    if (pid == 0)
    {
        redirect(cmdList);
        getLocal(cmdList);
        if (subcmd == 0)
        {
            signal(SIGINT, SIG_DFL);
            int ret = execvp(cmdList->argv[0], cmdList->argv);

            // if execvp succeeds, it will remove the child process entirely
            // so if execvp fails, it will continue after, so do error handling here
            if (ret < 0)
            {
                perror("Bad simple command");
                exit(setStatus(errno));
            }
        }
        else // is a subcmd
        {
            status = uprocess(cmdList->left, bg);
            exit(setStatus(status));
        }
    }
    else // parent process  
    {
        if (bg == 1)
        {
            waitpid(pid, &status, WNOHANG);
            fprintf(stderr, "Backgrounded: %d\n", pid);
            return setStatus(0);
        }
        else
        {   // first argument is pid of the child, 
            // pointer to an int of the exit status of the child
            // third is zero
            // https://man7.org/linux/man-pages/man3/wait.3p.html
            waitpid(pid, &status, 0);
        }
        // if and only if the child succeeded, then do the built_in
        // here's why: cd would have gotten called by execvp
        // therefore, it would have reported the error for you
        // because the child changing the directories does not change
        // the parent directories, you now need to change dir of the par
        // the child will tell us if any of the errors happen

        // DO NOT HAVE TO DO ANY ERROR CHECKING HERE (pretty sure - aidan)
        // this is what the staff solution does
        handle_cd(cmdList->argc, cmdList->argv);
    }
    return setStatus(STATUS(status));
}

void callPipe(int * pipe_fd)
{
    int err = pipe(pipe_fd);
    if (err < 0)
    {
        perror("Bad pipe");
        exit(setStatus(errno));
    }
}

int handle_pipeline(const CMD *cmdList, bool bg)
{
    /**
     * err =  pipe(pipe_fd_pair)  //to get the input and output file descriptors
     //PROCESS THE LEFT NODE:
     fork //for echo dog
     //FORKED CHILD PROCESS DOES THE FOLLOWING:
     dup2 to overwrite stdout
     close old pipe fds
     execvp
     // PROCESS THE RIGHT NODE
     fork //for cat -n
     //FORKED CHILD PROCESS DOES THE FOLLOWING:
     dup2 to overwrite stdin.
     close old pipe fds
     Execvp
     close pipe fds (DO THIS BEFORE WAITING)
     Wait for both echo and cat to finish
    **/

    int status1;
    int status2;

    int pipe_fd[2];

    callPipe(pipe_fd);

    pid_t child_pid = callFork();

    if (child_pid == 0)
    { // since we copy pipe_fd[1] into our standard out
      // we can now close the descriptor
        dup2(pipe_fd[1], STDOUT_FILENO);
        close(pipe_fd[0]);
        close(pipe_fd[1]);
        exit(uprocess(cmdList->left, bg));
    }
    else
    {
        pid_t next_pid = callFork();
        if (next_pid == 0)
        {
            dup2(pipe_fd[0], STDIN_FILENO);
            close(pipe_fd[0]);
            close(pipe_fd[1]); 
            exit(uprocess(cmdList->right, bg));
        }
        else
        {  // close and waitpid
            close(pipe_fd[0]);
            close(pipe_fd[1]);

            // the status of the left child is going to status 1
            // the status of status1 is the status that child_pid exited with
            waitpid(child_pid, &status1, 0);
            // the status of the right child
            waitpid(next_pid, &status2, 0);   
        }
        // for the parent you also have to close the parent's fds
        
    }
    // printf("status1: %d status2: %d\n", status1, status2);
    if (status2 > 0) // if the status of the rightmost stage fails
    {
        return setStatus(STATUS(status2)); // return the latest stage to fail
    }
    else // return 0, or status1
    { 
        return setStatus(STATUS(status1));
    }
}
int handle_and(const CMD *cmdList, bool bg)
{
    int status1 = uprocess(cmdList->left, bg);
    int status2; 

    if (status1 != 0)
    {
        return setStatus(STATUS(status1));
    }
    else // don't skip the right command is the first is non-zero
    {
        status2 = uprocess(cmdList->right, bg);
        return setStatus(STATUS(status2));
    }
}
int handle_or(const CMD *cmdList, bool bg)
{
    int status1 = uprocess(cmdList->left, bg);
    int status2; 

    if (status1 == 0)
    {
        return setStatus(STATUS(status1));
    }
    else // don't skip the right command is the first is non-zero
    {
        status2 = uprocess(cmdList->right, bg);
        return setStatus(STATUS(status2));
    }
}

int handle_end(const CMD *cmdList, bool bg, bool direct)
{
    // printf("bool bg: %d, bool dir: %d\n", bg, bg);
    int status;
    if (direct)
    { // if & is your direct parent, don't background left child
        reap(cmdList);
        status = uprocess(cmdList->left, 0);
    }
    else
    { // if & is your parent further  up, may have to background the left ;
        status = uprocess(cmdList->left, 1);
    }
    if (cmdList->right != NULL)
    {
        status = uprocess(cmdList->right, bg);
    }

    return setStatus(STATUS(status));
}
int handle_bg(const CMD *cmdList, bool bg)
{       
    // every time you do bg, pass true to the left child
    // pass the bg flag to the right child

    // if the bg flag is true that means there's a bg that
    // happened before, so you need to bg two things, left and right subtree
    int status;
    if (cmdList->left->type == SEP_END)
    {
        status = handle_end(cmdList->left, 1, 1);
    }
    else
    {
        status = uprocess(cmdList->left, 1);
    }
    if (cmdList->right != NULL)
    {
        status = uprocess(cmdList->right, bg);
    }
    return setStatus(STATUS(status));

}
int uprocess(const CMD *cmdList, bool bg)
{
    reap(cmdList);
    switch (cmdList->type) {
        case SIMPLE:
            return handle_simple(cmdList, bg, 0);
            break;
        case PIPE:
            return handle_pipeline(cmdList, bg);
            break;
        case SEP_AND:
            return handle_and(cmdList, bg);
            break;
        case SEP_OR:
            return handle_or(cmdList, bg);
            break;
        case SUBCMD:
            return handle_simple(cmdList, bg, 1);
            break;
        case SEP_END:
            return handle_end(cmdList, bg, 1);
            break;
        case SEP_BG:
            return handle_bg(cmdList, bg);
            break;
        default:
            break;
    }
    return 0;
}

// going to place SIGIGN at a carefully located place in the code
// SIGDFL for another carefully located place.
// don't just put them before and after waitpid
// where you want to put it is two spots in the entire code
// place SIGIGN in the one spot
// sigign is telling it to ignore the interrupt
// could be two spots for SIGDFL

int process(const CMD *cmdList)
{
   if (stack == NULL) initStack(); 
   signal(SIGINT, SIG_IGN);
   int res = uprocess(cmdList, false);
   signal(SIGINT, SIG_DFL); // one more spot for DFL
   return res;
}