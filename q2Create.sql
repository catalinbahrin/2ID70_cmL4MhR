CREATE INDEX ind_srid ON CourseRegistrations(StudentRegistrationId);
CREATE MATERIALIZED VIEW Info(StudentRegistrationId, GPA, ObtainedECTS, Failed) AS (SELECT cr.StudentRegistrationId, SUM(case when Grade >= 5 then cr.Grade * c.ECTS end)/SUM(case when Grade >= 5 then ECTS*1.0 end), SUM(case when Grade > 5 then ECTS end), MIN(Grade) FROM CourseRegistrations cr, CourseOffers co, Courses c WHERE cr.CourseOfferId = co.CourseOfferId AND co.courseId = c.courseId GROUP BY cr.StudentRegistrationId);
CREATE MATERIALIZED VIEW MaxGrade AS (SELECT co.CourseOfferId, Max(Grade) FROM CourseOffers co, CourseRegistrations cr WHERE co.CourseOfferId = cr.CourseOfferId AND Year = 2018 AND Quartile = 1 GROUP BY co.CourseOfferId);
CREATE MATERIALIZED VIEW GoodStudents AS (SELECT srd.StudentId, COUNT(*) FROM CourseRegistrations cr, MaxGrade mg, StudentRegistrationsToDegrees srd WHERE cr.CourseOfferId = mg.CourseOfferId AND cr.StudentRegistrationId = srd.StudentRegistrationId GROUP BY StudentId);

