import React from 'react';

const CourseDetails = ({ course_name, professor, location }) => {
  return (
    <>
      <h5>Course Name: {course_name}</h5>
      <h5>Teaching Staff: {professor}</h5>
      <h5>Location: {location}</h5>
    </>
  );
};

export default CourseDetails;
