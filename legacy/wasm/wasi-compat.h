/* What the old programs expect of a POSIX system that WASI does not have:
 * processes and pipes. Each is declared here, with no system header, so
 * that a configure test's own declaration of a function WASI does have is
 * not contradicted, and fails in wasi-compat.c as a system without it
 * would, with ENOSYS. */
#ifndef WASI_COMPAT_H
#define WASI_COMPAT_H
int fork(void);
int vfork(void);
int execv(const char *, char *const[]);
int execvp(const char *, char *const[]);
int wait(int *);
int waitpid(int, int *, int);
int pipe(int[2]);
int dup2(int, int);
int kill(int, int);
char *mktemp(char *);
unsigned int umask(unsigned int);
int chown(const char *, unsigned int, unsigned int);
#ifndef WNOHANG
#define WNOHANG 1
#define WIFEXITED(s) (((s) & 0x7f) == 0)
#define WEXITSTATUS(s) (((s) >> 8) & 0xff)
#define WIFSIGNALED(s) (((s) & 0x7f) != 0 && ((s) & 0x7f) != 0x7f)
#define WTERMSIG(s) ((s) & 0x7f)
#define WIFSTOPPED(s) (((s) & 0xff) == 0x7f)
#define WSTOPSIG(s) WEXITSTATUS(s)
#endif
#endif
