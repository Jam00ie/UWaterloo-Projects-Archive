import React, { Component } from 'react';
import CourseListItem from './CourseListItem';

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
        return this.state.courses.map(course => <CourseListItem key={course.id} id={course.id} course_code={course.course_code} />);
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
