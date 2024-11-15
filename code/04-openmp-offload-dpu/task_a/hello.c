#include <omp.h>
#include <stdio.h>
#include <unistd.h>

int main()
{

        char host[30];
        gethostname(host, 30);
        printf("Hi folks from %s!\n", host);

#pragma omp target
        {
                char bf3[30];
                gethostname(bf3, 30);
                printf("Hi folks from %s!\n", bf3);
        }
        return EXIT_SUCCESS;
}
