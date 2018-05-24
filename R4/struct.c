// File:        struct.c
// Description: R4
// Author:      Lingyang Zhu
// Date:        Sep.14
// Email:       lyzhu@rams.colostate.edu

// Include files
#include "struct.h"
#include <stdio.h>


// Input scores
void inputScores(Student *student)
{
    printf("Enter the first name: ");
    scanf("%s", student->firstName);
    printf("Enter the last name: ");
    scanf("%s", student->lastName);
    printf("Enter the average homework score: ");
    scanf("%d", &student->hw);
    printf("Enter the average lab score: ");
    scanf("%d", &student->lab);
    printf("Enter the midterm score: ");
    scanf("%d", &student->mid);
    printf("Enter the final exam score: ");
    scanf("%d", &student->fin);    
}

// Output scores
void outputScores(Student student)
{
    printf("First name: %s\n", student.firstName);
    printf("Last name: %s\n", student.lastName);
    printf("Average homework score: %d\n", student.hw);
    printf("Average lab score: %d\n", student.lab);
    printf("Midterm score: %d\n", student.mid);
    printf("Final exam score: %d\n", student.fin);
    printf("Total points: %.2f\n", student.total);
    printf("Letter grade: %c\n", student.lGrade);
    printf("\n");
}

// Calculate scores
void calculateScores(Student *student)
{
    student->total = (student->hw * 0.30) + (student->lab * 0.20) + (student->mid * 0.20) + (student->fin * 0.30);
    if (student->total>=90) student->lGrade = 'A';
    else if (student->total>=80) student->lGrade = 'B';
    else if (student->total>=70) student->lGrade = 'C';
    else if (student->total>=60) student->lGrade = 'D';
    else student->lGrade = 'F';
}

