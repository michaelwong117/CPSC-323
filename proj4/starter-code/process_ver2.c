#include <process.h>


int setStatus(int status)
{
    char str[10];
    sprintf(str, "%d", status);
    setenv("?", str, 1); // setting status of ? before exiting
    return status; // return the status as an int
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

int handle_simple(const CMD *cmdList, bool bg)
{
    // ls -la
    int status;

    pid_t child_pid = callFork();

    if (child_pid == 0)
    {

        redirect(cmdList);
        getLocal(cmdList);
        
        int ret = execvp(cmdList->argv[0], cmdList->argv);

        // if execvp succeeds, it will remove the child process entirely
        // so if execvp fails, it will continue after, so do error handling here
        if (ret < 0)
        {
            perror("Bad simple command");
            exit(setStatus(errno));
        }
    }
    else // parent process  
    {
        if (bg == true)
        {
            witpid(child_pid, &status, WNOHANG);
            printf("backgrounded: %d\n", child_pid);
            return 0;
        }
        else
        {
            waitpid(child_pid, &status, 0);
        }
        // first argument is pid of the child, 
        // pointer to an int of the exit status of the child
        // third is zero
        // https://man7.org/linux/man-pages/man3/wait.3p.html
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

int handle_pipeline(const CMD *cmdList)
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
        exit(user_process(cmdList->left));
    }
    else
    {
        pid_t next_pid = callFork();
        if (next_pid == 0)
        {
            dup2(pipe_fd[0], STDIN_FILENO);
            close(pipe_fd[0]);
            close(pipe_fd[1]); 
            exit(user_process(cmdList->right));
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
int handle_and(const CMD *cmdList)
{
    int status1 = user_process(cmdList->left);
    int status2; 

    if (status1 != 0)
    {
        return setStatus(STATUS(status1));
    }
    else // don't skip the right command is the first is non-zero
    {
        status2 = user_process(cmdList->right);
        return setStatus(STATUS(status2));
    }
}
int handle_or(const CMD *cmdList)
{
    int status1 = user_process(cmdList->left);
    int status2; 

    if (status1 == 0)
    {
        return setStatus(STATUS(status1));
    }
    else // don't skip the right command is the first is non-zero
    {
        status2 = process(cmdList->right);
        return setStatus(STATUS(status2));
    }
}

int handle_subcmd(const CMD *cmdList)
{
    /**
     * The tree for a [stage] is either the tree for a [simple] or a 
     * CMD struct of type SUBCMD (which may have local variables and redirection)
     *  whose left child is the tree representing a [command] and whose right child 
     * is NULL.
     **/
    int status;
    pid_t pid = callFork();

    if (pid == 0)
    { // you have to redirect and get local variables for the whole subcmd,
      // var=1 (echo hi) 
        redirect(cmdList);
        getLocal(cmdList);
        status = process(cmdList->left);
    }
    else // parent process  
    {
        waitpid(pid, &status, 0);
        // https://man7.org/linux/man-pages/man3/wait.3p.html
    }
    return setStatus(STATUS(status));
}
int handle_end(const CMD *cmdList)
{
    int status = process(cmdList->left);
    status = process(cmdList->right);

    return setStatus(STATUS(status));
}
int handle_bg(const CMD *cmdList, bool bg)
{
    int status1 = user_process(cmdList->left, 1);
    int status2 = user_process(cmdList->right, 0);

    // every time you do bg, pass true to the left child
    // pass the bg flag to the right child

    // if the bg flag is true that means there's a bg that
    // happened before, so you need to bg two things, left and right subtree

    waitpid(pid, &status, WNOHANG);

}

int user_process(const CMD *cmdList, bool bg)
{
    switch (cmdList->type) {
        case SIMPLE:
            return handle_simple(cmdList);
            break;
        case PIPE:
            return handle_pipeline(cmdList);
            break;
        case SEP_AND:
            return handle_and(cmdList);
            break;
        case SEP_OR:
            return handle_or(cmdList);
            break;
        case SUBCMD:
            return handle_subcmd(cmdList);
            break;
        case SEP_END:
            return handle_end(cmdList);
            break;
        case SEP_BG:
            return handle_bg(cmdList);
            break;
        default:
            break;
    }
    return 0;
}

int process(const CMD *cmdList)
{
   return user_process(cmdList, 0);
}