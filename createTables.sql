CREATE UNLOGGED TABLE Degrees(DegreeId int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int); 
CREATE UNLOGGED TABLE Students(StudentId int, StudentName varchar(50), Address varchar(200),BirthyearStudent int, Gender char);
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int, StudentId int, DegreeId int, RegistrationYear int);
CREATE UNLOGGED TABLE Teachers(TeacherId int, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char);
CREATE UNLOGGED TABLE Courses(CourseId int, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);
CREATE UNLOGGED TABLE CourseOffers(CourseOfferId int, CourseId int, Year int, Quartile int);
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE StudentAssistants(CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade int);