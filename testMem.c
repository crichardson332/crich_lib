/******************************************
* File Name: testMem.c
* Purpose:
* Creation Date: 19-06-2015
* Last Modified: Sat Jun 20 00:35:03 2015
* Created By: Chris Richardson
*******************************************/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    int len = atoi(argv[1]);
    char *str = malloc(sizeof(char) * len);
    for (int i = 0; i < len; i++) {
        str[i] = '$' + i;
        printf("Char is: %c\n", str[i]);
    }

    free(str);
    return 0;
}
