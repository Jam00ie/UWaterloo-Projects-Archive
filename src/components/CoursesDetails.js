import React from 'react';

// edit for course details
const CoursesDetails = ({ email, courses, office, hours }) => {
  return (
    <>
      <h5>Email: {email}</h5>
      <h5>Courses: {courses}</h5>
      <h5>Office: {office}</h5>
      <h5>Hours: {hours}</h5>
    </>
  };
};

export default ProfessorDetails;
