import React from 'react';
import './components.css';

const ProfessorDetails = ({ email, courses, office, hours }) => {
    return (
        <>
        <h5>Email: {email}</h5>
        <h5>Courses Taught: {courses}</h5>
        <h5>Office Location: {office}</h5>
        <h5>Office Hours: {hours}</h5>
        </>
    );
};
export default ProfessorDetails;