
// Include files
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i;
    i = 0x12345678;
    int *p = &i;
    *p = 0x11223344;
    printf("0x%x 0x%x\n", i, *p);
}
