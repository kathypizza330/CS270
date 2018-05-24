// P1 Assignment
// Author: Lingyang Zhu
// Date:   8/24/2016
// Class:  CS270
// Email:  lyzhu@rams.colostate.edu

// Include files
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

static double input[4];
static double output[4];

void computeCircle (double d0, double *p0)
{
    double area = 3.141593*d0*d0;
    *p0 = area;
}

void computeTriangle (double d1, double *p1)
{
    double area = 0.433013*d1*d1;
    *p1 = area;
}

void computeSquare (double d2, double *p2)
{
    double area = d2*d2;
    *p2 = area;
}

void computePentagon (double d3, double *p3)
{
    double area = 1.720477*d3*d3;
    *p3 = area;
}
    
int main(int argc, char *argv[])
{
    //Check numbers of arguments
    if (argc != 5)
    {
        printf("usage: ./P1 <double> <double> <double> <double>\n");
        return EXIT_FAILURE;
    }
    
    //Convert arguments
    for (int i=1; i<5; i++)
    {
        input[i-1] = atof(argv[i]);
    }
    
    //Call the methods
    computeCircle(input[0], &output[0]);
    computeTriangle(input[1], &output[1]);
    computeSquare(input[2], &output[2]);
    computePentagon(input[3], &output[3]);
    
    //Print the results
    printf("CIRCLE, radius = %.5f, area = %.5f.\n", input[0], output[0]);
    printf("TRIANGLE, length = %.5f, area = %.5f.\n", input[1], output[1]);
    printf("SQUARE, length = %.5f, area = %.5f.\n", input[2], output[2]);
    printf("PENTAGON, length = %.5f, area = %.5f.\n", input[3], output[3]);
    
    //Return success
    return EXIT_SUCCESS;
}

