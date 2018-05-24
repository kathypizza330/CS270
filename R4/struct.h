// File:        struct.h
// Description: ... fill this in
// Author:      ... fill this in
// Date:        ... fill this in
// Email:       ... fill this in

// Structure definition
typedef struct
{
    char firstName[80];
    char lastName[80];
    int hw;
    int lab;
    int mid;
    int fin;
    float total;
    char lGrade;
} Student;

// Function Prototypes
void inputScores(Student *student);
void outputScores(Student student);
void calculateScores(Student *student);

