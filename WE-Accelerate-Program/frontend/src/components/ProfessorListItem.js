import React, { useState } from 'react';
import ProfessorDetails from './ProfessorDetails';
import './components.css';

function ProfessorListItem({ id, name}) {

    const [details, setDetails] = useState(null);

    return (
        <div>
            <button
                onClick = {() => {
                    fetch(`https://weaccelerate-backend.herokuapp.com/professor/${id}`)
                    .then ((response) => response.json())
                    .then ((response) => setDetails(response));
                }}>
                {name}
            </button>
            {details && (
                <ProfessorDetails
                    email={details.email}
                    courses={details.courses}
                    office={details.office}
                    hours={details.hours}
                />
            )}
        </div>
    );
}

export default ProfessorListItem;