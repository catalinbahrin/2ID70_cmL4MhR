SELECT c.CourseName, cr.Grade FROM CourseRegistrations cr, CourseOffers co, Courses c, StudentRegistrationsToDegrees srd WHERE srd.StudentId = %1% AND srd.DegreeId = %2% AND cr.Grade >= 5 AND srd.StudentRegistrationId = cr.StudentRegistrationId AND cr.CourseOfferId = co.CourseOfferId AND co.CourseId = c.CourseId ORDER BY co.Year, co.Quartile;
SELECT DISTINCT srd.StudentId FROM StudentRegistrationsToDegrees srd, Info i, Degrees d WHERE srd.StudentRegistrationId = i.StudentRegistrationId AND i.failed >= 5 AND i.GPA > %1% AND d.DegreeId = srd.DegreeId AND d.TotalEcts <= i.ObtainedEcts ORDER BY srd.StudentId; 
WITH ActiveStudents(DegreeId, nrTotal, nrFemale) AS (SELECT d.DegreeId,  COUNT(*), SUM(case when s.Gender = 'F' then 1 else 0 end) FROM StudentRegistrationsToDegrees srd, Degrees d, Students s, Info i WHERE d.DegreeId = srd.DegreeId AND srd.StudentId = s.StudentId AND i.StudentRegistrationId = srd.StudentRegistrationId AND i.ObtainedECTS < d.TotalECTS GROUP BY d.degreeId) SELECT DegreeId, nrFemale/(nrTotal * 1.0) AS pecentage FROM ActiveStudents ORDER BY DegreeId;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
