  GNU nano 6.2                                    hello.c *
#include <omp.h>
#include <stdio.h>
#include <unistd.h>

int main()
{

        char host[30];
        gethostname(host, 30);
        printf("Hi Folks! from %s\n", host);

#pragma omp target
{
        char bf3[30];
        gethostname(bf3, 30);
        printf("Hi Folks! from %s\n", bf3);
}
        return EXIT_SUCCESS;
}
