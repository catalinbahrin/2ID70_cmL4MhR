CREATE INDEX ind_srid ON CourseRegistrations(StudentRegistrationId);
CREATE MATERIALIZED VIEW Info AS (SELECT cr.StudentRegistrationId, SUM(cr.Grade * c.ECTS)/(SUM(ECTS)*1.0) AS GPA, SUM(ECTS) AS ObtainedECTS FROM CourseRegistrations cr, CourseOffers co, Courses c WHERE cr.CourseOfferId = co.CourseOfferId AND co.courseId = c.courseId GROUP BY cr.StudentRegistrationId);
CREATE MATERIALIZED VIEW Calc AS (SELECT CourseId, Grade, COUNT(*) AS nr FROM CourseOffers co, CourseRegistrations cr WHERE co.CourseOfferId = cr.CourseOfferID AND cr.Grade is not null GROUP BY CourseId, grade); 
