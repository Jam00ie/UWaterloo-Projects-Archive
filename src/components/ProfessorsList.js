import React, { Component } from 'react';
import ProfessorListItem from './ProfessorListItem';
import ProfessorDetails from './ProfessorDetails';

export default class ProfessorsList extends Component {
    constructor(props) {
        super(props);
        this.state = { professors: []};
    }

    componentDidMount() {
        fetch(
        'https://weaccelerate-backend.herokuapp.com/professors'
        )
        .then((response) => response.json())
        .then((result) => this.setState({ professors: result }));
    }

    renderProfessors() {
        return this.state.professors.map(professor => <ProfessorListItem key={professor.id} id={professor.id} name={professor.name}/>);
    }

    renderProfessorDetails() {
        if (!details) { return; } // early return since there is nothing to display
        return <ProfessorDetails email={details.email} courses={details.courses} office={details.office} hours={details.hours} />
        }
    
    render() {
        return (
            <>
                <h2>Professors List</h2>
                {this.renderProfessors()}
            </>
        );
    }
}