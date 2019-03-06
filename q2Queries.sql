SELECT c.CourseName, cr.Grade FROM CourseRegistrations cr, CourseOffers co, Courses c, StudentRegistrationsToDegrees srd WHERE srd.StudentId = %1% AND srd.DegreeId = %2% AND cr.Grade >= 5 AND srd.StudentRegistrationId = cr.StudentRegistrationId AND cr.CourseOfferId = co.CourseOfferId AND co.CourseId = c.CourseId ORDER BY co.Year, co.Quartile, co.CourseOfferId;
SELECT 0;
WITH ActiveStudentsByG(DegreeId, Gender, nr) AS (SELECT d.DegreeId, s.Gender, COUNT(*) FROM StudentRegistrationsToDegrees srd, Degrees d, Students s, Info i WHERE d.DegreeId = srd.DegreeId AND srd.StudentId = s.StudentId AND i.StudentRegistrationId = srd.StudentRegistrationId AND i.ObtainedECTS < d.TotalECTS GROUP BY d.DegreeId, s.Gender), TotalActiveStudents(DegreeId, nr) AS (SELECT asbg.DegreeId, SUM(nr) FROM ActiveStudentsByG asbg GROUP BY asbg.DegreeId) SELECT tas.DegreeId, asbg.nr/(tas.nr*1.0) AS percentage FROM ActiveStudentsByG asbg,TotalActiveStudents tas WHERE asbg.Gender = 'F' AND asbg.DegreeId = tas.DegreeId ORDER BY tas.DegreeId;
WITH AllStudentsByG(Dept, Gender, nr) AS (SELECT d.Dept, s.Gender, COUNT(*) FROM StudentRegistrationsToDegrees srd, Degrees d, Students s WHERE d.DegreeId = srd.DegreeId AND s.StudentId = srd.StudentId GROUP BY Dept, Gender), TotalStudents(Dept, nr) AS (SELECT asbg.Dept, SUM(asbg.nr) FROM AllStudentsByG asbg GROUP BY asbg.Dept) SELECT asbg.nr/(ts.nr*1.0) AS percentage FROM AllStudentsByG asbg, TotalStudents ts WHERE asbg.Gender = 'F' AND asbg.Dept = ts.Dept AND ts.Dept = %1%;
SELECT sg.CourseId, sum(nr)/(total*1.0) AS percentagePassing FROM StudentsByGrade sg, StudentsByCourse sc WHERE sg.CourseId = sc.CourseId AND sg.Grade >= %1% GROUP BY sg.CourseId, total ORDER BY sg.CourseId;
SELECT * FROM ExcellentStudents WHERE numberOfCoursesWhereExcellent >= %1%;
SELECT d.DegreeId, s.BirthYearStudent, s.Gender, AVG(i.GPA) FROM StudentRegistrationsToDegrees srd, Students s, Degrees d, Info i WHERE d.DegreeId = srd.DegreeId AND srd.StudentId = s.StudentId AND i.StudentRegistrationId = srd.StudentRegistrationId AND i.ObtainedECTS < d.TotalECTS GROUP BY CUBE(d.DegreeId, s.BirthYearStudent, s.Gender) ORDER BY d.DegreeId, s.BirthYearStudent, s.Gender;
WITH NecessarySA(CourseOfferId, nr) AS (SELECT cr.CourseOfferId, COUNT(cr.StudentRegistrationID) FROM CourseRegistrations cr GROUP BY cr.CourseOfferId), ActualSA(CourseOfferId, nr) AS (SELECT CourseOfferId, 50*COUNT(StudentRegistrationId) FROM StudentAssistants GROUP BY CourseOfferId) SELECT c.CourseName, co.Year, co.Quartile FROM NecessarySA nsa, CourseOffers co, Courses c, ActualSA asa WHERE co.CourseOfferId = nsa.CourseOfferId AND co.CourseId = c.CourseId AND asa.CourseOfferId = co.CourseOfferId AND nsa.nr > asa.nr ORDER BY co.CourseOfferId; 
