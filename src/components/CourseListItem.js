import PropTypes from 'prop-types';
import React, { useState } from 'react';

function CourseListItem({ id, course_code}) {

    const [details, setDetails] = useState(null);

    return (
        <div>
            <button
                onClick = {() => {
                    fetch(`https://weaccelerate-backend.herokuapp.com/course/${id}`)
                    .then ((response) => response.json())
                    .then ((response) => setDetails(response));
                }}>
                {course_code}
            </button>
            {details && (
                <div>
                    <div> {details.course_code}</div>
                </div>
            )}
        </div>
    );
}

CourseListItem.propTypes = {
    id: PropTypes.string.isRequired,
    course_code: PropTypes.string.isRequired,
};

export default CourseListItem;
