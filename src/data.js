const data = {
    professors: [
        {
            id: 1,
            name: 'Carrie Mitchell',
            email: 'cmitchell@uwaterloo.ca',
            course_1: 'PLAN 102',
            course_2: 'PLAN 300',
            office: 'EV3 3317',
            hours: '0900-1200 Mon-Fri'
        },
        {
            id: 2,
            name: 'Markus Moos',
            email: 'mmoos@uwaterloo.ca',
            course_1: 'MATH 135',
            course_2: 'N/A',
            office: 'M3 3306',
            hours: '1200-1500 Mon-Fri'
        },
        {
            id: 3,
            name: 'Jennifer Deen',
            email: 'jdeen@uwaterloo.ca',
            course_1: 'ECON 101',
            course_2: 'MSCI 261',
            office: 'EV3 3221',
            hours: '0900-1200 Mon-Fri'
        },
        {
            id: 4,
            name: 'John L. Lewis',
            email: 'j7lewis@uwaterloo.ca',
            course_1: 'SYDE 101L',
            course_2: 'BME 101L',
            office: 'E5 6012',
            hours: '1000-1300 Mon-Fri'
        },
        {
            id: 5,
            name: 'Joe Qian',
            email: 'z3qian@uwaterloo.ca',
            course_1: 'CHEM 266',
            course_2: 'N/A',
            office: 'STC 1253',
            hours: '1200-1500 Mon-Fri'
        },
    ],

    courses: [
        {
            id: 1,
            course_code: 'PLAN 102',
            course_name: 'Professional Communication',
            professor: 'Carrie Mitchell',
            location: 'online'
        },
        {
            id: 2,
            course_code: 'PLAN 300',
            course_name: 'Planning Theory',
            professor: 'Carrie Mitchell',
            location: 'online'
        },
        {
            id: 3,
            course_code: 'MATH 135',
            course_name: 'Algebra for Honours Mathematics',
            professor: 'Markus Moos',
            location: 'MC 4041'
        },
        {
            id: 4,
            course_code: 'ECON 101',
            course_name: 'Introduction to Microeconomics',
            professor: 'Jennifer Deen',
            location: 'DC 1350'
        },
        {
            id: 5, 
            course_code: 'MSCI 261',
            course_name: 'Engineering Economics: Financial Management for Engineers',
            professor: 'Jennifer Deen',
            location: 'E6 2024'
        },
        {
            id: 6,
            course_code: 'SYDE 101L',
            course_name: 'Communications in Systems Design Engineering-Visualization',
            professor: 'John L. Lewis',
            location: 'E5 6008'
        },
        {
            id: 7,
            course_code: 'BME 101L',
            course_name: '	Communications in Biomedical Engineering-Visualization',
            professor: 'John L. Lewis',
            location: 'E5 6008'
        },
        {
            id: 8,
            course_code: 'CHEM 266',
            course_name: 'Basic Organic Chemistry 1',
            professor: 'Joe Qian',
            location: 'M3 1006'
        },
    ],
}

export default data;