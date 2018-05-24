// File:        main.c
// Description: ... fill this in
// Author:      ... fill this in
// Date:        ... fill this in
// Email:       ... fill this in

// Include files
#include "struct.h"
#include <stdio.h>
#include <stdlib.h>

Student *std;

// Function:     main
// Description:  entry point  
int main()
{
    //Declare variables
    int studentNumber;
    
    
    printf("Enter the number of students: ");
    scanf("%d", &studentNumber);
    std = malloc(studentNumber * sizeof(Student));
    
    //Call the methods
    for (int i = 0; i<studentNumber; i++)
    {    
        inputScores(&std[i]);
        calculateScores(&std[i]);
        outputScores(std[i]);
    }
    free(std);

    return 0;
}
