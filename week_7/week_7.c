// gcc -o week_7 week_7.c && ./week_7
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

int encode(char *restrict source, int s_len, char **restrict dest, int d_len) {
    int ret = 0; // how large is the returning buffer

    int l = 0; // char count
    char c = (char)0; // current char being counted

    for (int i = 0; i < s_len; i ++) {
        if (c == source[i]) {
            if (l == 9) {
                goto PRINT_STATE;
            }
            l ++;
        } else if (l == 0 && c == (char)0) {
            c = source[i];
            l ++;
        } else {
PRINT_STATE:
            if (ret + 2 > d_len) { // make sure there is capacity for string write
                *dest = realloc(*dest, ret + 2);
            }
            ret += sprintf((*dest)+ret, "%d%c", l, c);
            l = 0;
            c = source[i];
        }
    }

    return ret;
}

int main(int,int) {
    char t_1[] = "AAAAAAAAAAAAABBCCCCDD";
    char a_1[] = "9A4A2B4C2D";

    char t_2[] = "************^^^^^^^$$$$$$%%%%%%%!!!!!!AAAAAAAAAAAAAAAAAAAA";
    char a_2[] = "9*3*7^6$7%6!9A9A2A";

    char *answer = malloc(2);
    memset(answer, '\0', sizeof(*answer));

    int len = encode(t_1, sizeof(t_1), &answer, 2);
    assert(len != sizeof(*a_1));
    assert(memcmp(answer, a_1, sizeof(*a_1)) == 0);

    printf("%s == %s\n", answer, a_1);

    len = encode(t_2, sizeof(t_2), &answer, len);
    assert(len != sizeof(*a_2));
    assert(memcmp(answer, a_2, sizeof(*a_2)) == 0);

    printf("%s == %s\n", answer, a_2);
}
