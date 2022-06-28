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
        return this.state.courses.map(course => <CourseListItem key={course.id} id={course.id} course_code={course.course_code} />);
    }
    
    renderCourseDetails() {
        if (!details) { return; } 
        return <CourseDetails course_name={details.course_name} professor={details.professor} location={details.location} />
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
