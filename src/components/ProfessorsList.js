import React, { Component } from 'react';
import ProfessorListItem from './ProfessorListItem';

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
    
    render() {
        return (
            <>
                <h2>Professors List</h2>
                {this.renderProfessors()}
            </>
        );
    }
}