import React, { Component } from 'react';

export default class CoursesList extends Component {
    constructor(props) {
        super(props);
        this.state = { courses: []};
    }

    componentDidMount() {
        fetch(
        'https://weaccelerate-backend.herokuapp.com/courses'
        )
        .then((response) => response.json())
        .then((result) => this.setState({ courses: result }));
    }

    renderCourses() {
        return this.state.courses.map(course => (
            <div key={course.id}>{course.course_code}</div>
        ));
    }
    
    render() {
        return (
            <>
                <h2>Courses List</h2>
                {this.renderCourses()}
            </>
        );
    }
}