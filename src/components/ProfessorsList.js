import React, { Component } from 'react';

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
        return this.state.professors.map(professor => (
            <div key={professor.id}>{professor.name}</div>
        ));
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