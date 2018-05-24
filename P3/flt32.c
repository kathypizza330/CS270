#include "flt32.h"

/** @file flt32.c
 *  @brief You will modify this file and implement nine functions
 *  @details Your implementation of the functions defined in flt32.h.
 *  You may add other function if you find it helpful. Added function
 *  should be declared <b>static</b> to indicate they are only used
 *  within this file.
 *  <p>
 *  @author Lingyang Zhu
 */
#include <stdio.h>

void printBinary (int value);

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
int flt32_get_sign (flt32 x) {
    int mask = 1<<31;
    if ((x&mask)==mask) return 1;
    return 0; 
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
int flt32_get_exp (flt32 x) {
    int mask = 1<<8;
    mask = mask-1;
    int result = x>>23;
    result = result&mask;
    return result; 
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
int flt32_get_val (flt32 x) {
    int mask = 1<<23;
    mask = mask-1;
    int result = x&mask;
    mask = 1<<23;
    result = result|mask;
    return result;
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
void flt32_get_all(flt32 x, int* sign, int*exp, int* val) {
    *sign = flt32_get_sign(x);
    *exp = flt32_get_exp(x);
    *val = flt32_get_val(x);
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
flt32 flt32_abs (flt32 x) {
    int mask = 1<<31;
    mask = ~mask;
    int result = x&mask;
    return result;
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
flt32 flt32_negate (flt32 x) {
    if (x == 0) return flt32_abs(x);
    int sign = flt32_get_sign(x);
    sign = ~sign;
    sign = sign<<31;
    int mask = 1<<31;
    mask = ~mask;
    int result = x&mask;
    result = result|sign;
    return result;
}

/** @todo Implement in flt32.c based on documentation contained in flt32.h */
flt32 flt32_add (flt32 x, flt32 y) {
    //Special cases
    if (x==0) return y;
    if (y==0) return x;
    if (flt32_negate(x)==y) return 0;
    
    //Get everything
    int x_sign = flt32_get_sign(x);
    int y_sign = flt32_get_sign(y);
    int x_exp = flt32_get_exp(x);
    int y_exp = flt32_get_exp(y);
    int x_val = flt32_get_val(x);
    int y_val = flt32_get_val(y);
    
    //Shift exps
    if (x_exp<y_exp)
    {
        int diff = y_exp-x_exp;
        x_val = x_val>>diff;
        x_exp = x_exp+diff;
    }
    if (y_exp<x_exp)
    {
        int diff = x_exp-y_exp;
        y_val = y_val>>diff;
        y_exp = y_exp+diff;
    }

    //Change signs
    if (x_sign==1)
    {
        x_val = ~x_val;
        x_val = x_val+1;
    }
    if (y_sign==1)
    {
        y_val = ~y_val;
        y_val = y_val+1;
    }

    
    //Add vals
    int result_val = x_val+y_val; 
    
    //Convert results
    int result_sign = flt32_get_sign(result_val);
    if (result_sign==1)
    {
        result_val = ~result_val;
        result_val = result_val+1;
    }
    result_sign = result_sign<<31;
    
    int position = 23;
    //Normalize result
    for (int i = 31; i>=0; i--)
    {
        int temp = result_val;
        temp = temp>>i;
        int mask = 1;
        if ((temp&mask) ==1)
        {
            position = i;
            break;
        }
    }
    
     
    
    
    while (position>23)
    {
        result_val = result_val>>1;
        x_exp = x_exp+1;
        position = position-1;
    }
    while (position<23)
    {
        result_val = result_val<<1;
        x_exp = x_exp-1;
        position = position+1;
    }
    //printf("see position %d\n",position);   
    
    x_exp = x_exp<<23;
    result_val = flt32_get_val(result_val);
    int resultmask = 1<<23;
    result_val = result_val^resultmask;
    //printf("see val %d\n",result_val);   
    //printf("see exp %d\n",flt32_get_exp(x_exp)); 
    //printf("see sign %d\n",flt32_get_sign(result_sign)); 
    
    //Compose result
    int result = 0;
    result = result|x_exp;
    result = result|result_sign;
    result = result|result_val;
    return result;
}



/** @todo Implement in flt32.c based on documentation contained in flt32.h */
flt32 flt32_sub (flt32 x, flt32 y) {
  return flt32_add(x,flt32_negate(y));
}

























