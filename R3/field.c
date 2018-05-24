#include "field.h"

/** @file field.c
 *  @brief You will modify this file and implement five functions
 *  @details Your implementation of the functions defined in field.h.
 *  You may add other function if you find it helpful. 
 * <p>
 * @author Lingyang Zhu
 */

/** @todo Implement in field.c based on documentation contained in field.h */
int getBit (int value, int position) {
    int result = value>>position;
    result = result&1;
    return result;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int setBit (int value, int position) {
    int mask = 1<<position;
    int result = value|mask;
    return result;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int clearBit (int value, int position) {
    int mask = 1<<position;
    mask = ~mask;
    int result = value&mask;
    return result;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int getField (int value, int hi, int lo, bool isSigned) {
    int size = hi-lo+1;
    int result = value>>lo;
    int mask = 1;
    mask = mask<<size;
    mask = mask-1;
    result = result&mask;
    if (isSigned)
    {
        if (getBit(result, size-1) != 0)
            result = result|~mask;
    }
    return result;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int setField (int oldValue, int hi, int lo, int newValue) {
    int size = hi-lo+1;
    int mask = 1<<size;
    mask = mask-1;
    int target = newValue&mask;
    target = target<<lo;
    mask = mask<<lo;
    mask = ~mask;
    int result = oldValue&mask;
    result = result|target;
    return result;
}

