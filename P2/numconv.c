// P2 Assignment
// Author: Lingyang Zhu
// Date:   8/31/2016
// Class:  CS270
// Email:  lyzhu@rams.colostate.edu

// Include files
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
char int2char (int radix, int digit) {
    if (digit>=radix || radix<0 || digit<0)
        return '?';
    char result = digit + '0';
    if (digit>9)
        result = result + 7;
    return result;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
int char2int (int radix, char digit) {
    if (radix<0)
        return -1;
    if ((digit>='0'&&digit<='9')||(digit>='a'&&digit<='z')||(digit>='A'&&digit<='Z'))
    {
    int result = digit - '0';
    if (digit>'9')
        result = result - 7;
    if (digit>='a')
        result = result - 32;
    if (result>=radix)
        return -1;
    return result;
    }
    return -1;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
void divRem (int numerator, int divisor, int* quotient, int* remainder) {
    int number = 0;
    while (numerator>=divisor)
    {
        numerator = numerator - divisor;
        number++;
    }
    int remain = numerator;
    *quotient = number;
    *remainder = remain;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
int ascii2int (int radix, const char *str) {
    int result = 0;
    for (int i = 0; str[i]!=0; i++)
    {
        if (char2int(radix, str[i]) == -1)
            return -1;
        result = result*radix+char2int(radix, str[i]);
    }
    return result;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
void int2ascii (int radix, int value) {
    //Base case
    if (radix > value)
    {
        putchar(int2char(radix, value));
        return;
    }
    //Recursive
    int2ascii(radix, value/radix);
    putchar(int2char(radix, value%radix));
    return;  
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
double ascii2double (int radix, const char *str) {
    double result = 0.0;
    int index = 0;
    int length = 0;
    
    for (int i = 0; str[i]!=0; i++)
    {
        if (str[i] == '.')
            index = i;
    }
        
    for (int i = 0; str[i]!=0; i++)
    {
        length++;
    }
    //debug
    //printf("%d\n",index);
    
    for (int i=0; i<index; i++)
    {
        if (char2int(radix, str[i])==-1)
            return -1.0;
        result = result*radix+char2int(radix, str[i]);
    }
    
    int afterdot = 0;
    
    for (int i = index+1; i<length; i++)
    {
        if (char2int(radix, str[i])==-1)
            return -1.0;
        afterdot = afterdot*radix+char2int(radix, str[i]);
        //printf("    %d\n",char2int(radix, str[i]));
        //printf("%d\n",afterdot);
    }
    
    double power = 1;
    for (int i = 0; i<(length-index-1); i++)
    {
        power = power/radix;
        
    }
    
    result = result+power*afterdot;
    
    return result;
}























